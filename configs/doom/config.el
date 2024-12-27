;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Me
(setq user-full-name "yugarinn"
      user-mail-address "yugarinn@proton.me")

;; Fonts
(defvar regular-font-size
  (cond ((string-equal (system-name) "soyuz2") 11)
        ((string-equal (system-name) "vostok1") 12)
        ((string-equal (system-name) "vostok2") 13)
        (t 10)))

(defvar big-font-size
  (cond ((string-equal (system-name) "soyuz1") 17)
        ((string-equal (system-name) "vostok1") 18)
        (t 17)))

(setq doom-font (font-spec :family "Source Code Pro" :size regular-font-size)
      doom-variable-pitch-font (font-spec :family "Source Code Pro" :size regular-font-size :weight 'semi-bold))
(setq doom-big-font (font-spec :family "Source Code Pro" :size big-font-size))

;; UI
(setq doom-theme 'modus-vivendi)
(setq display-line-numbers-type 'relative)

;; Modeline
(setq doom-modeline-vcs-max-length 120)
(setq doom-modeline-modal-icon nil)

;; Vertico
(after! vertico
  (setq vertico-posframe-height 31)
  (setq vertico-count 30))

(setq vertico-posframe-parameters
      '((left-fringe . 2)
        (right-fringe . 2)))

(vertico-multiform-mode)

;; Sorting folders before files and by alpha order on find-file buffer
(setq vertico-multiform-commands
      '((execute-extended-command
         (:not posframe))
        (consult-line (:not posframe))
        (describe-symbol (vertico-sort-function . vertico-sort-alpha))))

(setq vertico-multiform-categories
      '((symbol (vertico-sort-function . vertico-sort-alpha))
        (file (vertico-sort-function . sort-directories-first))))

(defun sort-directories-first (files)
  (setq files (vertico-sort-alpha files))
  (nconc (seq-filter (lambda (x) (string-suffix-p "/" x)) files)
         (seq-remove (lambda (x) (string-suffix-p "/" x)) files)))

;; Set flex completion style in orderless.
;; This allows me to fuzzy find files in vertico
;; without having to add spaces between words.
(setq completion-styles '(basic substring flex))

;; Do not cache non existing file in projectile
(defadvice! dont-cache-if-file-doesnt-exist-a (&rest _)
  :before-until #'projectile-cache-files-find-file-hook
  (and buffer-file-name (file-exists-p buffer-file-name)))

;; Company
(setq company-show-quick-access t)
(setq company-idle-delay 0.3)

;; Modus Themes
(after! modus-themes
  (setq modus-themes-tabs-accented t)
  (setq modus-themes-common-palette-overrides
        '((underline-ui nil)))
  (setq modus-themes-mode-line '(borderless)))

;; Org
(defun my/set-org-margins()
  (setq left-margin-width 20)
  (setq right-margin-width 20)
  (set-window-buffer nil (current-buffer)))

(add-hook 'org-mode-hook (lambda ()
                           (my/set-org-margins)
                           (linum-mode -1)))

;; Treemacs
(setq treemacs-width 45)

;; ;; Web mode
(defun my/web-mode-hook ()
  (setq web-mode-markup-indent-offset 4
        web-mode-code-indent-offset 2
        tab-width 2
        c-basic-offset 2))

(setq web-mode-script-padding 0)
(setq web-mode-style-padding 0)

(add-hook 'web-mode-hook 'my/web-mode-hook)

;; JS mode
(setq js-indent-level 2)
(setq js2-basic-offset 2)
(setq typescript-indent-level 2)

;; TS mode
(defun my/typescript-mode-hook()
  (setq js-indent-level 2)
  (setq js2-basic-offset 2)
  (setq typescript-indent-level 2))

(add-hook 'typescript-mode-hook 'my/typescript-mode-hook)

;; Rust mode
(defun my/rust-mode-hook()
  (setq flycheck 1))

(add-hook 'rust-mode-hook 'my/rust-mode-hook)

;; Coffe Mode
(custom-set-variables '(coffee-tab-width 2))

;; Olivetti
(defun my/olivetti-mode-hook()
 (setq olivetti-body-width 120))

(add-hook 'olivetti-mode-hook 'my/olivetti-mode-hook)

;; Markdown
(defun my/markdown-mode-hook()
  (display-line-numbers-mode 0)
  (olivetti-mode 1))

(add-hook 'markdown-mode-hook 'my/markdown-mode-hook)

;; Drag Stuff
(use-package! drag-stuff
  :config
  (drag-stuff-global-mode 1))

;; Rebinds
(map! :leader
      :desc "Indent region"
      "=" #'indent-region
      :v "=" #'indent-region)

(map! :v "J" #'drag-stuff-down
      :v "K" #'drag-stuff-up)

(map! :leader
      :desc "Paste without yank"
      :v "p" (cmd! (delete-region (region-beginning) (region-end))
                   (evil-paste-before 1)))
