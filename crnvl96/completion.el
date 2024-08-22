;;; completion.el --- Completion -*- no-byle-compile: t; lexical-binding t; -*-

(use-package company
  :bind (:map company-active-map
              ("<return>". nil)
              ("RET" . nil)
              ("C-<return>" . company-complete-selection)
              ("C-y" . company-complete-selection))
  :custom
  (company-minimum-prefix-length 4)
  :init
  (global-company-mode))

(use-package which-key
  :custom
  (which-key-side-window-location 'bottom)
  :init
  (which-key-mode))

(provide 'completion)

;;; completion.el ends here
