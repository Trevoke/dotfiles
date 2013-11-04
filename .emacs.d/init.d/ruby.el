; If only this didn't slow down startup so much
; (rvm-use-default)

(require 'bundler)

(defun my-ruby-mode-hook ()
  (projectile-mode)
  (robe-mode)
  (ruby-refactor-mode-launch)
  (smartparens-mode)
  (stag-code-modes-hook)
  (local-set-key "\C-m" 'newline-and-indent))

(add-hook 'enh-ruby-mode-hook 'my-ruby-mode-hook)

(require 'slim-mode)
