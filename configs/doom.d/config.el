;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "yugarinn"
      user-mail-address "yugarinn@proton.me")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Source Code Pro" :size 11)
      doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 12))
;; Big font mode
(setq doom-big-font (font-spec :family "Source Code Pro" :size 21))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org/")
(setq org-roam-directory "~/Dropbox/org/roam/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Web mode
(defun my/web-mode-hook ()
  (setq web-mode-markup-indent-offset 4
        web-mode-code-indent-offset 2
        tab-width 2
        c-basic-offset 2))

(setq web-mode-script-padding 0)
(setq web-mode-style-padding 0)

;; JS mode
(setq js-indent-level 2)
(setq js2-basic-offset 2)

;; Rust mode
(defun my/rust-mode-hook()
  (setq flycheck 1))

;; Hooks
(add-hook 'web-mode-hook 'my/web-mode-hook)
(add-hook 'rust-mode-hook 'my/rust-mode-hook)

;; Journal
(setq org-journal-dir "~/Dropbox/org/journal/")

;; Do not cache non existing file in projectile
(defadvice! dont-cache-if-file-doesnt-exist-a (&rest _)
  :before-until #'projectile-cache-files-find-file-hook
  (and buffer-file-name (file-exists-p buffer-file-name)))

;; FIXME Fix for emacs 27
;; https://github.com/emacs-lsp/lsp-mode/issues/1778
(setq lsp-gopls-codelens nil)

;; Modeline
(setq doom-modeline-vcs-max-length 120)

;; Coffe Mode
(custom-set-variables '(coffee-tab-width 2))

;; Ivy
(require 'ivy-posframe)

(ivy-posframe-mode 1)

;; Hack so posframe is shown in big projects
;; I couldnt find the proper function to bind
(setq ivy-sort-max-size 30000)

(setq ivy-posframe-display-functions-alist
      '((counsel-find-file            . ivy-posframe-display-at-frame-center )
        (counsel-projectile-find-file . ivy-posframe-display-at-frame-center)
        (counsel-file-jump            . ivy-posframe-display-at-frame-center)
        (projectile-find-file         . ivy-posframe-display-at-frame-center)
        (ivy-switch-buffer            . ivy-posframe-display-at-frame-center)
        (counsel-M-x                  . ivy-posframe-display-at-frame-center)
        (t                            . ivy-display-function-fallback)))

(setq ivy-posframe-height-alist '((t . 25)))

(setq ivy-posframe-width 130)
(setq ivy-posframe-border-width 9)

(set-face-attribute 'ivy-posframe nil
                    :foreground "#BFBFBF"
                    :background "#1C1E24")

(ivy-posframe-mode 1)

;; Speed up ivy fuzzy results
(setq gc-cons-threshold 20000000)
