;;; crnvl-keymaps.el --- Keymaps -*- no-byte-compile: t; lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package general
  :after evil
  :init
  (general-evil-setup)

  (general-unbind 'normal
    "g r")

  (general-create-definer crnvl/leader
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "M-SPC")

  (general-define-key
   :keymaps 'minibuffer-local-map
   "M-h" 'backward-kill-word))

(use-package which-key
  :custom
  (which-key-side-window-location 'bottom)
  :init
  (which-key-mode))

(provide 'crnvl-keymaps)

;;; crnvl-keymaps.el ends here
