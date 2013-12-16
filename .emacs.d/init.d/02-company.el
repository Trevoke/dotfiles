(eval-after-load 'company
  '(add-to-list 'company-backends 'company-inf-ruby))

(global-set-key (kbd "C-s") 'company-select-next)
