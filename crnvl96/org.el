;;; org.el --- Org -*- no-byte-compile: t; lexical-binding t; -*-

(require 'org)
(require 'org-habit)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-switchb)

(setq org-log-done t)
(setq org-log-into-drawer t)

;;; org.el ends here
