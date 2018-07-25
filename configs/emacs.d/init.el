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
                      emmet-mode
                      evil
                      feature-mode
                      firestarter
                      git-gutter-fringe
                      helm
                      helm-projectile
                      highlight-indent-guides
                      js2-mode
                      magit
                      markdown-mode
                      multiple-cursors
                      neotree
                      nlinum-relative
                      org
                      persistent-scratch
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

(defun my/scss-mode-hook ()
  (setq css-indent-level my/tab-size
        tab-width my/tab-size
        c-basic-offset my/tab-size))

(add-hook 'php-mode-hook 'my/php-mode-hook)
(add-hook 'web-mode-hook 'my/web-mode-hook)
(add-hook 'js-mode-hook 'my/js-mode-hook)
(add-hook 'scss-mode-hook 'my/scss-mode-hook)

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

;; Window resize
(global-set-key (kbd "M-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "M-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-C-<down>") 'shrink-window)
(global-set-key (kbd "M-C-<up>") 'enlarge-window)

;; init.el shortcut
;; Might be better to use user-init-file
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

;; 2.2 - NEOTREE
;; (require 'neotree)
;; (global-set-key [f8] 'neotree-toggle)

;; (defun my/neotree-hook (_unused)
;:   (linum-mode -1))
;; (add-hook 'neo-after-create-hook 'my/neotree-hook)

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
          treemacs-goto-tag-strategy          'refetch-index)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t))
  :bind
  (:map global-map
        ([f8]        . treemacs-toggle)
        ("M-0"       . treemacs-select-window)
        ("C-c 1"     . treemacs-delete-other-windows)))

(use-package treemacs-projectile
:defer t
:ensure t
:config
(setq treemacs-header-function #'treemacs-projectile-create-header))

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

(global-set-key (kbd "C-x C-p") 'helm-projectile)

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

(global-set-key (kbd "<f5>") (lambda() (interactive)(find-file "~/Org")))

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
;; Better imenu
(add-hook 'js2-mode-hook #'js2-imenu-extras-mode)

;; 2.20 MAGIT
(global-set-key (kbd "C-x g") 'magit-status)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("649ca960922e2176a451db44624bc4dbcd282bc1660d2621793145232f688836" "e9460a84d876da407d9e6accf9ceba453e2f86f8b86076f37c08ad155de8223c" "611e38c2deae6dcda8c5ac9dd903a356c5de5b62477469133c89b2785eb7a14d" "d507c9e58cb0eb8508e15c8fedc2d4e0b119123fab0546c5fd30cadd3705ac86" "365d9553de0e0d658af60cff7b8f891ca185a2d7ba3fc6d29aadba69f5194c7f" "b81bfd85aed18e4341dbf4d461ed42d75ec78820a60ce86730fc17fc949389b2" "9f569b5e066dd6ca90b3578ff46659bc09a8764e81adf6265626d7dc0fac2a64" "8d18c09a80705bb5c807a65141285228fb2dc549fa5bf93ba6ba99e0f1507aef" "67e998c3c23fe24ed0fb92b9de75011b92f35d3e89344157ae0d544d50a63a72" "96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "e0d42a58c84161a0744ceab595370cbe290949968ab62273aed6212df0ea94b4" "2b6a2d39fecd7c878519043fcb4f58d4107a6045188e2c4a6aba006e1ddd78f6" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "72a81c54c97b9e5efcc3ea214382615649ebb539cb4f2fe3a46cd12af72c7607" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "96a67a8e9ef4363d10f836999a2e3d831ca298db09f0c0e0c5ad0dda56d35040" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "d29231b2550e0d30b7d0d7fc54a7fb2aa7f47d1b110ee625c1a56b30fea3be0f" "a1289424bbc0e9f9877aa2c9a03c7dfd2835ea51d8781a0bf9e2415101f70a7e" "98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(git-gutter:added-sign "|")
 '(git-gutter:deleted-sign "-")
 '(git-gutter:modified-sign "|")
 '(package-selected-packages
   (quote
    (js2-mode atom-one-dark-theme kaolin-themes doom-themes feature-mode smooth-scrolling gruvbox-theme git-gutter-fringe+ zenburn-theme dracula-theme git-gutter+ helm-projectile helm rust-mode web-mode neotree material-theme evil))))

;; 3. THEMES

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'doom-one t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
