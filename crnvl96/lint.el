;;; lint.el --- Lint -*- no-byle-compile: t; lexical-binding t; -*-

(use-package apheleia
  :init
  (apheleia-global-mode +1)
  :hook
  (go-mode . (lambda() (setq apheleia-inhibit t))))

(use-package flycheck
  :init
  (global-flycheck-mode)
  :custom
  (flycheck-idle-change-delay 0)
  (flycheck-check-syntax-automatically '(save))
  (flycheck-disabled-checkers '(emacs-lisp-checkdoc emacs-lisp)))

(provide 'lint)

;;; lint.el ends here
