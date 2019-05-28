(package-initialize)

(setq user-full-name "Sergio Uve")
(setq user-mail-address "sergiouve@gmail.com")

;; 0. MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;; 0.0 - Check installed packages
(defvar my/packages '(
                      atom-one-dark-theme
                      auto-complete
                      csharp-mode
                      ctags-update
                      doom-themes
                      dumb-jump
                      edbi
                      emmet-mode
                      evil
                      feature-mode
                      firestarter
                      flycheck
                      git-gutter-fringe
                      helm
                      helm-projectile
                      highlight-indent-guides
                      js2-mode
                      magit
                      markdown-mode
                      multiple-cursors
                      nlinum-relative
                      org
                      persistent-scratch
                      prettier-js
                      php-mode
                      phpcbf
                      powerline
                      rust-mode
                      smooth-scrolling
                      use-package
                      vue-mode
                      web-mode
                      yaml-mode
                      yasnippet
                      zenburn-theme
                      )
  "Default packages")

(defun my/packages-installed-p ()
  (cl-loop for package in my/packages
  when (not (package-installed-p package)) do (cl-return nil)
  finally (cl-return t)))

(unless (my/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (package my/packages)
    (when (not (package-installed-p package))
      (package-install package))))

;; 1. GENERAL
;; Skip splash-screen
(setq inhibit-splash-screen t
      initial-scratch-message nil)

;; Hide scroll-bar, tool-bar and menu-bar
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Tabs as 4 spaces
;; All of this language-specific hooks are starting to smell...
(defvar my/tab-size 4)

(setq tab-width my/tab-size)
(setq-default indent-tabs-mode nil)

(defun my/php-mode-hook ()
  (setq indent-tabs-mode nil
        tab-width my/tab-size
        c-basic-offset my/tab-size))

(defun my/web-mode-hook ()
  (setq web-mode-markup-indent-offset my/tab-size
        web-mode-code-indent-offset my/tab-size
        tab-width my/tab-size
        c-basic-offset my/tab-size))

(defun my/js-mode-hook ()
  (setq js-indent-level my/tab-size
        tab-width my/tab-size
        c-basic-offset my/tab-size))

(defun my/js2-mode-hook ()
  (setq js2-basic-offset 4)
  (setq js2-mode-show-parse-errors nil)
  (setq js2-mode-show-strict-warnings nil))

(defun my/scss-mode-hook ()
  (setq css-indent-level my/tab-size
        tab-width my/tab-size
        c-basic-offset my/tab-size))

(add-hook 'php-mode-hook 'my/php-mode-hook)
(add-hook 'web-mode-hook 'my/web-mode-hook)
(add-hook 'js-mode-hook 'my/js-mode-hook)
(add-hook 'scss-mode-hook 'my/scss-mode-hook)
(add-hook 'js2-mode-hook 'my/js2-mode-hook)

;; Make it shut up
(setq ring-bell-function 'ignore)

;; Reduce font-size
(set-face-attribute 'default nil :height 83)
(setq-default line-spacing 5)

;; Show line-numbers
(require 'nlinum-relative)
(nlinum-relative-setup-evil)
(add-hook 'prog-mode-hook 'nlinum-relative-mode)
(setq nlinum-relative-redisplay-delay 0)
(setq nlinum-relative-current-symbol "")
(setq nlinum-relative-offset 0)
(setq-default right-fringe-width 10)
(setq-default left-fringe-width 10)

(setq auto-window-vscroll nil)

;; Highlight current line
(global-hl-line-mode 1)

;; Maximize window on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Remove line numbers form *shell*
(add-hook 'shell-mode-hook (lambda()
                             (linum-mode -1)
                             (hl-line-mode -1)))

;; Open shell in new window
(defun shell-other-window ()
  "Open a `shell' in a new window."
  (interactive)
  (let ((buf (shell)))
    (switch-to-buffer (other-buffer buf))
    (switch-to-buffer-other-window buf)))

;; Disable backup files
(setq auto-save-default nil)
(setq make-backup-files nil)

;; Dired sort
(setq dired-listing-switches "-aBhl --group-directories-first")

;; Yes and No alias
(defalias 'yes-or-no-p 'y-or-n-p)

;; Frame window title
(setq-default frame-title-format
              '(("" invocation-name "@" system-name "\t")
                (buffer-file-name "%f" "%b")))

;; Whitespace-mode options
(setq whitespace-display-mappings
  '((space-mark   ?\     [?\u00B7]     [?.])
    (space-mark   ?\xA0  [?\u00A4]     [?_])
    (newline-mark ?\n [?¬ ?\n])
    (tab-mark     ?\t    [?\u00BB ?\t] [?\\ ?\t])))
(setq whitespace-line-column 999)

(require 'whitespace)

;; This is smelly AF
(add-hook 'emacs-lisp-mode-hook
          (function (lambda ()
                      (whitespace-mode 1))))

(add-hook 'js-mode-hook
          (function (lambda ()
                      (whitespace-mode 1))))

(add-hook 'web-mode-hook
          (function (lambda ()
                      (whitespace-mode 1))))

(add-hook 'scss-mode-hook
          (function (lambda ()
                      (whitespace-mode 1))))

(add-hook 'css-mode-hook
          (function (lambda ()
                      (whitespace-mode 1))))

(add-hook 'python-mode-hook
          (function (lambda ()
                      (whitespace-mode 1))))

(add-hook 'php-mode-hook
          (function (lambda ()
                      (whitespace-mode 1))))

(add-hook 'rust-mode-hook
          (function (lambda ()
                      (whitespace-mode 1))))

(add-hook 'sh-mode-hook
          (function (lambda ()
                      (whitespace-mode 1))))

(add-hook 'graphql-mode-hook
          (function (lambda ()
                      (whitespace-mode 1))))

;; Window resize
(global-set-key (kbd "M-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-C-<down>") 'shrink-window)
(global-set-key (kbd "M-C-<up>") 'enlarge-window)

;; Shortcuts
;; devlog shortcut
(global-set-key (kbd "<f5>") (lambda() (interactive)(find-file "~/code/devlog/devlog.md")))

;; init.el shortcut
(global-set-key (kbd "<f6>") (lambda() (interactive)(find-file "~/.emacs.d/init.el")))

;; snippets shortcut
(global-set-key (kbd "<f7>") (lambda() (interactive)(find-file "~/.emacs.d/snippets/")))

;; Highlight paren match
(show-paren-mode 1)

;; Auto close parens
(electric-pair-mode 1)

;; Auto-refresh files
(global-auto-revert-mode t)

;; Fringe spacing
(fringe-mode 10)

;; Tags
(defun regenerate-tags()
  (interactve)
  (let ((tags-directory (directory-file-name (projectile-project-root))))
    (shell-command
     (format "ctags -R --exclude=node_modules --exclude=vendor --exclude=.git ." tags-file-name tags-directory))))

;; Split windows vertically by default
(setq split-width-threshold nil)

;; Mac bullshit
(if (eq system-type 'darwin)
      (setq mac-option-modifier nil
            mac-command-modifier 'meta
            x-select-enable-clipboard t))

;; Rebind cycle windows shortcut
(global-set-key (kbd "C-,") #'prev-window)
(global-set-key (kbd "M-l") #'switch-to-buffer)

(defun prev-window ()
  (interactive)
  (other-window -1))

;; 2. PACKAGES

;;2.1 - EVIL
;; !! This HAS to appear before requiring evil
(setq evil-want-C-u-scroll t)

(require 'evil)
(evil-mode 1)

(define-key evil-normal-state-map (kbd "gf")
  (lambda () (interactive) (find-tag (find-tag-default-as-regexp))))

;; 2.2 - TREEMACS
(use-package treemacs
  :ensure t
  :defer t
  :config
  (progn
    (use-package treemacs-evil
      :ensure t
      :demand t)
    (setq treemacs-follow-after-init          t
          treemacs-width                      35
          treemacs-indentation                2
          treemacs-git-integration            t
          treemacs-collapse-dirs              3
          treemacs-silent-refresh             nil
          treemacs-change-root-without-asking nil
          treemacs-sorting                    'alphabetic-desc
          treemacs-show-hidden-files          t
          treemacs-never-persist              nil
          treemacs-is-never-other-window      nil
          treemacs-no-png-images              t
          treemacs-goto-tag-strategy          'refetch-index)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null (executable-find "python3"))))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ([f8]        . treemacs)
        ("M-0"       . treemacs-select-window)
        ("C-c 1"     . treemacs-delete-other-windows)))

(use-package treemacs-projectile
  :defer t
  :ensure t
  :config
  (setq treemacs-header-function #'treemacs-projectile-create-header))

(global-set-key (kbd "C-c h") 'helm-command-prefix)

;; 2.3 - WEB-MODE
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.blade.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.blade.php?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.twig?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue?\\'" . web-mode))

;; 2.4 - RELATIVE NUMBERS
;; (global-relative-line-numbers-mode)

;; 2.5 - HELM

(require 'helm)
(require 'helm-config)

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-presistent-action)
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-z") 'helm-select-action)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p t
      helm-move-to-line-cycle-in-source t
      helm-ff-search-library-in-sexp t
      helm-scroll-amount 8
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(defun my/helm-hide-minibuffer-maybe ()
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background, bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))

(add-hook 'helm-minibuffer-set-up-hook
          'my/helm-hide-minibuffer-maybe)

(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-x") 'helm-M-x)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)

(helm-mode 1)

;; 2.6 - HELM-PROJECTILE
(require 'helm-projectile)
(helm-projectile-on)

(global-set-key (kbd "C-p") 'helm-projectile)
(define-key evil-normal-state-map (kbd "C-p") 'helm-projectile)

;; save keybind (overwrites I-search)
(global-set-key (kbd "C-s") 'save-buffer)

;; 2.7 - AUTOCOMPLETE
(require 'auto-complete-config)
(ac-config-default)

;; 2.8 - EMMET
(require 'emmet-mode)

(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)

(global-set-key (kbd "C-x tab") 'emmet-expand-line)

;; 2.9 - INDENT GUIDES
;; (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
;; (setq highlight-indent-guides-method 'character)

;; 2.10 - POWERLINE
(require 'powerline)
(powerline-default-theme)

;; 2.11 - MULTIPLE CURSORS
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; 2.11 - GIT GUTTER
(add-to-list 'load-path "~/.emacs.d/helpers/fringe-helpers.elc")
(require 'git-gutter-fringe)
(global-git-gutter-mode 1)

(set-face-foreground 'git-gutter-fr:added "green")
(set-face-foreground 'git-gutter-fr:deleted "red")
(set-face-foreground 'git-gutter-fr:modified "yellow")

(fringe-helper-define 'git-gutter-fr:added nil
  "...XX..."
  "...XX..."
  "...XX..."
  "...XX..."
  "...XX..."
  "...XX..."
  "...XX..."
  "...XX...")

(fringe-helper-define 'git-gutter-fr:deleted nil
  "........"
  "........"
  "........"
  "XXXXXXXX"
  "XXXXXXXX"
  "........"
  "........"
  "........")

(fringe-helper-define 'git-gutter-fr:modified nil
  "...XX..."
  "...XX..."
  "...XX..."
  "...XX..."
  "...XX..."
  "...XX..."
  "...XX..."
  "...XX...")

;; 2.12 YASNIPPET
(require 'yasnippet)

(setq yas-snippet-dirs
      '("~/.emacs.d/snippets"))

(yas-global-mode 1)

;; 2.13 - ORG
(require 'org)

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(setq org-log-done t)

;; 2.14 - VUE-MODE
(require 'vue-mode)

;; 2.15 - SMOOTH SCROLLING
;; (require 'smooth-scrolling)
;; (smooth-scrolling-mode 1)

;; 2.16 - FEATURE-MODE
(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.features$" . feature-mode))

;; 2.17 - PERSISTENT SCRATCH
(persistent-scratch-setup-default)

;; 2.18 - CTAGS AUTOUPDATE
(ctags-global-auto-update-mode)
(setq ctags-update-prompt-create-tags nil)

;; 2.19 JS2-MODE
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; 2.20 FLYCHECK
;; (add-hook 'after-init-hook #'global-flycheck-mode)

;; Better imenu
(add-hook 'js2-mode-hook #'js2-imenu-extras-mode)
;; Prettier
(require 'prettier-js)
;; (add-hook 'js2-mode-hook 'prettier-js-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("2beaaef4f47f22c89948fdb3859799f8f2b64c1282ec21d71d6df49d68e68862" default)))
 '(package-selected-packages
   (quote
    (graphql-mode fill-column-indicator nova-theme fireplace websocket treemacs-projectile treemacs-evil treemacs zenburn-theme yasnippet yaml-mode web-mode vue-mode use-package smooth-scrolling rust-mode powerline phpcbf php-mode prettier-js persistent-scratch nlinum-relative multiple-cursors markdown-mode magit js2-mode highlight-indent-guides helm-projectile helm git-gutter-fringe firestarter feature-mode evil emmet-mode edbi dumb-jump doom-themes ctags-update csharp-mode auto-complete atom-one-dark-theme)))
 '(phpcbf-executable "~/.config/composer/vendor/bin/phpcbf")
 '(phpcbf-standard "PSR2"))

;; Autoformat on save
;; (add-hook 'php-mode-hook 'phpcbf-enable-on-save)

;; 2.20 MAGIT
(global-set-key (kbd "C-x g") 'magit-status)

;; 2.21 DUMB-JUMP
(dumb-jump-mode)

;; 2.22 - WEBSOCKET
;; used by markdown-preview-mode
(require 'websocket)

;; 3. THEMES

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'doom-one t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

