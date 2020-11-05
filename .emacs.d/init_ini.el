;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") 
(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(
    material-theme
    ein
    ))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
;;(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally

(tooltip-mode      -1)
;(menu-bar-mode     -1) ;; отключаем графическое меню
(tool-bar-mode     -1) ;; отключаем tool-bar
;(scroll-bar-mode   -1) ;; отключаем полосу прокрутки
(blink-cursor-mode -1) ;; курсор не мигает
(setq use-dialog-box     nil) ;; никаких графических диалогов и окон - все через минибуфер
;(setq redisplay-dont-pause t)  ;; лучшая отрисовка буфера
(setq ring-bell-function 'ignore) ;; отключить звуковой сигнал
(setq-default indicate-empty-lines t) ;; отсутствие строки выделить глифами рядом с полосой с номером строки

(setq search-highlight        t)
(setq query-replace-highlight t)

(defalias 'yes-or-no-p 'y-or-n-p)

;; scroll one line at a time (less "jumpy" than defaults)
;;(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
;;(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
;;(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq scroll-conservatively 10000)
;; Scrolling settings
(setq scroll-step               1) ;; вверх-вниз по 1 строке
(setq scroll-margin            10) ;; сдвигать буфер верх/вниз когда курсор в 10 шагах от верхней/нижней границы  

;;(package-initialize)
(require 'ergoemacs-mode)
;;(setq ergoemacs-theme nil) ;; Uses Standard Ergoemacs keyboard theme
(setq ergoemacs-ctl-c-or-ctl-x-delay 0.1)

(global-set-key (kbd "M-p") 'ace-window) ;;  switching between buffers
(global-set-key (kbd "C-S-x") 'kill-whole-line) ;;# Sets `C-c d` to `M-x kill-whole-line`

;; fix bug of autocomletion with fci
(defvar-local company-fci-mode-on-p nil)
(defun company-turn-off-fci (&rest ignore)
(when (boundp 'fci-mode)
    (setq company-fci-mode-on-p fci-mode)
    (when fci-mode (fci-mode -1))))
(defun company-maybe-turn-on-fci (&rest ignore)
  (when company-fci-mode-on-p (fci-mode 1)))
(add-hook 'company-completion-started-hook 'company-turn-off-fci)
(add-hook 'company-completion-finished-hook 'company-maybe-turn-on-fci)
(add-hook 'company-completion-cancelled-hook 'company-maybe-turn-on-fci)
;; end bug

;;(pdf-tools-install)
;;(add-hook 'pdf-view-mode-hook (lambda() (linum-mode 0)))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

;; org mode
;;(global-set-key "\C-ca" 'org-agenda) ;; поределение клавиатурных комбинаций для внутренних
;;(global-set-key "\C-cb" 'org-iswitchb) ;; подрежимов org-mode
;;(global-set-key "\C-cl" 'org-store-link)
;;(add-to-list 'auto-mode-alist '("\\.org$" . Org-mode)) ;; ассоциируем *.org файлы с org-mode

;;(global-set-key (kbd "M-9") 'kill-whole-line) ;;# Sets `C-c d` to `M-x kill-whole-line`

;; PYTHON CONFIGURATION
;; --------------------------------------

;;(package-initialize)
; Enable elpy mode
(elpy-enable)
; Fixing a key binding bug in elpy
;;(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
; Fixing another key binding bug in iedit mode
(define-key global-map (kbd "C-c o") 'iedit-mode)
;;(add-hook 'elpy-mode-hook
 ;;         (lambda ()
  ;;          (highlight-indent-guides-mode -1)
   ;;         (highlight-indentation-mode -1)
    ;;        (semantic-stickyfunc-mode -1)))

(with-eval-after-load 'python
  ;;(define-key python-mode-map (kbd "S-<tab>") 'python-indent-shift-left)
  ;;(define-key python-mode-map (kbd "<tab>") 'python-indent-shift-right)
  (define-key python-mode-map (kbd "C-c C-D") 'helm-pydoc)
  )
(defun my-python-tab-command (&optional _)
  "If the region is active, shift to the right; otherwise, indent current line.
Indent the line/region according to the context which is smarter than default Tab/S-Tab"
  (interactive)
  (if (not (region-active-p))
      (indent-for-tab-command)
    (let ((lo (min (region-beginning) (region-end)))
          (hi (max (region-beginning) (region-end))))
      (goto-char lo)
      (beginning-of-line)
      (set-mark (point))
      (goto-char hi)
      (end-of-line)
      (python-indent-shift-right (mark) (point)))))
(with-eval-after-load "python"
  (define-key python-mode-map [remap indent-for-tab-command] 'my-python-tab-command))

(defun select-current-line ()
  "Select the current line"
  (interactive)
 (beginning-of-line) ; move to end of line
  (set-mark (line-end-position)))

;;(defun comment-or-uncomment-line-or-region ()
;;  "comment-or-uncomment-line-or-region"
;;  (interactive)
;;(save-excursion (if (region-active-p) (comment-dwim nil)
 ;; (select-current-line) (comment-dwim nil)
;;  )))

;;(eval-after-load "python"
  ;;'(define-key python-mode-map (kbd "C-/") )
;;(global-set-key (kbd "C-/") #'comment-or-uncomment-line-or-region) ;;# Sets `C-c d` to `M-x kill-whole-line`


(defun comment-or-uncomment-line-or-region ()
  "Comments or uncomments the current line or region."
  (interactive)
  (if (region-active-p)
      (comment-or-uncomment-region (region-beginning) (region-end))
    (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    )
  )

;;(define-key c-mode-base-map (kbd "C-S-/") 'comment-or-uncomment-line-or-region)
;;(global-set-key (kbd "C-<divide>") 'comment-or-uncomment-line-or-region)


(require 'fill-column-indicator) ;;  use rule for line lenght
(add-hook 'python-mode-hook 'fci-mode) ;; use it only on python files
(setq-default fci-rule-column 79)

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(global-set-key (kbd "C-x g") 'magit-status)
;; --------------------------------------



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#ffffff" "#f36c60" "#8bc34a" "#fff59d" "#4dd0e1" "#b39ddb" "#81d4fa" "#263238"))
 '(blink-cursor-mode nil)
 '(custom-enabled-themes '(solarized-light))
 '(custom-safe-themes
   '("d91ef4e714f05fff2070da7ca452980999f5361209e679ee988e3c432df24347" "0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" default))
 '(fci-rule-color "#37474f")
 '(hl-sexp-background-color "#1c1f26")
 '(package-selected-packages
   '(hungry-delete helm-pydoc fill-column-indicator ace-window org-pdftools org-noter pdf-tools solarized-theme magit ein flycheck ergoemacs-mode iedit yasnippet-snippets elpy material-theme))
 '(pdf-view-use-scaling t)
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   '((20 . "#f36c60")
     (40 . "#ff9800")
     (60 . "#fff59d")
     (80 . "#8bc34a")
     (100 . "#81d4fa")
     (120 . "#4dd0e1")
     (140 . "#b39ddb")
     (160 . "#f36c60")
     (180 . "#ff9800")
     (200 . "#fff59d")
     (220 . "#8bc34a")
     (240 . "#81d4fa")
     (260 . "#4dd0e1")
     (280 . "#b39ddb")
     (300 . "#f36c60")
     (320 . "#ff9800")
     (340 . "#fff59d")
     (360 . "#8bc34a")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Mono for Powerline" :foundry "CTDB" :slant normal :weight normal :height 110 :width normal))))
 '(org-export-latex-packages-alist '((«» «cmap» t) («english (\, russian») «babel» t))))

(load-theme 'solarized-dark t)
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

(defun org-export-as-pdf-and-open ()
  (interactive)
  (save-buffer)
  (org-open-file (org-latex-export-to-pdf)))

(add-hook 
 'org-mode-hook
 (lambda()
   (define-key org-mode-map 
       (kbd "C-c C-d") 'org-export-as-pdf-and-open)))
 
;; init.el ends here
