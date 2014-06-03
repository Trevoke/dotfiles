(setq explicit-bash-args '("--noediting" "--login" "-i"))

(require 'em-smart)

(require 'bash-completion)
(bash-completion-setup)

(defadvice ansi-term (after advise-ansi-term-coding-system)
    (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
(ad-activate 'ansi-term)
