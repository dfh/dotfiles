;;
;; My Emacs configuration file.
;;
;; Currently one *big mess*.
;;
;; Lots of things ruthlessly stolen from https://github.com/wasamasa/dotemacs/blob/master/init.org.
;;

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
             '("marmalade" "http://marmalade-repo.org/packages/"))
(package-initialize)

;;
;; {{{Basics
;;

;;
;; First off, lets set `exec-path' from shell $PATH.
;;
;; https://github.com/purcell/exec-path-from-shell
;;

(exec-path-from-shell-initialize)

;;
;; Then some "Better defaults". These are taken from Technomancy:
;; https://github.com/technomancy/better-defaults/
;;
;; I don't understand all of the settings in detail, so I have
;; commented them to get at least an idea of what they do.
;;

;; When opening files with identical names in different places,
;; display them like paths. Feels most familiar to me.
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Save place of point in file, and return to it when visited again.
;; Makes sense.
(require 'saveplace)
(setq-default save-place t)

;;
;; First some global keybinds from Better Defaults.
;;
;; TODO move to global keybinds section
;;

;; `hippie-expand' tries a bunch of auto-completion functions.
(global-set-key (kbd "M-/") 'hippie-expand)

;; "Advanced replacement for BufferMenu". Sounds good. Has nice
;; colors, too.
(global-set-key (kbd "C-x C-b") 'ibuffer)

(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR." t)
(global-set-key (kbd "M-z") 'zap-up-to-char)

;; Use regexp versions of fwd/rev incremental search by default.
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

;; "Under X, killing and yanking uses the X clipboard rather than just
;; the primary selection". Also, when copying something from another
;; program and then killing in Emacs, save the clipboard content to
;; the kill ring to not lose it.
(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t)

;; "Apropos commands perform more extensive searches than default."
(setq apropos-do-all t)

;; Insert at point instead of the location of the click.
(setq mouse-yank-at-point t)

;; All crontab lines must end with a newline. If not, the command
;; will be silently ignored. This makes it a *very* good idea to
;; make sure there always is a final newline in there. There might be
;; other similar situations, I don't know.
(setq require-final-newline t)

;; When an explicit filename is not given, `load' tries various possible
;; suffixes. This prevents "elisp bytecode from shadowing more up-to-date
;; source files."
(setq load-prefer-newer t)

;; Make ediff "use the existing frame instead of creating a new one."
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; Save places in ~/.emacs.d/places
(setq save-place-file (concat user-emacs-directory "places")))

;; Save backup files in ~/.emacs.d/backups instead of litter the file
;; system.
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory
					       "backups"))))

;;
;; That was the end of the Better Defaults. Now some other basic
;; settings.
;;

;; I'm not using custom, so make it not touch my init.el!
(setq custom-file "~/.emacs.d/custom.el")

;;
;; UTF-8
;;
;; TODO

;; http://stackoverflow.com/questions/20723229/how-to-reset-emacs-to-save-files-in-utf-8-unix-character-encoding
(set-language-environment 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(set-locale-environment "en.UTF-8")
(prefer-coding-system 'utf-8)
(setq utf-translate-cjk-mode nil) ; disable CJK coding/encoding

;;
;; Folding
;;

;; (add-to-list 'load-path "~/.emacs.d/packages/folding-mode/")
;; (autoload 'folding-mode "folding" "Folding mode" t)
;; (autoload 'turn-off-folding-mode "folding" "Folding mode" t)
;; (autoload 'turn-on-folding-mode "folding" "Folding mode" t)



;;
;; Modes

(transient-mark-mode 1)
(show-paren-mode 1) ; highlights matching parens
(eldoc-mode 1) ; shows docstring in echo area
(projectile-global-mode) ; project integration
;; interferes w/ CIDER REPL ... (global-smartscan-mode 1) ; isearch symbol at point
(ido-mode t)
(ido-everywhere t)
(ido-vertical-mode t)
(flx-ido-mode 1) ; better flex matching -- https://github.com/lewang/flx
;(desktop-save-mode t)

;;
;; Mode hooks

(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js-mode))

(add-hook 'php-mode-hook 'hs-minor-mode)
;;(add-hook 'hs-minor-mode-hook 'hs-org/minor-mode)

;;
;; Formatting

(setq indent-tabs-mode nil)
(setq tab-width 4)
(setq js-indent-level 4)
(setq comment-column 0) ; always put comment directly after end of line
(setq comment-fill-column nil)
(setq fill-column 70)
(setq sentence-end-double-space nil) ; *one* space between sentences
(setq next-line-add-newlines t)	; add newline when C-n at EOF

(blink-cursor-mode 0)
(setq visible-bell t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-linum-mode 1)
(column-number-mode 1)
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)

;; always use short prompt (y/n instead of yes/no)
(defalias 'yes-or-no-p 'y-or-n-p)

;;
;; Mode line
;;
;; https://github.com/Malabarba/smart-mode-line

;; (sml/setup)

;; ;; The version of Solarized that I'm using does not set sml colors.
;; ;; Setting to 'respectful tries to use colors from current theme.
;; (setq sml/theme 'respectful
;;       sml/shorten-directory t
;;       sml/shorten-modes t
;;       sml/name-width 40
;;       sml/mode-width 'full ; full -> right-align everything after minor modes
;;       sml/replacer-regexp-list
;;       '()
;;       )

;; ;; https://github.com/Malabarba/smart-mode-line/blob/master/smart-mode-line.el
;; (custom-set-faces
;;  `(sml/modes ((t :foreground ,solarized-base0 :weight bold)))
;;  `(sml/minor-modes ((t :foreground ,solarized-base01)))
;;  `(sml/filename ((t :foreground ,solarized-base0 :weight bold)))
;;  `(sml/folder ((t :foreground ,solarized-base00)))
;;  `(sml/modified ((t :foreground ,solarized-green)))
;;  `(sml/git ((t :foreground ,solarized-base0)))
;;  `(sml/line-number ((t :foreground ,solarized-base01)))
;;  `(sml/col-number ((t :foreground ,solarized-base01)))
;;  `(sml/mule-info ((t :foreground ,solarized-base01)))
;;  `(sml/position-percentage ((t :foreground ,solarized-base01)))
;;  `(sml/vc-edited ((t :foreground ,solarized-base00))))

;;
;; Color theme
;;
;; I use my own version of the Solarized theme, based on sellout's,
;; bbatsov's and wasama's.
;;
;; https://github.com/sellout/emacs-color-theme-solarized
;; https://github.com/bbatsov/solarized-emacs
;; https://github.com/wasamasa/dotemacs/blob/master/theme/my-solarized-theme.el.
;;
;; See theme/my-solarized-theme.el for details.

;; http://ergoemacs.org/emacs/emacs_list_and_set_font.html
(setq initial-frame-alist '((font . "DejaVu Sans Mono-14")))
(setq default-frame-alist '((font . "DejaVu Sans Mono-14")))
;; TODO remove?
(custom-set-faces
 '(default ((t (:height 140 :family "DejaVu Sans Mono")))))

(setq custom-theme-load-path '("~/.emacs.d/theme/" t))
(load-theme 'my-solarized t t) ; t t -> no-confirm & enable
(enable-theme 'my-solarized)

;;
;; {{{circe
;;
;; Emacs ??? IRC.
;;
;; I'm quite new to IRC, so this setup is pretty basic.
;;
;; First I tried rcirc, but I couldn't get the authentication to the ZNC bouncer
;; to work. Or SSL. I don't remember. Then I tried ERC, but I had some problem
;; with it, too. I found Circe, and so far it has been working well. I'm quite new
;; to IRC, so my setup is pretty basic. I got a lot of it from wasamasa on GitHub,
;; see link below.
;;
;; https://github.com/wasamasa/dotemacs/blob/master/init.org#circe
;;

;;
;; First set up my identity and part/quit messages to be quite anonymous.
;;

(setq circe-default-realname "David"
      circe-default-nick "dfh"
      circe-default-user "david"
      circe-default-realname "David"
      circe-default-part-message "Bye bye birdie"
      circe-default-quit-message "Bye bye birdie")

;;
;; I connect through a local ZNC, because I want playback on some
;; low-traffic personal channels.
;;
;; To keep passwords out of the config file and out of Git, lets
;; define them as variables in a separate file.
;;

(load-file "~/secrets/emacs.el")
(setq circe-network-options
      `(("Freenode"
         :host "dumpen"
         :port 8251
         :tls t
         :user "admin/Freenode"
         :pass ,dumpen-znc-password,
         :nickserv-password ,freenode-password
         )))

;;
;; I find logging quite nice, so lets log everything.
;;

(load "lui-logging" nil t)
(setq lui-logging-directory "~/nexus/storage/logs/circe/")
(enable-lui-logging-globally)

;;
;; Basic tweaks.
;;

;; Cycle through tab-completed nicks, please.
(setq circe-use-cycle-completion t)

;; Hide JOIN, PART & QUIT messages for lurkers.
(setq circe-reduce-lurker-spam t)

;; Set a couple of format strings.
(setq circe-format-self-say "<{nick}> {body}"
      circe-format-say "<{nick}> {body}"
      circe-format-server-topic "*** Topic change by {origin}: {topic-diff}"
      circe-server-buffer-name "{network}"
      circe-prompt-string (propertize ">>> " 'face 'circe-prompt-face))

;; Display timestamps in the right margin.
(setq lui-time-stamp-position 'right-margin
      lui-time-stamp-format "%H:%M")
(add-hook 'lui-mode-hook 'my-circe-set-margin)
(defun my-circe-set-margin ()
  (setq right-margin-width 5))

;; Ask to use an external autopaste service when pasting many lines.
(require 'lui-autopaste)
(add-hook 'circe-channel-mode-hook 'enable-lui-autopaste)

;; Highlight all nicks in current channel (and not only in own messages).
(require 'circe-highlight-all-nicks)
(enable-circe-highlight-all-nicks)

;;
;; Extra keybindings.
;;
;; Make C-l redraw and reposition to bottom of window.
;;

(defun my-move-to-bottom ()
  "Moves point to end of buffer, and repositions to bottom of window."
  (interactive)
  (goto-char (point-max))
  (recenter-top-bottom -1))

(with-eval-after-load 'lui
  (define-key lui-mode-map (kbd "C-l") 'my-move-to-bottom))

;;
;; Entry point
;;

(defun my-irc ()
  (interactive)
  (circe "Freenode"))

;;}}}








;;
;; News Ticker
;;
;; Feed reader for Emacs. I set it up to use w3m for rendering HTML.
;; w3m must be installed separately, e.g. "sudo port install w3m".
;;
;; TODO Customize fetch interval.
;;

;; (require 'newsticker)
;; (require 'w3m)
;; (setq newsticker-html-renderer 'w3m-region
;;       newsticker-url-list-defaults nil)
;; (setq newsticker-url-list '(
;;                             ("Brandon Invergo" "http://brandon.invergo.net/atom.xml")
;;                             ))
;; (newsticker-start)

;;
;; Elisp

(define-key emacs-lisp-mode-map (kbd "M-.") 'find-function-at-point)

;;
;; ido-mode -- find files and buffers with fuzzy matching

;; use flx-ido highlighting instead of ido-mode
(setq ido-use-faces nil)
(setq ido-enable-flex-matching t)

;;
;; Paredit

;; http://www.emacswiki.org/emacs/ParEdit
;; (autoload FUNCTION FILE &optional DOCSTRING INTERACTIVE TYPE)
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of List code." t)
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)

;;
;; Dired

;;(require 'dired+)
;;(toggle-diredp-find-file-reuse-dir t) ; reuse buffers

;;
;; CIDER

(setq cider-show-error-buffer nil) ; don't show error buffer in REPL automatically


;;
;; Magit

(setq magit-last-seen-setup-instructions "1.4.0")

;;
;; Python

(elpy-enable)
(elpy-use-ipython)

;;
;; Org

(setq org-catch-invisible-edits 'show)
(defun my-org-copy-link ()
  "Copy link location at point to kill ring."
  (interactive)
  (when (org-in-regexp org-bracket-link-regexp 1)
    (kill-new (org-link-unescape (org-match-string-no-properties 1)))))

;;
;; org-present

(defvar org-present-text-scale 6)
(add-hook 'org-present-mode-hook
	  (lambda ()
	    (org-present-big)
	    (org-display-inline-images)
	    (org-present-hide-cursor)))
(add-hook 'org-present-mode-quit-hook
	  (lambda ()
	    (org-present-small)
	    (org-remove-inline-images)
	    (org-present-show-cursor)))

;;
;; GTD

(setq org-agenda-files '("~/nexus/nexus/todo.org"))

;;
;; Info

;; manually installed info docs
(eval-after-load 'info
  (progn
    ;; macports on os x
    '(push "/opt/local/share/info/" Info-default-directory-list)
    '(push "/usr/local/share/info/" Info-default-directory-list)))

;;
;; Global key bindings.
;;

;;
;; OS X with a Microsoft NEK 4000 keyboard, I have Caps Lock bound to Ctrl,
;; right and left Ctrl to Command, Alt to alt, and the Windows key and
;; application key (between Alt and Ctrl) to Fn. Mapping Fn to Hyper gives me an
;; extra modifier key, which is nice.
;;
(setq ns-function-modifier 'hyper)

;; http://www.emacswiki.org/emacs/FullScreen#toc26
(global-set-key (kbd "H-f") 'toggle-frame-fullscreen)
(global-set-key (kbd "M-i") 'idomenu)
(global-set-key (kbd "<f12>") (lambda() (interactive) (find-file "~/nexus/nexus/todo.org")))
(global-set-key (kbd "<f11>") (lambda() (interactive) (find-file "~/nexus/nexus/journal.org")))
(global-set-key (kbd "<f10>") (lambda() (interactive) (find-file "~/nexus/nexus/maybe.org")))
(global-set-key (kbd "<f9>") (lambda() (interactive) (find-file "~/nexus/nexus/done.org")))
(global-set-key (kbd "<f8>") (lambda() (interactive) (find-file "~/nexus/nexus/$.org")))
(global-set-key (kbd "<f7>") (lambda() (interactive) (find-file "~/.emacs.d/init.el")))
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region)
(global-set-key (kbd "H-p") 'move-text-up)
(global-set-key (kbd "H-n") 'move-text-down)
(global-set-key (kbd "C-<return>") 'hs-toggle-hiding)
					;(global-set-key (kbd "C-c s") 'hs-show-all)
					;(global-set-key (kbd "C-c h") 'hs-hide-all)
(global-set-key (kbd "H-b") (lambda() (interactive) (switch-to-buffer (other-buffer (current-buffer) 1 ))))
(global-set-key (kbd "H-g") 'magit-status)
(global-set-key (kbd "C-c t") 'my-visit-term-buffer)
(global-set-key (kbd "H-u") 'browse-url)
(global-set-key (kbd "H-x") 'eval-buffer)

(define-key key-translation-map (kbd "H-[") (kbd "??"))
(define-key key-translation-map (kbd "H-'") (kbd "??"))
(define-key key-translation-map (kbd "H-;") (kbd "??"))
(define-key key-translation-map (kbd "H-1") (kbd "???"))


;;
;; My functions

(defun my-delete-process-interactive ()
  "Deletes a process."
  (interactive)
  (let ((pname (ido-completing-read "Process name: "
				    (mapcar 'process-name (process-list)))))
    (delete-process (get-process pname))))


					; http://stackoverflow.com/questions/17635860/emacs-search-and-replace-with-regular-expressions
(defun my-delete-linebreaks-between-tags (start end)
  "Deletes linebreaks and indentation."
  (interactive "*r")
  (replace-regexp "\\(?:\\(?1:>\\)\n\\s-+\\)\\|\\(?:\n\\s-+\\(?1:<\\)\\)" "\\1" nil start end)
  (forward-line))

(defun my-put-css-on-one-line (start end)
  "Puts all CSS rules in region on a single line."
  (interactive "*r")
  (replace-regexp "\\({\\|;\\)\n\\s-+" "\\1 " nil start end)
  (forward-line))

(defun my-visit-term-buffer ()
  "Create or visit an ansi-term buffer. http://emacsredux.com/blog/2013/03/29/terminal-at-your-fingertips/"
  (interactive)
  (if (not (get-buffer "*ansi-term*"))
      (progn
	(split-window-sensibly (selected-window))
	(other-window 1)
	(ansi-term (getenv "SHELL")))
    (switch-to-buffer-other-window "*ansi-term*")))


;;
;; GPG

(when (file-executable-p "/opt/local/bin/gpg")
  (setq epg-gpg-program "/opt/local/bin/gpg"))

