;;; post-init.el --- Post init -*- no-byle-compile: t; lexical-binding t; -*-

;;; Commentary:

;;; Code:

(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
(define-key key-translation-map (kbd "C-<escape>") (kbd "ESC"))
(define-key key-translation-map (kbd "C-k") (kbd "C-S-<backspace>"))
(global-set-key (kbd "C-c /") #'comment-or-uncomment-region)

(use-package zenburn-theme
  :init
  (load-theme 'zenburn t))

(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-search-module 'evil-search
        evil-ex-complete-emacs-commands nil
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

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package vertico
  :bind (:map minibuffer-local-map
              ("M-h" . backward-kill-word))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package marginalia
  :after vertico
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

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

(use-package projectile
  :bind ("C-c p" . projectile-command-map)
  :init
  (projectile-mode))

(use-package apheleia
  :init
  (apheleia-global-mode +1)
  :hook
  (go-mode . (lambda() (setq apheleia-inhibit t))))

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

(use-package consult
  :bind (("C-c f f" . consult-fd)
         ("C-c f b" . consult-buffer)
         ("C-c f g" . consult-ripgrep)
         ("C-c f l" . consult-line)))

(use-package embark
  :bind (("C-." . embark-act)))

(use-package embark-consult
  :after embark
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package wgrep)

(use-package tree-sitter
  :init
  (global-tree-sitter-mode)
  :hook
  (tree-sitter-after-on . tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :after tree-sitter)

(use-package go-mode
  :after tree-sitter)

(use-package json-mode
  :after tree-sitter)

(use-package typescript-mode
  :after tree-sitter
  :init
  (define-derived-mode typescriptreact-mode typescript-mode
    "TypeScript TSX")
  (add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescriptreact-mode))
  (add-to-list 'tree-sitter-major-mode-language-alist '(typescriptreact-mode . tsx)))

(use-package flycheck
  :init
  (global-flycheck-mode)
  :custom
  (flycheck-idle-change-delay 0)
  (flycheck-check-syntax-automatically '(save))
  (flycheck-disabled-checkers '(emacs-lisp-checkdoc emacs-lisp)))

(use-package lsp-mode
  :hook ((typescriptreact-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :init
  (setq lsp-keymap-prefix "C-c l")
  :custom
  (lsp-enable-symbol-highlighting nil)
  (lsp-ui-doc-show-with-cursor nil)
  (lsp-ui-doc-show-with-mouse nil)
  (lsp-lens-enable nil)
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-idle-delay 0))

(provide 'post-init)

;;; post-init.el ends here
