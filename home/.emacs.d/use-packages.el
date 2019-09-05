(use-package company
  :ensure t
  :config
  (progn
    (add-hook 'after-init-hook 'global-company-mode)
    (global-set-key (kbd "M-/") 'company-complete-common-or-cycle)
    (setq company-idle-delay 0)))

(use-package flycheck
  :ensure t
  :config
  (progn
    (global-flycheck-mode)))

(use-package helm
  :ensure t
	     )

;(if (require 'ccls nil t)

