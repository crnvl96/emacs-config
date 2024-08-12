;;; crnvl-term.el --- Term -*- no-byte-compile: t; lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package eat
  :general
  (crnvl/leader
    "t" '(:ignore t :wd "Term")
    "t t" '(eat-project :wk "Toggle term at root dir")
    "t T" '(eat :wk "Toggle term at home folder")))

(provide 'crnvl-term)

;;; crnvl-term.el ends here
