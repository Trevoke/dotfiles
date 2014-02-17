;; Don't show me the splash screen
(setq inhibit-splash-screen t)

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;(load-theme 'mejelly t)

(add-to-list 'load-path "~/.emacs.d/packages")
(autoload 'mu-open "mu" "Play on MUSHes and MUDs" t)
(add-hook 'mu-connection-mode-hook 'ansi-color-for-comint-mode-on)
(custom-set-variables
 '(mu-worlds (quote (["Discworld" "discworld.starturtle.net" 4242 "" ""]))))

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

;; The Customize stuff is annoying in this file. Let's put it somewhere else.
(setq custom-file
      (concat stag-init-dir "/init-custom.el"))

;; If OSX, then add stuff to emacs' path.
;; also re-enable the menu since it's in the top bar
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (setq ns-use-srgb-colorspace t)
  (menu-bar-mode t))

;; smart mode line
(setq sml/theme 'dark)
(sml/setup)

(require 'flx-ido)
(ido-mode 1)
(ido-ubiquitous 1)
(ido-vertical-mode 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights
(setq ido-use-faces nil)

(smex-initialize)

;;(helm-mode 1)
;;(helm-match-plugin-mode)
;;(global-set-key (kbd "C-c p h") 'helm-projectile)

(require 'smartparens-config)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)

(require 'vimrc-mode)
(add-to-list 'auto-mode-alist '(".vim\\(rc\\)?$" . vimrc-mode))
(require 'gitconfig)

(require 'elixir-mode)

(require 'wgrep)
(autoload 'wgrep-agp-setup "wgrep-ag")
(add-hook 'ag-mode-hook 'wgrep-ag-setup)

;; blindly copied, not sure how to organize this.
(eval-after-load 'auto-complete
  '(add-to-list 'ac-modes 'inf-ruby-mode))
(add-hook 'inf-ruby-mode-hook 'ac-inf-ruby-enable)

(eval-after-load 'inf-ruby
  '(define-key inf-ruby-mode-map (kbd "TAB") 'auto-complete))

(require 'auto-complete-config)
(ac-config-default)

(global-set-key (kbd "\C-c g") 'magit-status)
(global-set-key (kbd "C-h z") 'zeal-at-point)

(prefer-coding-system 'utf-8)
