;;; evil.el --- Evil -*- no-byte-compile: t; lexical-binding t; -*-

(defun evil-key-bindings-for-org ()
  ;;(message "Defining evil key bindings for org")
  (evil-declare-key 'normal org-mode-map
    "gk" 'outline-up-heading
    "gj" 'outline-next-visible-heading
    "H" 'org-beginning-of-line ; smarter behaviour on headlines etc.
    "L" 'org-end-of-line ; smarter behaviour on headlines etc.
    "t" 'org-todo ; mark a TODO item as DONE
    ",c" 'org-cycle
    (kbd "TAB") 'org-cycle
    ",e" 'org-export-dispatch
    ",n" 'outline-next-visible-heading
    ",p" 'outline-previous-visible-heading
    ",t" 'org-set-tags-command
    ",u" 'outline-up-heading
    "$" 'org-end-of-line ; smarter behaviour on headlines etc.
    "^" 'org-beginning-of-line ; ditto
    "-" 'org-ctrl-c-minus ; change bullet style
    "<" 'org-metaleft ; out-dent
    ">" 'org-metaright ; indent
    ))

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
        evil-shift-width 2
        evil-undo-system 'undo-redo)
  (evil-mode)
  :bind (:map evil-normal-state-map
              ([? ] . avy-goto-word-1)
              ([?\r] . er/expand-region)
              ("-" . find-file))
  :config
  (evil-key-bindings-for-org))

(use-package evil-collection
  :after evil
  :config
  (add-to-list 'evil-collection-mode-list 'help)
  (evil-collection-init))

;; (use-package general
;;   :after evil
;;   :config
;;   (general-evil-setup)
;;   (general-create-definer bmacs/leader-keys
;;                           :states '(normal insert visual emacs)
;;                           :keymaps 'override
;;                           :prefix "C-c"))

(use-package ace-window
  :bind ("M-o" . ace-window))

;; (use-package devil
;;   :init
;;   (global-devil-mode))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package  avy
  :bind ("M-s" . avy-goto-char))

;;; evil.el ends here
