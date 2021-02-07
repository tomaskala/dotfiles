;; -*- lexical-binding: t; -*-


;; Precompute package activations. Needs Emacs >= 27.
(setq package-quickstart t)

;; Disable filename handlers temporarily, as they are not necessary
;; to parse the configuration.
(defvar old--file-name-handler-alist file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Disable GC on startup.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; Reset GC and the filename handlers after startup.
(add-hook 'emacs-startup-hook
  (lambda ()
    (setq gc-cons-threshold 16777216  ; 16MB
          gc-cons-percentage 0.1
          file-name-handler-alist old--file-name-handler-alist)))

;; Do not resize the frame when other components are resized.
(setq frame-inhibit-implied-resize t)

;; Hide the GUI.
(unless (eq window-system 'ns)
  (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))
(when (fboundp 'tooltip-mode)
  (tooltip-mode -1))

;; Larger frame fringes.
(set-fringe-mode 10)
