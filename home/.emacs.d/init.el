;;; init.el --- An emacs startup file

;;-----------------------------------------------------------------------------
;; Some functions of dubious utility
;;-----------------------------------------------------------------------------
(defun add-to-load-path (dir)
  (if (file-exists-p dir)
      (add-to-list 'load-path (expand-file-name dir))))

(defun scroll-up-in-place(n)
  "Like scroll-up, but one line."
  (interactive "p")
  (scroll-up n))

;; Random testing
(defun zzz (n)
  "This function is for random testing"
  (interactive "p")
  (vi-mode)
  (vi-find-matching-paren)
  (latex-mode)
)

;;-----------------------------------------------------------------------------
;; Dump custom-set-variables to an external file
;;-----------------------------------------------------------------------------
(setq custom-file "~/.emacs.d/custom-file.el")
(when (file-exists-p custom-file)
  (load-file custom-file))

;;-----------------------------------------------------------------------------
;; Key bindings
;;-----------------------------------------------------------------------------
;; key         meaning                                previous value
;; -------     -------------------------              -------------------------
;; ALT-c       Compile
;; ALT-s       Load emacs lisp file                   'undefined
;; CTL-t       Goto line number
;; ALT-]       Scroll up in place
;; ALT-r       Revert buffer                          go to center of window
;; CTL-L       Recenter                               recenter + highlight
;;-----------------------------------------------------------------------------
(global-set-key "\M-e" 'erase-buffer)
(global-set-key "\M-r" 'revert-buffer)
(global-set-key "\M-c" 'compile)
(global-set-key "\C-t" 'goto-line)
(define-key global-map "\M-s" 'load-file)
(define-key global-map "\M-]" 'revert-buffer)

;; Stupid emacs changed ^l to include highlighting of code, which is 
;; very, very slow.  Bad emacs!  Bad! Bad!
(global-set-key "\C-l" 'recenter)

;; Tell emacs not to background when hitting CTRL-z
(global-set-key "\C-Z" nil)

;; Emacs dorkily changed CTRL-x SPC to rectangle-mark-mode ???
(global-set-key (kbd "C-x SPC") 'gud-break)

;;-----------------------------------------------------------------------------
;; Package management
;;-----------------------------------------------------------------------------
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")))
  ;add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/"))
  t)
(package-initialize)

;;-----------------------------------------------------------------------------
;; use-package
;;-----------------------------------------------------------------------------
(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))

;;-----------------------------------------------------------------------------
;; C++ IDE features
;; Ref: http://martinsosic.com/development/emacs/2017/12/09/emacs-cpp-ide.html
;; See also cquery reference in comments
;;-----------------------------------------------------------------------------
(if (and (require 'use-package nil t)
	 (file-exists-p "~/.emacs.d/use-packages.el"))
    (load-file "~/.emacs.d/use-packages.el"))

;;-----------------------------------------------------------------------------
;; Clipboard
;;-----------------------------------------------------------------------------
;; I like to make emacs use the clipboard better
;; This below works for xemacs, but what about emacs?
;(setq x-select-enable-clipboard t)
;(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;;-----------------------------------------------------------------------------
;; Backup files
;;-----------------------------------------------------------------------------
(setq backup-directory-alist `(("." . "~/.emacs-backups")))
(if (not (file-directory-p "~/.emacs-backups"))
    (make-directory "~/.emacs-backups"))

;;-----------------------------------------------------------------------------
;; Magit
;;-----------------------------------------------------------------------------
(setq backup-directory-alist `(("." . "~/.emacs-backups")))
(if (not (file-directory-p "~/.emacs-backups"))
    (make-directory "~/.emacs-backups"))

;;-----------------------------------------------------------------------------
;; LISP
;;-----------------------------------------------------------------------------
(put 'lambda    'lisp-indent-hook 'defun)
(put 'progn     'lisp-indent-hook 0)
(put 'loop      'lisp-indent-hook 0)
(put 'prog1     'lisp-indent-hook 1)
(put 'when      'lisp-indent-hook 1)
(put 'unless    'lisp-indent-hook 1)
(put 'block     'lisp-indent-hook 1)
(put 'catch     'lisp-indent-hook 1)
(put 'let       'lisp-indent-hook 1)
(put 'let*      'lisp-indent-hook 1)
(put 'flet      'lisp-indent-hook 1)
(put 'labels    'lisp-indent-hook 1)
(put 'merge     'lisp-indent-hook 1)
(put 'dolist    'lisp-indent-hook 1)
(put 'dotimes   'lisp-indent-hook 1)
(put 'case      'lisp-indent-hook 1)
(put 'multiple-value-bind 'lisp-indent-hook 1)
(put 'with-open-file      'lisp-indent-hook 1)
(put 'unwind-protect      'lisp-indent-hook 1)
(put 'use-package         'lisp-indent-hook 1)

;; How to force style for emacs-lisp mode?
;;((emacs-lisp-mode
;;  (indent-tabs-mode nil)))

;;-----------------------------------------------------------------------------
;; C/C++/Java
;;-----------------------------------------------------------------------------
;; Don't indent namespace
;; http://groups.google.com/group/gnu.emacs.help/browse_thread/thread/31edd5b417119d72?pli=1
(c-add-style 
 "plm-codingstyle"
 '((c-basic-offset . 4)
   (c-comment-only-line-offset . 0)
   (c-hanging-braces-alist . ((substatement-open before after)))
   (indent-tabs-mode . nil)
   (c-noise-macro-names . ("PLMSYS_API" "PLMBASE_API" "PLMUTIL_API" 
			   "PLMREGISTER_API" "PLMDOSE_API"
			   "PLMRECONSTRUCT_API"))
   (c-offsets-alist 
    . (
       (access-label               . -)
       (arglist-intro              . +)
       (arglist-cont-nonempty      . +)
       (arglist-close              . 0)
       (inline-open                . 0)
       (innamespace                . 0)
       (label                      . 0)
       ;;(statement-block-intro      . 0)
       (statement-cont             . 4)
       (stream-op                  . 4)
       (substatement-open          . 0)
       (template-args-cont         . +)
       ;; This can occur in places where indentation is and is not
       ;; desirable.  What to do??
;;       (topmost-intro-cont         . +)
       (topmost-intro-cont         . c-lineup-topmost-intro-cont)
       ))))

(c-add-style 
 "slicer-codingstyle"
 '((c-basic-offset . 2)
   (c-comment-only-line-offset . 0)
   (c-hanging-braces-alist . ((substatement-open before after)))
   (indent-tabs-mode . nil)
   (c-offsets-alist 
    . (
       (access-label               . -)
       (arglist-intro              . +)
       (arglist-cont-nonempty      . +)
       (arglist-close              . 0)
       (inline-open                . 0)
       (innamespace                . 0)
       (label                      . 0)

       ;; This is based on SlicerRt ...
       (statement-block-intro      . +)
       (substatement-open          . 0)

       ;;(statement-cont             . 4)
       ;;(stream-op                  . 4)
       ;;(substatement-open          . 0)
       ))))

(c-add-style 
 "topas-codingstyle"
 '((c-basic-offset . 4)
   (c-indent-level . 4)
   (tab-width . 4)
   (c-comment-only-line-offset . 0)
   (c-hanging-braces-alist . ((substatement-open before after)))
   (indent-tabs-mode . t)
   (c-offsets-alist 
    . (
       (access-label               . -)
       (arglist-intro              . +)
       ;;(arglist-cont-nonempty      . +)
       (arglist-close              . 0)
       (inline-open                . 0)
       (innamespace                . 0)
       (label                      . 0)

       ;; This is based on SlicerRt ...
       (statement-block-intro      . +)
       (substatement-open          . 0)

       ;;(statement-cont             . 4)
       ;;(stream-op                  . 4)
       ;;(substatement-open          . 0)
       ))))

(c-add-style 
 "tramp-codingstyle"
 '((c-basic-offset . 2)
   (c-comment-only-line-offset . 0)
   (c-hanging-braces-alist . ((substatement-open before after)))
   (indent-tabs-mode . nil)
   (c-offsets-alist 
    . (
       (access-label               . -)
       (arglist-intro              . +)
       (arglist-cont-nonempty      . +)
       (arglist-close              . 0)
       (inline-open                . 0)
       (innamespace                . 0)
       (label                      . 0)

       ;; This is based on SlicerRt ...
       (statement-block-intro      . +)
       (substatement-open          . 0)

       ;;(statement-cont             . 4)
       ;;(stream-op                  . 4)
       ;;(substatement-open          . 0)
       ))))

;; Choose whether to use slicer-style or plastimatch-style indentation
;; Ref: http://www.emacswiki.org/emacs/IndentingC
(defun choose-c-style ()
  (if (buffer-file-name)
      ;; choose coding style based on filename
      (cond ((or (string-match "Slicer" buffer-file-name)
		 (string-match "PlmSlicerBspline" buffer-file-name)
		 (string-match "SlicerRt" buffer-file-name)
		 )
	     (c-set-style "slicer-codingstyle"))
	    ((string-match "topas" buffer-file-name)
	     (c-set-style "topas-codingstyle"))
	    ((string-match "dicom_tramp" buffer-file-name)
	     (c-set-style "tramp-codingstyle"))
	    (t (c-set-style "plm-codingstyle")))
    ;; else if not buffer-file-name
    (c-set-style "plm-codingstyle")))
(add-hook 'c-mode-common-hook 'choose-c-style)

;; Fire up .h, .icc, .txx, etc files into C++ mode
(set 'auto-mode-alist (append '(("\\.h\\'" . c++-mode)) auto-mode-alist))
(set 'auto-mode-alist (append '(("\\.cl\\'" . c++-mode)) auto-mode-alist))
(set 'auto-mode-alist (append '(("\\.cu\\'" . c++-mode)) auto-mode-alist))
(set 'auto-mode-alist (append '(("\\.icc\\'" . c++-mode)) auto-mode-alist))
(set 'auto-mode-alist (append '(("\\.txx\\'" . c++-mode)) auto-mode-alist))
(set 'auto-mode-alist (append '(("\\.hxx\\'" . c++-mode)) auto-mode-alist))
(set 'auto-mode-alist (append '(("\\.i\\'" . c++-mode)) auto-mode-alist))

;; Stupid Emacs thinks that .m is an Objective C file!  Fie!
(setq auto-mode-alist (delete '("\\.m\\'" . objc-mode) auto-mode-alist))

;;-----------------------------------------------------------------------------
;; semantic-refactor
;;-----------------------------------------------------------------------------
(when (require 'srefactor nil t)
    (require 'srefactor-lisp)

  (semantic-mode 1)
  (define-key c-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
  (define-key c++-mode-map (kbd "M-RET") 'srefactor-refactor-at-point)
  (global-set-key (kbd "M-RET o") 'srefactor-lisp-one-line)
  (global-set-key (kbd "M-RET m") 'srefactor-lisp-format-sexp)
  (global-set-key (kbd "M-RET d") 'srefactor-lisp-format-defun)
  (global-set-key (kbd "M-RET b") 'srefactor-lisp-format-buffer))

;;-----------------------------------------------------------------------------
;; Octave/Matlab
;;-----------------------------------------------------------------------------
;; Choose whether to use matlab mode or octave mode
;;(setq auto-mode-alist (cons '("\\.m$" . matlab-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.m$" . octave-mode) auto-mode-alist))

;; Matlab mode (distinct from octave mode)
;;(autoload 'matlab-mode "matlab" "Enter Matlab mode." t)

;; Emacs 24 likes this
;;(require 'octave nil t)

(defun my-matlab-mode-hook ()
  ;; See matlab.el for more variable that can be user defined...
  ;; (setq matlab-function-indent t)  ; if you want function bodies indented
  ;; (setq matlab-indent-function t) ; t or nil.  if t indent function body
  (setq matlab-indent-level 4)
  (setq fill-column 76)            ; where auto-fill should wrap
  (setq matlab-comment-region-s "% ") ;this is the prefix for comments    
  (turn-on-auto-fill)  
  (font-lock-mode 1)  ;; To get font-lock try adding
  ;(matlab-mode-hilit)   ;; To get hilit19 support try adding
  (define-key matlab-mode-map "\C-u\C-c;" 'matlab-uncomment-region)
)
(setq matlab-mode-hook 'my-matlab-mode-hook)
(defun matlab-uncomment-region (beg-region end-region)
     (interactive "*r")
     (matlab-comment-region beg-region end-region t))

;;-----------------------------------------------------------------------------
;; Basic
;;-----------------------------------------------------------------------------
;(require 'basic nil noerror)

;;-----------------------------------------------------------------------------
;; Python
;;-----------------------------------------------------------------------------
;; (autoload 'python-mode "python-mode" "Python Mode." t)
;; (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;; (add-to-list 'auto-mode-alist '("\\.rpy\\'" . python-mode))
;; (add-to-list 'interpreter-mode-alist '("python" . python-mode))
;; (add-hook 'python-mode-hook
;; 	  (lambda ()
;; 	    (setq indent-tabs-mode nil
;; 		  tab-width 2)
;; 	    (set (make-variable-buffer-local 'beginning-of-defun-function)
;; 		 'py-beginning-of-def-or-class)
;; 	    (setq outline-regexp "def\\|class ")))

;;-----------------------------------------------------------------------------
;; Javascript
;;-----------------------------------------------------------------------------
(autoload #'espresso-mode "espresso" "Start espresso-mode" t)
(add-to-list 'auto-mode-alist '("\\.js$" . espresso-mode))

;;-----------------------------------------------------------------------------
;; JSON
;;-----------------------------------------------------------------------------
;(add-to-list 'auto-mode-alist '("\\.json$" . espresso-mode))
;(add-to-list 'auto-mode-alist '("\\.json$" . json))
(require 'json nil t)

;;-----------------------------------------------------------------------------
;; CMake
;;-----------------------------------------------------------------------------
(autoload 'cmake-mode "cmake-mode" "Start CMake mode" t)
(setq auto-mode-alist
      (append '(("CMakeLists\\.txt\\'" . cmake-mode)
		("\\.cmake\\'" . cmake-mode))
	      auto-mode-alist))
;; Apparently the indent is hard coded to 2
;; http://pokpolx.blogspot.com/2009/06/setting-tab-indent-width-on-emacs-cmake.html
(setq cmake-tab-width 2)

;;-----------------------------------------------------------------------------
;; LaTeX/BiBTex
;;-----------------------------------------------------------------------------
(setq bibtex-maintain-sorted-entries t)

;;-----------------------------------------------------------------------------
;; Perl
;;-----------------------------------------------------------------------------
(setq-default
 ;; cperl-electric-parens t 
 ;; cperl-electric-keywords t
 cperl-indent-level 4
 ;; cperl-hairy t
 ;; cperl-auto-newline t
 cperl-mode-map nil
 cperl-extra-newline-before-brace nil
 )

(add-hook 'cperl-mode-hook
	  (function (lambda ()
		      (setq cperl-basic-offset 4)
		      )))

(set 'auto-mode-alist (append '(("\\.PL\\'" . cperl-mode)) auto-mode-alist))
(set 'auto-mode-alist (append '(("\\.pl\\'" . cperl-mode)) auto-mode-alist))

;;-----------------------------------------------------------------------------
;; CSS
;;-----------------------------------------------------------------------------
(autoload 'css-mode "css-mode")
(setq auto-mode-alist (cons '("\\.css\\'" . css-mode) auto-mode-alist))
;; GCS: This disables japanese!
;; (custom-set-variables
;;   ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
;;   ;; Your init file should contain only one such instance.
;;  '(case-fold-search t)
;;  '(current-language-environment "Latin-1")
;;  '(default-input-method "latin-1-prefix")
;;  '(inhibit-startup-screen t))

;;-----------------------------------------------------------------------------
;; SLIME
;;-----------------------------------------------------------------------------
(setq inferior-lisp-program "/usr/bin/sbcl")

;;-----------------------------------------------------------------------------
;; W3M
;; http://www.emacswiki.org/cgi-bin/wiki/emacs-w3m
;;-----------------------------------------------------------------------------
(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;; optional keyboard short-cut
(global-set-key "\C-xm" 'browse-url-at-point)

;;-----------------------------------------------------------------------------
;; Fonts
;;-----------------------------------------------------------------------------
(defun font-existsp (font)
  (if (null (x-list-fonts font))
      nil t))

;; Hmm, this might work
(set-face-attribute 'default nil :height 120)

;; This is for gelato
;(if (string-equal system-name "gelato.mgh.harvard.edu")
;    (set-default-font 
;     "-misc-fixed-medium-r-normal--20-200-75-75-c-100-iso8859-1"))

;; icecream has poor choice for highlight background color
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(region ((t (:background "gray" :distant-foreground "gtk_selection_fg_color")))))


;;-----------------------------------------------------------------------------
;; Miscellany
;;-----------------------------------------------------------------------------
;; Spelling
(if (file-executable-p "C:/cygwin/bin/aspell")
    (setq ispell-program-name "C:/cygwin/bin/aspell"))

;; Disable a couple of commands
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; What is this?
(put 'eval-expression 'disabled nil)

;; Turn off the dorky tool bar
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))

;; Always show line number
(line-number-mode t)
(column-number-mode t)
(put 'erase-buffer 'disabled nil)
