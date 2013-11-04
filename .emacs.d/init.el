(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

(setq stag-emacs-init-file load-file-name)
(setq stag-emacs-config-dir
      (file-name-directory stag-emacs-init-file))

(setq user-emacs-directory stag-emacs-config-dir)
(setq stag-init-dir (concat stag-emacs-config-dir  "init.d"))


(if (file-exists-p stag-init-dir)
    (dolist (file (directory-files stag-init-dir t "\.el$"))
      (load file)))

(load-theme 'ujelly t)

(defun stag-code-modes-hook ()
  (linum-mode t))

(require 'dynamic-fonts)
(dynamic-fonts-setup)

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights
(setq ido-use-faces nil)

(smex-initialize)

(require 'smartparens-config)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)

(require 'vimrc-mode)
(add-to-list 'auto-mode-alist '(".vim\\(rc\\)?$" . vimrc-mode))
(require 'gitconfig)

(defun all-css-modes ()
  (css-mode)
  (rainbow-mode))

(add-to-list 'auto-mode-alist '("\\.css$" . all-css-modes))
(add-to-list 'auto-mode-alist '("\\.scss$" . all-css-modes))

(require 'sass-mode)

(require 'lorem-ipsum)

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
    ("5c674d297206a2494eff9bf650a2ffbb8261d5a2ee77563b8a6530525fec5b6d" "f89e21c3aef10d2825f2f079962c2237cd9a45f4dc1958091be8a6f5b69bb70c" "8020f88a6175dc3c79d53072c8c677a14a3d24fa165b740995bace5870ae9157" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
