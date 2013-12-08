;;; mu.el --- A MUD/MUSH/MUCK client for Emacs

;; Copyright (C) 2001, 2004  Alex Schroeder <alex@gnu.org>
;; Copyright (C) 2013  Aidan Gauland <aidalgol@amuri.net>

;; Filename: mu.el
;; Keywords: comm, games
;; Author: Alex Schroeder <alex@gnu.org>
;; Maintainer: Aidan Gauland <aidalgol@amuri.net>

;; This file is not part of GNU Emacs.

;; This is free software; you can redistribute it and/or modify it under
;; the terms of the GNU General Public License as published by the Free
;; Software Foundation; either version 3, or (at your option) any later
;; version.
;;
;; This is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
;; FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
;; for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This is is a MUSH or MUD client.  Instead of using telnet or
;; standalone client to connect to your favorite MUSH or MUD, you can
;; use mu.el to play within Emacs.

;; Alex used to play using tinymud.el, but decided to rewrite it based
;; on comint-mode.  :)

;; Before playing, customize `mu-worlds'.  Then use `mu-open' to open
;; a connection to one of the worlds.  This will automaticall create a
;; mu connection buffer and a mu buffer.  You can type commands in
;; either buffer and send them to the host with RET.  The output will
;; be in the mu connection buffer.

;; If you load ansi-color.el, you should be able to get ANSI colors
;; (and bold, underline, etc.).

;;; Code:

(require 'comint)
(require 'cl)
(require 'ansi-color nil t)

(defgroup mu nil
  "A MUSH or MUD client."
  :group 'processes)

(defcustom mu-worlds nil
  "List of worlds you play in.

You need to define the worlds you play in before you can get
started.  In most worlds, you can start playing using a guest
account.

Each element WORLD of the list has the following form:

\[NAME HOST PORT CHARACTER PASSWORD CHAR-PROMPT-REGEX PASSWD-PROMPT-REGEX]

NAME identifies the connection, HOST and PORT specify the network
connection, CHARACTER and PASSWORD are used to connect
automatically.

CHAR-PROMPT-REGEX and PASSWD-PROMPT-REGEX are regular expressions
matching the character name and password prompts from the server.
If they are not *both* set, then CHARACTER and PASSWORD are sent
to the server as \"connect CHARACTER PASSWORD\".

Note that this will be saved in your `custom-file' -- including
your passwords!  If you don't want that, specify nil as your
password."
  :type '(repeat
	  (vector :tag "World"
		  (string  :tag "Name")
		  (string  :tag "Host")
		  (integer :tag "Port")
		  (string  :tag "Character" :value "guest")
		  (string  :tag "Password"  :value "guest")
      (regexp  :tag "Character prompt regexp")
      (regexp  :tag "Password prompt regexp")))
  :group 'mu)

(defcustom mu-highlights nil
  "Alist of highlights for each world.

An alist of highlight triggers, which are also alists, of the form
  ((WORLD . ((REGEXP . FACE) ...) ...))
where WORLD is the name of the world in which any lines matching
REGEXP are given the face FACE.

In the case of multiple regexps matchng a line, each match will
override the previous match."
  :type '(alist :key-type (string :tag "World name")
                :value-type (alist :key-type regexp
                                   :value-type face
                                   :tag "Highlights"))
  :group 'mu)

;; Accessing world fields

(defun mu-world-name (world)
  "Return the name for WORLD as a string."
  (aref world 0))

(defun mu-world-id (world)
  "Return the qualified identifier for WORLD.

Returns the name for WORLD, qualified with the character name in
the form \"CHAR@NAME\"."
  (concat (aref world 3) "@" (aref world 0)))

(defun mu-world-network (world)
  "Return the network details for WORLD as a cons cell (HOST . PORT)."
  (cons (aref world 1) (aref world 2)))

(defun mu-world-character (world)
  "Return the character for WORLD as a string."
  (aref world 3))

(defun mu-world-password (world)
  "Return the password for WORLD as a string."
  (aref world 4))

(defun mu-world-char-prompt-regexp (world)
  "Return the character prompt regexp for WORLD as a string."
  (aref world 5))

(defun mu-world-passwd-prompt-regexp (world)
  "Return the password prompt regexp for WORLD as a string."
  (aref world 6))

(defgroup mu-faces nil
  "MU faces for highlights.

A few predefined faces for highlights, so you don't have to
define your own right away."
  :group 'mu)

(defface mu-highlight-warning
  '((t :weight extra-bold
       :foreground "red"
       :background "yellow"))
  "Make warning messages stand out.

This could be used, for example, to highlight messages that
indicate danger."
  :group 'mu-faces)

(defface mu-highlight-alert
  '((t :foreground "orange red"
       :background "white smoke"))
  "Make important messages stand out.

This could be used, for example, like `mu-highlight-warning', but
when danger is not involved."
  :group 'mu-faces)

(defface mu-highlight-success
  '((t :foreground "green"
       :background "dim grey"))
  "Make success messages stand out.

This could be used, for example, to highlight success messages,
e.g. successfully casting a spell."
  :group 'mu-faces)

;;; Modes

(defvar mu-connection nil
  "Local variable for the connection.")

(defvar mu-connection-mode-map
  (let ((map (make-sparse-keymap)))
    (if (functionp 'set-keymap-parent)
        (set-keymap-parent map comint-mode-map)        ; Emacs
      (set-keymap-parents map (list comint-mode-map))) ; XEmacs
    (if (functionp 'set-keymap-name)
        (set-keymap-name map 'mu-connection-mode-map)) ; XEmacs
    (define-key map (kbd "TAB") 'dabbrev-expand)
    map)
  "Mode map used for `mu-connection-mode'.

Based on `comint-mode-map'.")

(defvar mu-name nil
  "Local variable for the connection name.")

(defun mu-connection-mode (name)
  "Major mode for a mu connection.

Use \\[comint-send-input] to send commands.
Use \\[mu-open] to open other connections.

This function will run `mu-connection-mode-hook' at the end.

\\{mu-connection-mode-map}"
  (comint-mode)
  (setq major-mode 'mu-connection-mode)
  (setq mode-name "MU* Conn")
  (use-local-map mu-connection-mode-map)
  (set (make-local-variable 'mu-name) name)
  ;; User stuff.
  (add-hook 'comint-output-filter-functions 'mu-highlight t t)
  (run-hooks 'mu-connection-mode-hook))

(put 'mu-connection-mode 'mode-class 'special)

(defvar mu-world-history nil
  "History for `mu-get-world'.")

(defun mu-get-world ()
  "Prompt the user for a world from `mu-worlds'.  

The return value is a cons cell, of which the car is the name of
the connection, and the cdr holds the connection defails from
`mu-worlds'."
  (let ((world-completions
         (mapcar (lambda (w)
                   (cons (mu-world-id w) w))
                 mu-worlds)))
    (if world-completions
        (cdr (assoc (completing-read "World: "
                                     world-completions
                                     nil t nil
                                     mu-world-history)
                    world-completions))
      (customize-option 'mu-worlds)
      nil)))

(defun mu-open (world)
  "Create a new mu connection."
  (interactive (list (mu-get-world)))
  (when world
    (message "Opening connection...")
    (let ((buf (make-comint (mu-world-id world) (mu-world-network world))))
      (switch-to-buffer buf)
      (mu-connection-mode (mu-world-id world))
      (setq-local mu-world world)
      (if (or (= 0 (length (mu-world-char-prompt-regexp mu-world)))
              (= 0 (length (mu-world-passwd-prompt-regexp mu-world))))
          (when (and (mu-world-password mu-world)
                     (< 0 (length (mu-world-password mu-world))))
            (mu-login mu-world))
        (add-hook 'comint-output-filter-functions 'mu-login t t))
      (message "Opening connection...done"))))

(defun mu-login (world-or-string)
  "Log in to server in the current buffer.

This function should only be called from `mu-open' or
`comint-output-filter-functions'.

If WORLD-OR-STRING is a world, then this function sends the
\"connect\" command with the character name and password from
WORLD-OR-STRING to the current buffer's process.

If WORLD-OR-STRING is a string, then this function assumes it has
been called as a comint output-filter function, and sends the
world's characer name and password to the current buffer's
process when WORLD-OR-STRING matches the appropriate prompt
regexp (see `mu-worlds').  After the password is send, this
function removes itself from `comint-output-filter-functions'."
  (cl-flet ((mu-send (string)
              (process-send-string (current-buffer)
               (format "%s\n" string))))
    (if (stringp world-or-string)
        (progn
          (when (string-match-p
                 (mu-world-char-prompt-regexp mu-world)
                 world-or-string)
            (mu-send (mu-world-character mu-world)))
          (when (string-match-p
                 (mu-world-passwd-prompt-regexp mu-world)
                 world-or-string)
            (mu-send (mu-world-password mu-world))
            (remove-hook 'comint-output-filter-functions 'mu-login t)))
      (mu-send
       (format "connect %s %s"
               (mu-world-character world-or-string)
               (mu-world-password world-or-string))))))

(defun mu-send ()
  "Send current line to the current connection.

The current connection is stored in `mu-connection'."
  (interactive)
  (unless mu-connection
    (error "No connection"))
  (let ((pos (point)))
    (save-excursion
      (beginning-of-line)
      (process-send-string
       mu-connection
       (concat (buffer-substring-no-properties (point) pos) "\n"))))
  (when (looking-at "\\'")
    (newline)))

(defun mu-highlight (ignored)
  "Apply user highlights to text received from the server.

Applies, in order, `mu-highlights' to the last server output.  If
there are multiple matches, the last highlight overrides previous
matches."
  (when comint-last-output-start
   (save-match-data
     (save-excursion
       (let ((world-name (mu-world-name mu-world)))
         (map nil
              (lambda (pair)
                (goto-char comint-last-output-start)
                (let ((regexp (car pair))
                      (face (cdr pair)))
                  (while (re-search-forward regexp nil t)
                    (replace-match (propertize (match-string 0)
                                               'font-lock-face face)
                                   nil t))))
              (cdr (assoc world-name mu-highlights))))))))

(provide 'mu)

;;; mu.el ends here
