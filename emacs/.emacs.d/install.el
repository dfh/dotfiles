(require 'package)

(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(package-refresh-contents)

(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)

(setq to-install
      '(
;;	smart-mode-line
        ido-vertical-mode
        flx-ido
        idomenu
        exec-path-from-shell
	
        smartscan
        move-text
	paredit
	
        cider
	elpy
        web-mode
        less-css-mode
        markdown-mode
        nginx-mode
        php-mode

	magit
        projectile
	org
	circe
	w3m
        ))

(defun my-install-if-needed (package)
  (unless (package-installed-p package)
    (package-install package)))
(mapc 'my-install-if-needed to-install)
