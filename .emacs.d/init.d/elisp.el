(defun stag-elisp-hook ()
    (local-set-key "\C-m" 'newline-and-indent))

(add-hook 'js-mode-hook 'stag-elisp-hook)
