;;; project.el --- Project -*- no-byte-compile: t; lexical-binding t; -*-

(use-package projectile
  :bind ("C-c p" . projectile-command-map)
  :init
  (projectile-mode))

(use-package consult
  :bind (("C-c f f" . consult-fd)
         ("C-c f b" . consult-buffer)
         ("C-c f g" . consult-ripgrep)
         ("C-c f l" . consult-line)))

(use-package consult-flycheck
  :after (consult flycheck))

(use-package embark
  :bind (("C-." . embark-act)))

(use-package embark-consult
  :after (embark consult)
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package wgrep)

;;; project.el ends here
