;;; crnvl-lsp.el --- Lsp -*- no-byte-compile: t; lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))

(use-package add-node-modules-path
  :hook (typescriptreact-mode . add-node-modules-path))

(use-package lsp-mode
  :hook ((go-mode . (lambda()
                      (lsp)
                      (lsp-go-install-save-hooks)))
         (typescriptreact-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :custom
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-idle-delay 0.300)
  (lsp-log-io nil)
  (lsp-javascript-format-enable nil)
  (lsp-typescript-format-enable nil)
  (lsp-eslint-auto-fix-on-save nil)
  (lsp-eslint-format nil)
  (lsp-go-use-gofumpt t)
  (lsp-register-custom-settings
   '(("gopls.completeUnimported" t t)
     ("gopls.staticcheck" t t)))
  :general-config
  (:states 'normal
           "g r r" 'lsp-find-references
           "g r d" 'lsp-find-definition
           "g r i" 'lsp-find-implementation
           "g r n" 'lsp-rename))


(provide 'crnvl-lsp)

;;; crnvl-lsp.el ends here
