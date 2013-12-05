(defun all-css-modes ()
  (css-mode)
  (rainbow-mode))

(add-to-list 'auto-mode-alist '("\\.css$" . all-css-modes))
(add-to-list 'auto-mode-alist '("\\.scss$" . all-css-modes))

(require 'sass-mode)
(require 'slim-mode)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(require 'lorem-ipsum)
