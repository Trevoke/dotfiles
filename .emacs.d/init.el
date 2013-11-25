;; show me the scratch buffer instead of the splash screen
(setq inhibit-splash-screen t)
(setq initial-buffer-choice t)

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)

;; Deal with OSX ass-hattery
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

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

;; This shouldn't be required with Cask. Used to troubleshoot
;; moe themes on my Gentoo laptop.
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

;; smart mode line
(setq sml/theme 'dark)
(sml/setup)

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

(require 'elixir-mode)

;; blindly copied
(eval-after-load 'auto-complete
  '(add-to-list 'ac-modes 'inf-ruby-mode))
(add-hook 'inf-ruby-mode-hook 'ac-inf-ruby-enable)

(eval-after-load 'inf-ruby
  '(define-key inf-ruby-mode-map (kbd "TAB") 'auto-complete))

(require 'auto-complete-config)
(ac-config-default)

(global-set-key (kbd "\C-c g") 'magit-status)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("0be7333e1d97d55b042f1e28c1b50b870ccc344c8af61bbd6a860e1c8ad9f883" "78eb32ca2bb2c2b71f3ea218d0d7d4260bdb50e64bc1e50451a310ddef48201b" "b2cf3c76acf10bd05cfcd7d3f924f4616c1504484de96be474594c62d59037ba" "70ed2f3b5419fdfd7012d1594773b92c0c0eba5a912a22624fc645f846c1118a" "74c5e4f755ed3d75c7ce9f3f08ea12124b01bbf513a551a40366f65c5d4a8a7a" "bb848b287a4e3162d63141cbacc64949e7dbeb41c944a0ba040785c285f5c9ba" "47583b577fb062aeb89d3c45689a4f2646b7ebcb02e6cb2d5f6e2790afb91a18" "847c431bd5eb5017b601f4c599fb4b23b096e48739e4a708f57ac756358751f0" "5c674d297206a2494eff9bf650a2ffbb8261d5a2ee77563b8a6530525fec5b6d" "f89e21c3aef10d2825f2f079962c2237cd9a45f4dc1958091be8a6f5b69bb70c" "8020f88a6175dc3c79d53072c8c677a14a3d24fa165b740995bace5870ae9157" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
