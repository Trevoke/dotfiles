; If only this didn't slow down startup so much
; (rvm-use-default)

(require 'bundler)

(defun my-ruby-mode-hook ()
  (projectile-mode)
  (robe-mode)
  (ruby-refactor-mode-launch)
  (smartparens-mode)
  (stag-code-modes-hook)
  (auto-complete-mode)
  (inf-ruby-minor-mode)
  (rvm-activate-corresponding-ruby)
  (local-set-key "\C-m" 'newline-and-indent))

(add-hook 'enh-ruby-mode-hook 'my-ruby-mode-hook)
(add-to-list 'auto-mode-alist '("Guardfile" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . enh-ruby-mode))

(require 'slim-mode)

(add-to-list 'inf-ruby-implementations '("pry" . "pry"))
(setq inf-ruby-default-implementation "pry")
(setq inf-ruby-first-prompt-pattern "^\\[[0-9]+\\] pry\\((.*)\\)> *")
(setq inf-ruby-prompt-pattern "^\\[[0-9]+\\] pry\\((.*)\\)[>*\"'] *")
