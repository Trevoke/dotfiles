(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

(require 'dynamic-fonts)
(dynamic-fonts-setup)

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights
(setq ido-use-faces nil)

(load-theme 'ujelly)

(rvm-use-default)

(require 'bundler)

(add-hook 'enh-ruby-mode-hook 'projectile-on)
(add-hook 'enh-ruby-mode-hook 'robe-mode)
(add-hook 'enh-ruby-mode-hook 'ruby-refactor-mode-launch)
(require 'ruby-end)

(require 'vimrc-mode)
(add-to-list 'auto-mode-alist '(".vim\\(rc\\)?$" . vimrc-mode))
(require 'gitconfig)

(smex-initialize)

(require 'slim-mode)
(require 'sass-mode)

(setq x-select-enable-clipboard t)

(require 'expand-region)
(global-set-key (kbd "C-=") 'ex/expand-region)
(global-set-key (kbd "C--") 'ex/contract-region)

(require 'elixir-mode)

(require 'bash-completion)
(bash-completion-setup)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("f89e21c3aef10d2825f2f079962c2237cd9a45f4dc1958091be8a6f5b69bb70c" "8020f88a6175dc3c79d53072c8c677a14a3d24fa165b740995bace5870ae9157" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
