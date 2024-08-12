;;; crnvl-git.el --- Git -*- no-byte-compile: t; lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package magit
  :general
  (crnvl/leader
    "g" '(:ignore t :wd "Magit")
    "g g" '(magit :wk "Toggle magit")))

(provide 'crnvl-git)

;;; crnvl-git.el ends here
