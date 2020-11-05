;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") 
(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(material-theme
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

(package-initialize)
(require 'ergoemacs-mode)
(setq ergoemacs-theme nil) ;; Uses Standard Ergoemacs keyboard theme

(pdf-tools-install)
(add-hook 'pdf-view-mode-hook (lambda() (linum-mode 0)))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))

;; org mode
;;(global-set-key "\C-ca" 'org-agenda) ;; поределение клавиатурных комбинаций для внутренних
;;(global-set-key "\C-cb" 'org-iswitchb) ;; подрежимов org-mode
;;(global-set-key "\C-cl" 'org-store-link)
;;(add-to-list 'auto-mode-alist '("\\.org$" . Org-mode)) ;; ассоциируем *.org файлы с org-mode

;; PYTHON CONFIGURATION
;; --------------------------------------

(package-initialize)
; Enable elpy mode
(elpy-enable)
; Fixing a key binding bug in elpy
;;(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
; Fixing another key binding bug in iedit mode
(define-key global-map (kbd "C-c o") 'iedit-mode)

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
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (solarized-light)))
 '(custom-safe-themes
   (quote
    ("d91ef4e714f05fff2070da7ca452980999f5361209e679ee988e3c432df24347" "0598c6a29e13e7112cfbc2f523e31927ab7dce56ebb2016b567e1eff6dc1fd4f" default)))
 '(fci-rule-color "#37474f")
 '(hl-sexp-background-color "#1c1f26")
 '(package-selected-packages
   (quote
    (org-pdftools org-noter pdf-tools solarized-theme magit ein flycheck ergoemacs-mode iedit yasnippet-snippets elpy material-theme)))
 '(pdf-view-use-scaling t)
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#f36c60")
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
     (360 . "#8bc34a"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Mono for Powerline" :foundry "CTDB" :slant normal :weight normal :height 110 :width normal))))
 '(org-export-latex-packages-alist (quote ((«» «cmap» t) («english (\, russian») «babel» t)))))

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
