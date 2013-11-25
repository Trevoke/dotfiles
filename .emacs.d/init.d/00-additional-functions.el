(defun what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
		  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d pos"))))

(defun stag-code-modes-hook ()
  (linum-mode t)
  (local-set-key "\C-m" 'newline-and-indent))
