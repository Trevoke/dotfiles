(show-paren-mode t)
(setq show-paren-delay 0)

;; cursor moves down from real line to real line
(setq line-move-visual nil);

;; Isn't bash supposed to be emacs-like or something?
(global-set-key (kbd "C-w") 'backward-kill-word)
(global-set-key (kbd "C-x C-k") 'kill-region)

;; highlight current line
(global-hl-line-mode t)

;; tell me on what column the cursor is
(setq column-number-mode t)

;; use ibuffer instead of default buffer
(global-set-key (kbd "C-x C-b") 'ibuffer-other-window)
(setq ibuffer-default-sorting-mode 'major-mode)

;; make buffer names unique
(setq
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")

(setq-default dired-listing-switches "-alhv")

(setq ring-bell-function 'ignore)
