;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Me
(setq user-full-name "yugarinn"
      user-mail-address "yugarinn@proton.me")

;; Fonts
;; Source Code Pro
(setq doom-font (font-spec :family "Source Code Pro" :size 10)
      doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 10 :weight 'semi-bold))
(setq doom-big-font (font-spec :family "Source Code Pro" :size 17))

;; UI
(setq doom-theme 'doom-one)
(setq display-line-numbers-type 'relative)

(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-hook 'window-setup-hook #'toggle-frame-maximized)

;; Modeline
(setq doom-modeline-vcs-max-length 120)
(setq doom-modeline-modal-icon nil)

;; Vertico file preview
;; (defvar my-file-preview-posframe-buffer " *file-preview-posframe-buffer*")

;; (defun my-show-file-preview (file)
;;   "Show file preview in a posframe at the bottom right."
;;   (let ((content (with-temp-buffer
;;                    (insert-file-contents file nil 0 1000)
;;                    (buffer-string))))
;;     (posframe-show " *file-preview-posframe-buffer*"
;;                    :string content
;;                    :position '(-1 . -1)  ; This will place it at the bottom right corner
;;                    :left-fringe 8
;;                    :right-fringe 8
;;                    :width 80
;;                    :height 30
;;                    :override-parameters '((bottom-divider-width . 0) (right-divider-width . 0)))))

;; (defun my-hide-file-preview ()
;;   "Hide the file preview posframe."
;;   (posframe-hide my-file-preview-posframe-buffer))

;; (defun my-vertico-show-file-preview ()
;;   "Show file preview in a posframe during Vertico completion."
;;   (when-let ((file (and vertico--index
;;                         (nth vertico--index vertico--candidates))))
;;     (message "Selected file: %s" file)
;;     (my-show-file-preview file)))

;; (defun my-vertico-preview-setup ()
;;   (message "Post-command in Vertico")
;;   "Setup for file previews during Vertico completion."
;;   (add-hook 'post-command-hook #'my-vertico-show-file-preview nil t))

;; (defun my-vertico-preview-cleanup ()
;;   "Clean up file previews when Vertico session ends."
;;   (posframe-delete " *file-preview-posframe-buffer*")
;;   (remove-hook 'post-command-hook #'my-vertico-show-file-preview t))

;; (defun my-conditional-vertico-setup ()
;;   (when (bound-and-true-p vertico-mode)
;;     (my-vertico-preview-setup)))

;; (add-hook 'minibuffer-setup-hook #'my-conditional-vertico-setup)
;; (add-hook 'minibuffer-exit-hook #'my-vertico-preview-cleanup)

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
      '((describe-symbol (vertico-sort-function . vertico-sort-alpha))))

(setq vertico-multiform-categories
      '((symbol (vertico-sort-function . vertico-sort-alpha))
        (file (vertico-sort-function . sort-directories-first))))

(defun sort-directories-first (files)
  (setq files (vertico-sort-alpha files))
  (nconc (seq-filter (lambda (x) (string-suffix-p "/" x)) files)
         (seq-remove (lambda (x) (string-suffix-p "/" x)) files)))

;; Tabnine
(after! company
  (add-to-list 'company-backends #'company-tabnine)

  (set-company-backend! '(c-mode
                          c++-mode
                          ess-mode
                          haskell-mode
                          emacs-lisp-mode
                          conf-mode
                          lisp-mode
                          sh-mode
                          php-mode
                          python-mode
                          go-mode
                          ruby-mode
                          rust-mode
                          js-mode
                          css-mode
                          web-mode
                          nix-mode
                          json-mode
                          )
    '(
      company-tabnine
      :separate
      company-capf
      ))

  (setq +lsp-company-backends '(company-tabnine :separate company-capf))
  (setq company-show-quick-access t)
  (setq company-idle-delay 0.3)
)

;; Modus Themes
(after! modus-themes
  (setq modus-themes-tabs-accented t)
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
;; (after! treemacs
;;   (treemacs-add-and-display-current-project-exclusively))

;; (treemacs-project-follow-mode 1)
;; (treemacs-follow-mode 1)
;; (treemacs-git-mode 'deferred)
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

;; Do not cache non existing file in projectile
(defadvice! dont-cache-if-file-doesnt-exist-a (&rest _)
  :before-until #'projectile-cache-files-find-file-hook
  (and buffer-file-name (file-exists-p buffer-file-name)))

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
