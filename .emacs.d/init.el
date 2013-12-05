;; Don't show me the splash screen
(setq inhibit-splash-screen t)

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'mejelly t)

;; The next few lines set up auto-loading of config files
;; below the init.d directory 
(setq stag-emacs-init-file load-file-name)
(setq stag-emacs-config-dir
      (file-name-directory stag-emacs-init-file))

(setq user-emacs-directory stag-emacs-config-dir)
(setq stag-init-dir (concat stag-emacs-config-dir  "init.d"))

(if (file-exists-p stag-init-dir)
    (dolist (file (directory-files stag-init-dir t "\.el$"))
      (load file)))

;; If OSX, then add stuff to emacs' path.
;; also re-enable the menu since it's in the top bar
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (menu-bar-mode t))

;; smart mode line
(setq sml/theme 'dark)
(sml/setup)

(global-set-key (kbd "C-h z") 'zeal-at-point)

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

(require 'elixir-mode)

;; blindly copied, not sure how to organize this.
(eval-after-load 'auto-complete
  '(add-to-list 'ac-modes 'inf-ruby-mode))
(add-hook 'inf-ruby-mode-hook 'ac-inf-ruby-enable)

(eval-after-load 'inf-ruby
  '(define-key inf-ruby-mode-map (kbd "TAB") 'auto-complete))

(require 'auto-complete-config)
(ac-config-default)

(global-set-key (kbd "\C-c g") 'magit-status)

(prefer-coding-system 'utf-8)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("a77b40f749e8c3aaa4172c298e694eafe0030511470ff3406201c3915b811fa7" "67ccaa34f304fecf5b7e5a078f9b7106b0c3b8bc8ec83803d2cad935be875531" default)))
 '(line-number-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
