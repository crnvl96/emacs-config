;;; git.el --- Git -*- no-byle-compile: t; lexical-binding t; -*-

(use-package magit
  :commands magit)

(use-package transient
  :after magit)

(use-package diff-hl
  :hook((magit-pre-refresh . diff-hl-magit-pre-refresh)
        (magit-post-refresh . diff-hl-magit-post-refresh))
  :custom
  (diff-hl-show-staged-changes nil)
  :init
  (global-diff-hl-mode))

;;; git.el ends here
