;;; crnvl-project.el --- Project -*- no-byte-compile: t; lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package evil-nerd-commenter
  :after evil
  :general
  (:states '(normal visual)
           "g c" 'evilnc-comment-or-uncomment-lines))

(use-package consult
  :general
  (crnvl/leader
    "f" '(:ignore t :wk "Files")
    "f f" '(consult-fd :wk "Find files")
    "f b" '(consult-buffer :wk "Find Buffers")
    "s" '(:ignore t :wk "Search")
    "s g" '(consult-ripgrep :wk "Search in project")
    "s l" '(consult-line :wk "Search buffer")))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package projectile
  :config
  (projectile-mode +1)
  :general
  (crnvl/leader
    "p" '(:ignore t :wk "Project")
    "p p" '(projectile-switch-project :wk "Swich project")
    "p f" '(projectile-find-file :wk "Find file in project")
    "p g" '(projectile-ripgrep :wk "Grep project")))


(provide 'crnvl-project)

;;; crnvl-project.el ends here
