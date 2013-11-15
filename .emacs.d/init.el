(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(setq stag-emacs-init-file load-file-name)
(setq stag-emacs-config-dir
      (file-name-directory stag-emacs-init-file))

(setq user-emacs-directory stag-emacs-config-dir)
(setq stag-init-dir (concat stag-emacs-config-dir  "init.d"))


(if (file-exists-p stag-init-dir)
    (dolist (file (directory-files stag-init-dir t "\.el$"))
      (load file)))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'moe-dark t)

(defun stag-code-modes-hook ()
  (linum-mode t))

;; TODO remove this and see what changes
(require 'dynamic-fonts)
(dynamic-fonts-setup)

;; TODO remove this and see what changes. Is smex enough to keep me happy?
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

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(require 'lorem-ipsum)

(require 'elixir-mode)

(require 'bash-completion)
(bash-completion-setup)

(require 'auto-complete-config)
(ac-config-default)

;; blindly copied
(eval-after-load 'auto-complete
  '(add-to-list 'ac-modes 'inf-ruby-mode))
(add-hook 'inf-ruby-mode-hook 'ac-inf-ruby-enable)

(eval-after-load 'inf-ruby
  '(define-key inf-ruby-mode-map (kbd "TAB") 'auto-complete))

(global-set-key (kbd "\C-c g") 'magit-status)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("bb848b287a4e3162d63141cbacc64949e7dbeb41c944a0ba040785c285f5c9ba" "47583b577fb062aeb89d3c45689a4f2646b7ebcb02e6cb2d5f6e2790afb91a18" "847c431bd5eb5017b601f4c599fb4b23b096e48739e4a708f57ac756358751f0" "5c674d297206a2494eff9bf650a2ffbb8261d5a2ee77563b8a6530525fec5b6d" "f89e21c3aef10d2825f2f079962c2237cd9a45f4dc1958091be8a6f5b69bb70c" "8020f88a6175dc3c79d53072c8c677a14a3d24fa165b740995bace5870ae9157" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
