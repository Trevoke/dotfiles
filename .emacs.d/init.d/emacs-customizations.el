;; Remove scrollbar, toolbar, menu
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; put the backup files in there
(setq backup-directory-alist '(("." . "~/.emacs.backups")))

;; Stop using the Meta key.
(global-set-key "\C-x\C-m" 'execute-extended-command)

(show-paren-mode t)
(setq show-paren-delay 0)

;; cursor moves down from real line to real line
(setq line-move-visual nil);

;; Play nice with OS clipboard
(setq x-select-enable-clipboard t)

;; Isn't bash supposed to be emacs-like or something?
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)

;; highlight current line
(global-hl-line-mode t)

;; tell me on what column the cursor is
(setq column-number-mode t)

;; wrap at word
(global-visual-line-mode t)

;; backup files in emacs config dir 
(setq backup-directory-alist
      (list (cons "." (expand-file-name "backup" user-emacs-directory))))

;; use ibuffer instead of default buffer

(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer-other-window)
(setq ibuffer-default-sorting-mode 'major-mode)

;; make buffer names unique
(require 'uniquify)
(setq 
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")
