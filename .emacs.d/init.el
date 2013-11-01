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

; put the backup files in there
(setq backup-directory-alist '(("." . "~/.emacs.backups")))

; Stop using the Meta key.
(global-set-key "\C-x\C-m" 'execute-extended-command)

; Play nice with OS clipboard
(setq x-select-enable-clipboard t)

; Isn't bash supposed to be emacs-like or something?
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)

; highlight current line
(global-hl-line-mode t)

(require 'expand-region)
(global-set-key (kbd "C-=") 'ex/expand-region)
(global-set-key (kbd "C--") 'ex/contract-region)

(load-theme 'ujelly t)

; If only this didn't slow down startup so much
; (rvm-use-default)

(require 'bundler)

(add-hook 'enh-ruby-mode-hook 'projectile-mode)
(add-hook 'enh-ruby-mode-hook 'robe-mode)
(add-hook 'enh-ruby-mode-hook 'ruby-refactor-mode-launch)
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
    ("47583b577fb062aeb89d3c45689a4f2646b7ebcb02e6cb2d5f6e2790afb91a18" "847c431bd5eb5017b601f4c599fb4b23b096e48739e4a708f57ac756358751f0" "b668ea4e7b3a5f4a7ff4fbaad4e9cf84fe5200a9fabfb9f8ac9204cc4a3d15bd" "f89e21c3aef10d2825f2f079962c2237cd9a45f4dc1958091be8a6f5b69bb70c" "8020f88a6175dc3c79d53072c8c677a14a3d24fa165b740995bace5870ae9157" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
