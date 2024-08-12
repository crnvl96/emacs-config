;;; crnvl-completion.el --- Completion -*- no-byte-compile: t; lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package company
  :general
  (:keymaps 'company-active-map
            "<return>" nil
            "RET" nil
            "C-<return>" 'company-complete-selection
            "C-y" 'company-complete-selection)
  :custom
  (company-minimum-prefix-length 2)
  (company-tooltip-align-annotations t)
  :hook (after-init . global-company-mode))

(use-package company-box
  :after company
  :hook (company-mode . company-box-mode))

(use-package flycheck
  :hook
  (after-init . global-flycheck-mode))

(provide 'crnvl-completion)

;;; crnvl-completion.el ends here
