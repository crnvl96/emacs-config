;;; project.el --- Project -*- no-byte-compile: t; lexical-binding t; -*-

(use-package super-save
  :config
  (setq super-save-auto-save-when-idle t)
  (add-to-list 'super-save-triggers 'ace-window)
  (add-to-list 'super-save-hook-triggers 'find-file-hook)
  (setq auto-save-default nil)
  (super-save-mode +1))

(use-package projectile
  :bind ("C-c p" . projectile-command-map)
  :init
  (projectile-mode))

(use-package golden-ratio
  :init
  (golden-ratio-mode 1)
  :custom
  (golden-ratio-auto-scale t))

(use-package perspective
  :bind
  ("C-x C-b" . persp-list-buffers)      
  :custom
  (persp-mode-prefix-key (kbd "C-c b")) 
  :init
  (persp-mode))

(use-package persp-projectile
  :bind ("C-c p p" . projectile-persp-switch-project))

(use-package consult
  :bind (("C-c f f" . consult-fd)
         ("C-c f b" . consult-buffer)
         ("C-c f g" . consult-ripgrep)
         ("C-c f l" . consult-line))
  :config
  (consult-customize consult--source-buffer :hidden t :default nil)
  (add-to-list 'consult-buffer-sources persp-consult-source))

(use-package consult-flycheck
  :after (consult flycheck))

(use-package embark
  :bind (("C-." . embark-act)))

(use-package embark-consult
  :after (embark consult)
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package wgrep)

;;; project.el ends here
