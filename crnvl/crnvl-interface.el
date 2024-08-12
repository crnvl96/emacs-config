;;; crnvl-interface.el --- Interface -*- no-byte-compile: t; lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package vertico
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode)
  :general-config
  (:keymaps 'vertico-map
            "C-j" 'vertico-next
            "C-k" 'vertico-previous
            "C-g" 'vertico-exit))

(use-package marginalia
  :after vertico
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(provide 'crnvl-interface)

;;; crnvl-interface.el ends here
