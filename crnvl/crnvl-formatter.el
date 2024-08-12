;;; crnvl-formatter.el --- Formatter -*- no-byte-compile: t; lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(use-package apheleia
  :init
  (apheleia-global-mode +1)
  :hook
  (go-mode . (lambda() (setq apheleia-inhibit t)))
  :general-config
  (crnvl/leader
    "c" '(:ignore t :wd "Code")
    "c f" '(apheleia-format-buffer :wk "Format buffer")))


(provide 'crnvl-formatter)

;;; crnvl-formatter.el ends here
