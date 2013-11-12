(defun stag-js-hook ()
    (local-set-key "\C-m" 'newline-and-indent))

(add-hook 'js-mode-hook 'stag-js-hook)
