(require 'bundler)

(defun my-ruby-mode-hook ()
  (rvm-activate-corresponding-ruby)
  (projectile-mode)
  (robe-mode)
  (ruby-refactor-mode-launch)
  (push 'company-robe company-backends)
  (smartparens-mode)
  (stag-code-modes-hook)
  (rspec-mode))

(add-hook 'enh-ruby-mode-hook 'my-ruby-mode-hook)
(add-hook 'projectile-mode-hook 'projectile-rails-on)
(add-to-list 'auto-mode-alist '("Guardfile" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '(".pryrc" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . enh-ruby-mode))

(add-to-list 'inf-ruby-implementations '("pry" . "pry"))
(setq inf-ruby-default-implementation "pry")
(setq inf-ruby-first-prompt-pattern "^\\[[0-9]+\\] pry\\((.*)\\)> *")
(setq inf-ruby-prompt-pattern "^\\[[0-9]+\\] pry\\((.*)\\)[>*\"'] *")

(setq company-idle-delay 0.1)
(setq company-minimum-prefix-length 2)

(defun inf-ruby-completion ()
  (company-mode))

(add-hook 'inf-ruby-mode-hook 'inf-ruby-completion)
