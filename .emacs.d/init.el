(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

; Just give me emacs.
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(require 'dynamic-fonts)
(dynamic-fonts-setup)

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights
(setq ido-use-faces nil)

(smex-initialize)

(global-set-key "\C-m" 'newline-and-indent)

; put the backup files in there
(setq backup-directory-alist '(("." . "~/.emacs.backups")))

; Stop using the Meta key.
(global-set-key "\C-x\C-m" 'execute-extended-command)

(show-paren-mode t)
(setq show-paren-delay 0)

; Play nice with OS clipboard
(setq x-select-enable-clipboard t)

; Isn't bash supposed to be emacs-like or something?
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)

; highlight current line
(global-hl-line-mode t)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)

(load-theme 'ujelly t)

; If only this didn't slow down startup so much
; (rvm-use-default)

(require 'bundler)

(defun my-ruby-mode-hook ()
  (projectile-mode)
  (robe-mode)
  (ruby-refactor-mode-launch)
  (local-set-key "\C-m" 'newline-and-indent))

(add-hook 'enh-ruby-mode-hook 'my-ruby-mode-hook)
(require 'ruby-end)

(require 'vimrc-mode)
(add-to-list 'auto-mode-alist '(".vim\\(rc\\)?$" . vimrc-mode))
(require 'gitconfig)


(require 'slim-mode)
(require 'sass-mode)

(require 'elixir-mode)

(require 'bash-completion)
(bash-completion-setup)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("f89e21c3aef10d2825f2f079962c2237cd9a45f4dc1958091be8a6f5b69bb70c" "8020f88a6175dc3c79d53072c8c677a14a3d24fa165b740995bace5870ae9157" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
