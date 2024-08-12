;;; crnvl-evil.el --- Evil -*- no-byte-compile: t; lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(setq evil-want-keybinding nil)

(use-package evil
  :init
  (setq evil-want-integration t
        evil-vsplit-window-right t
        evil-split-window-below t
        evil-want-C-i-jump t
        evil-want-C-u-scroll t
        evil-want-Y-yank-to-eol t
        evil-search-module 'evil-search
        evil-undo-system 'undo-redo)
  (evil-mode))

(use-package evil-collection
  :after evil
  :config
  (add-to-list 'evil-collection-mode-list 'help)
  (evil-collection-init))

(provide 'crnvl-evil)

;;; crnvl-evil.el ends here
