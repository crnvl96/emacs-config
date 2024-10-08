;;; post-init.el --- Post init -*- no-byte-compile: t; lexical-binding t; -*-

(menu-bar-mode -1)                      ; no menu bar
(tool-bar-mode -1)                      ; no tools bar
(scroll-bar-mode -1)                    ; no scroll bars
(set-fringe-mode 10)                    ; frame edges set to 10px
(column-number-mode 1)                  ; absolute numbering
(recentf-mode 1)                        ; remember recent files
(save-place-mode 1)                     ; remember cursor position
(savehist-mode 1)                       ; enable history saving
(delete-selection-mode t)               ; overwrite selected text when typing
(global-hl-line-mode 1)                 ; enable current line highlight
(global-visual-line-mode t)             ; visual line breaking
(global-auto-revert-mode 1)             ; update externaly edited files
(global-display-line-numbers-mode 1)    ; always show line numbers

(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
(define-key key-translation-map (kbd "C-<escape>") (kbd "ESC"))

(use-package wgrep)
;; (use-package ace-window)
;; (use-package avy)
;; (use-package devil)

(use-package doom-themes
  :init (load-theme 'doom-nord t))


(use-package tree-sitter
  :defer t
  :init (global-tree-sitter-mode)
  :hook (tree-sitter-after-on . tree-sitter-hl-mode))

(use-package tree-sitter-langs)

;; (use-package centered-cursor-mode
;;   :init
;;   (global-centered-cursor-mode))

(use-package nerd-icons)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package super-save
  :defer t
  :config
  (setq super-save-auto-save-when-idle t
        auto-save-default nil)
  (add-to-list 'super-save-hook-triggers 'find-file-hook)
  (super-save-mode +1))

(use-package which-key
  :defer t
  :custom
  (which-key-idle-delay 0.2)
  (which-key-side-window-location 'bottom)
  (which-key-prefix-prefix "◉ ")
  (which-key-sort-order 'which-key-key-order-alpha)
  (which-key-min-display-lines 3)
  (which-key-max-display-columns nil)
  (which-key-setup-minibuffer)
  :init (which-key-mode))

(use-package golden-ratio
  :defer t
  :init (golden-ratio-mode 1)
  :config (setq golden-ratio-auto-scale t))

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
  :config
  (evil-declare-key 'normal org-mode-map
    "<" 'org-metaleft
    ">" 'org-metaright))

(use-package evil-collection
  :config
  (add-to-list 'evil-collection-mode-list 'help)
  (evil-collection-init))

(use-package company
  :bind (:map company-active-map
              ("<return>". nil)
              ("RET" . nil)
              ("C-<return>" . company-complete-selection)
              ("C-y" . company-complete-selection))
  :custom (company-minimum-prefix-length 4)
  :init (global-company-mode))

(use-package projectile
  :bind ("C-c p" . projectile-command-map)
  :init (projectile-mode))

(use-package consult
  :bind (:prefix-map find
                     :prefix "C-c f"
                     ("f" . projectile-find-file)
                     ("b" . projectile-switch-to-buffer)
                     ("B" . projectile-ibuffer)
                     ("t" . projectile-run-vterm-other-window)
                     ("g" . consult-ripgrep)
                     ("l" . consult-line)))

(use-package consult-flycheck)

(use-package embark
  :bind ("C-." . embark-act))

(use-package embark-consult
  :hook (embark-collect-mode . consult-preview-at-point-mode))

(use-package magit
  :commands magit)

(use-package transient)

(use-package diff-hl
  :hook((magit-pre-refresh . diff-hl-magit-pre-refresh)
        (magit-post-refresh . diff-hl-magit-post-refresh))
  :custom
  (diff-hl-show-staged-changes nil)
  :init
  (global-diff-hl-mode))

(use-package dap-mode 
  :commands dap-debug
  :bind (:prefix-map debug
                     :prefix "C-c d"
                     ("d" . dap-debug))
  :config
  (require 'dap-node) 
  (dap-node-setup)
  (dap-register-debug-template
   "Launch File"
   (list :type "node"
         :request "launch"
         :program "${workspaceFolder}/src/server/index.ts"
         :outFiles ["${workspaceFolder}/public/src/server/**/*.js"]
         :name "Launch File"))
  (dap-register-debug-template
   "Attach to NestJS"
   (list :type "node"
         :request "attach"
         :name "Attach to NestJS"
         :cwd "${workspaceFolder}"
         :source-maps t
         :protocol "inspector"
         :skip-files ["<node_internals>/**", "node_modules/**"]
         :resolve-source-map-locations ["${workspaceFolder}/**", "!**/node_modules/**"])))

(use-package json-mode)

(use-package typescript-mode
  :init
  (define-derived-mode typescriptreact-mode typescript-mode
    "TypeScript TSX")
  (add-to-list 'auto-mode-alist '("\\.tsx?\\'" . typescriptreact-mode))
  (add-to-list 'tree-sitter-major-mode-language-alist '(typescriptreact-mode . tsx)))

(use-package apheleia
  :init
  (apheleia-global-mode +1))

(use-package flycheck
  :init
  (global-flycheck-mode)
  (progn
    (define-fringe-bitmap 'my-flycheck-fringe-indicator
      (vector #b00000000
              #b00000000
              #b00000000
              #b00000000
              #b00000000
              #b00000000
              #b00000000
              #b00011100
              #b00111110
              #b00111110
              #b00111110
              #b00011100
              #b00000000
              #b00000000
              #b00000000
              #b00000000
              #b00000000))

    (flycheck-define-error-level 'error
      :severity 2
      :overlay-category 'flycheck-error-overlay
      :fringe-bitmap 'my-flycheck-fringe-indicator
      :fringe-face 'flycheck-fringe-error)

    (flycheck-define-error-level 'warning
      :severity 1
      :overlay-category 'flycheck-warning-overlay
      :fringe-bitmap 'my-flycheck-fringe-indicator
      :fringe-face 'flycheck-fringe-warning)

    (flycheck-define-error-level 'info
      :severity 0
      :overlay-category 'flycheck-info-overlay
      :fringe-bitmap 'my-flycheck-fringe-indicator
      :fringe-face 'flycheck-fringe-info))
  :custom
  (flycheck-idle-change-delay 0)
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

(use-package lsp-ui
  :init
  (setq lsp-ui-sideline-enable t
        lsp-ui-doc-enable t
        lsp-ui-peek-enable t
        lsp-ui-peek-always-show t))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles basic partial-completion)))))

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

(setq minibuffer-prompt-properties
      '(read-only t cursor-intangible t face minibuffer-prompt))

(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

(use-package vterm
  :commands vterm
  :config
  (setq vterm-max-scrollback 10000
        term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

(require 'org)
(require 'org-habit)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(provide 'post-init)

;;; post-init.el ends here
