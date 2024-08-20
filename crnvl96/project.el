(use-package projectile
  :diminish projectile-mode
  :config
  (projectile-mode))

(use-package apheleia
  :init
  (apheleia-global-mode +1)
  :hook
  (go-mode . (lambda() (setq apheleia-inhibit t))))

(use-package magit
  :commands magit)

(use-package consult
  :bind (("C-c f f" . consult-fd)
         ("C-c f b" . consult-buffer)
         ("C-c s g" . consult-ripgrep)
         ("C-s" . consult-line)))

(use-package embark
  :bind (("C-." . embark-act)       
         ("C-;" . embark-dwim)       
         ("C-h B" . embark-bindings)))

(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))
