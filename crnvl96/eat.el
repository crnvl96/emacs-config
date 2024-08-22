;;; eat.el --- Eat -*- no-byle-compile: t; lexical-binding t; -*-

(use-package eat
  :bind (("C-c t T" . eat)
         ("C-c t t" . eat-project)
         ("C-c t y" . eat-yank)))

(provide 'eat)

;;; eat.el ends here
