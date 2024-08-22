;;; evil.el --- Evil -*- no-byle-compile: t; lexical-binding t; -*-

(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-search-module 'evil-search
        evil-ex-complete-emacs-commands t
        evil-vsplit-window-right t
        evil-split-window-below t
        evil-shift-round nil
        evil-want-C-u-scroll t
        evil-want-Y-yank-to-eol t
        evil-undo-system 'undo-redo)
  (evil-mode))

(use-package evil-collection
  :after evil
  :config
  (add-to-list 'evil-collection-mode-list 'help)
  (evil-collection-init))


;;; evil.el ends here
