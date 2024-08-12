;;; crnvl-themes.el --- Themes -*- no-byte-compile: t; lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package doom-themes
  :init
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-moonlight t)
  (doom-themes-org-config))

(provide 'crnvl-themes)

;;; crnvl-themes.el ends here
