(add-to-list 'load-path "~/.config/emacs/scripts/")

(require 'elpaca-setup)  ;; The Elpaca Package Manager
(require 'buffer-move)   ;; Buffer-move for better window management
(require 'app-launchers) ;; Use emacs as a run launcher like dmenu (experimental)

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t))))

(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))

(use-package company
  :defer 2
  :diminish
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t))

(use-package company-box
  :after company
  :diminish
  :hook (company-mode . company-box-mode))

(use-package diminish)

(use-package dired-open
  :config
  (setq dired-open-extensions '(("gif" . "sxiv")
                                ("jpg" . "sxiv")
                                ("png" . "sxiv")
                                ("mkv" . "mpv")
                                ("mp4" . "mpv"))))

;; (use-package peep-dired
;;   :after dired
;;   :hook (evil-normalize-keymaps . peep-dired-hook)
;;   :config
;;     (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
;;     (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file) ; use dired-find-file instead if not using dired-open package
;;     (evil-define-key 'normal peep-dired-mode-map (kbd "j") 'peep-dired-next-file)
;;     (evil-define-key 'normal peep-dired-mode-map (kbd "k") 'peep-dired-prev-file)
;; )

(with-eval-after-load 'evil
  (evil-define-key 'normal dired-mode-map (kbd "h") 'dired-up-directory)
  (evil-define-key 'normal dired-mode-map (kbd "l") 'dired-open-file))

;; Expands to: (elpaca evil (use-package evil :demand t))
(use-package evil
    :init      ;; tweak evil's configuration before loading it
    (setq evil-want-integration t  ;; This is optional since it's already set to t by default.
          evil-want-keybinding nil
          evil-vsplit-window-right t
          evil-split-window-below t
          evil-undo-system 'undo-redo)  ;; Adds vim-like C-r redo functionality
    (evil-mode))

(use-package evil-collection
  :after evil
  :config
  ;; Do not uncomment this unless you want to specify each and every mode
  ;; that evil-collection should works with.  The following line is here 
  ;; for documentation purposes in case you need it.  
  ;; (setq evil-collection-mode-list '(calendar dashboard dired ediff info magit ibuffer))
  (add-to-list 'evil-collection-mode-list 'help) ;; evilify help mode
  (evil-collection-init))

(use-package evil-tutor)

;; Using RETURN to follow links in Org/Evil 
;; Unmap keys in 'evil-maps if not done, (setq org-return-follows-link t) will not work
(with-eval-after-load 'evil-maps
  (define-key evil-motion-state-map (kbd "SPC") nil)
  (define-key evil-motion-state-map (kbd "RET") nil)
  (define-key evil-motion-state-map (kbd "TAB") nil))
;; Setting RETURN key in org-mode to follow links
  (setq org-return-follows-link  t)

(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "C-8") 'swiper-isearch-thing-at-point))

(with-eval-after-load 'evil
  (define-key evil-insert-state-map (kbd "C-h") 'evil-backward-char)
  (define-key evil-insert-state-map (kbd "C-j") 'evil-next-line)
  (define-key evil-insert-state-map (kbd "C-k") 'evil-previous-line)
  (define-key evil-insert-state-map (kbd "C-l") 'evil-forward-char)
  (define-key evil-insert-state-map (kbd "C-v") 'yank)
  (define-key evil-insert-state-map (kbd "C-s") 'save-buffer)
  (define-key evil-insert-state-map (kbd "C-c") 'kill-ring-save)
  (define-key evil-insert-state-map (kbd "C-x") 'kill-region)
  (define-key evil-insert-state-map (kbd "C-z") 'undo)
  (define-key evil-insert-state-map (kbd "C-y") 'undo-redo))

(use-package elfeed
  :config
  (setq elfeed-search-feed-face ":foreground #ffffff :weight bold"
        elfeed-feeds (quote
                       (("https://www.reddit.com/r/linux.rss" reddit linux)
                        ("https://www.reddit.com/r/commandline.rss" reddit commandline)
                        ("https://www.reddit.com/r/distrotube.rss" reddit distrotube)
                        ("https://www.reddit.com/r/emacs.rss" reddit emacs)
                        ("https://www.gamingonlinux.com/article_rss.php" gaming linux)
                        ("https://hackaday.com/blog/feed/" hackaday linux)
                        ("https://opensource.com/feed" opensource linux)
                        ("https://linux.softpedia.com/backend.xml" softpedia linux)
                        ("https://itsfoss.com/feed/" itsfoss linux)
                        ("https://www.zdnet.com/topic/linux/rss.xml" zdnet linux)
                        ("https://www.phoronix.com/rss.php" phoronix linux)
                        ("http://feeds.feedburner.com/d0od" omgubuntu linux)
                        ("https://www.computerworld.com/index.rss" computerworld linux)
                        ("https://www.networkworld.com/category/linux/index.rss" networkworld linux)
                        ("https://www.techrepublic.com/rssfeeds/topic/open-source/" techrepublic linux)
                        ("https://betanews.com/feed" betanews linux)
                        ("http://lxer.com/module/newswire/headlines.rss" lxer linux)
                        ("https://distrowatch.com/news/dwd.xml" distrowatch linux)))))
 

(use-package elfeed-goodies
  :init
  (elfeed-goodies/setup)
  :config
  (setq elfeed-goodies/entry-pane-size 0.5))

(use-package flycheck
  :ensure t
  :defer t
  :diminish
  :init (global-flycheck-mode))

(set-face-attribute 'default nil
  :font "JetBrains Mono"
  :height 110
  :weight 'medium)
(set-face-attribute 'variable-pitch nil
  :font "Ubuntu"
  :height 120
  :weight 'medium)
(set-face-attribute 'fixed-pitch nil
  :font "JetBrains Mono"
  :height 110
  :weight 'medium)
;; Makes commented text and keywords italics.
;; This is working in emacsclient but not emacs.
;; Your font must have an italic face available.
(set-face-attribute 'font-lock-comment-face nil
  :slant 'italic)
(set-face-attribute 'font-lock-keyword-face nil
  :slant 'italic)

;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.
(add-to-list 'default-frame-alist '(font . "JetBrains Mono-11"))

;; Uncomment the following line if line spacing needs adjusting.
(setq-default line-spacing 0.12)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

(use-package git-timemachine
  :after git-timemachine
  :hook (evil-normalize-keymaps . git-timemachine-hook)
  :config
    (evil-define-key 'normal git-timemachine-mode-map (kbd "C-j") 'git-timemachine-show-previous-revision)
    (evil-define-key 'normal git-timemachine-mode-map (kbd "C-k") 'git-timemachine-show-next-revision)
)

(use-package magit)

(use-package ivy
  :ensure t
  :bind
  (("C-c C-r" . ivy-resume)
   ("C-x B" . ivy-switch-buffer-other-window))
  :custom
  (ivy-use-virtual-buffers t)
  (ivy-count-format "(%d/%d) ")
  (enable-recursive-minibuffers t)
  (ivy-use-selectable-prompt t)
  :config
  (ivy-mode 1)
  (setq ivy-sort-functions-alist
        '((t . ivy--prefix-sort-recentf))) ;; prioritize recent items
  (define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line)
  (define-key ivy-minibuffer-map (kbd "<up>") 'ivy-previous-line-or-history)
  (define-key ivy-minibuffer-map (kbd "<down>") 'ivy-next-line-or-history))


(use-package counsel
  :ensure t
  :after ivy
  :config 
  (counsel-mode 1)
  (setq ivy-initial-inputs-alist nil)) ;; removes starting ^ regex in M-x

(use-package ivy-rich
  :ensure t
  :after ivy
  :config
  (ivy-rich-mode 1))

(use-package all-the-icons-ivy-rich
  :ensure t
  :after ivy-rich
  :config
  (all-the-icons-ivy-rich-mode 1))




(defun laluxx/ivy-rich-header-icon (_candidate)
  "Force the icon to always represent a .h file."
  (all-the-icons-icon-for-file "dummy.h"))

(defun laluxx/setup-ivy-rich-header-icon ()
  (setq ivy-rich-display-transformers-list
        (plist-put ivy-rich-display-transformers-list
                   'laluxx/find-header
                   '(:columns
                     ((laluxx/ivy-rich-header-icon :width 2)
                      (identity (:width 0.3 :face default)))))))

(with-eval-after-load 'ivy-rich
  (laluxx/setup-ivy-rich-header-icon))

(defun laluxx/find-header ()
  "Search for headers and open in a new window."
  (interactive)
  (let* ((cmd "rg --files /usr/include --follow --hidden -g \"*.h\"")
         (headers (split-string (shell-command-to-string cmd) "\n" t)))
    (ivy-read "Choose header: " headers
              :action (lambda (x) (find-file-other-window x))
              :caller 'laluxx/find-header)))

(use-package haskell-mode)
(use-package lua-mode)

(use-package neotree
  :config
  (setq neo-smart-open t
        neo-show-hidden-files t
        neo-window-width 55
        neo-window-fixed-size nil
        inhibit-compacting-font-caches t
        projectile-switch-project-action 'neotree-projectile-action) 
        ;; truncate long file names in neotree
        (add-hook 'neo-after-create-hook
           #'(lambda (_)
               (with-current-buffer (get-buffer neo-buffer-name)
                 (setq truncate-lines t)
                 (setq word-wrap nil)
                 (make-local-variable 'auto-hscroll-mode)
                 (setq auto-hscroll-mode nil)))))

(use-package toc-org
    :commands toc-org-enable
    :init (add-hook 'org-mode-hook 'toc-org-enable))

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(eval-after-load 'org-indent '(diminish 'org-indent-mode))

(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.7))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.6))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.5))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.4))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.3))))
 '(org-level-6 ((t (:inherit outline-5 :height 1.2))))
 '(org-level-7 ((t (:inherit outline-5 :height 1.1)))))

(require 'org-tempo)

;; (defun my-org-cycle-or-move-right ()
;;   (interactive)
;;   (if (and (bolp) (org-at-heading-p))
;;       (org-cycle)
;;     (forward-char 1)))

;; (defun my-org-close-or-move-left ()
;;   (interactive)
;;   (if (and (bolp) (org-at-heading-p))
;;       (outline-hide-subtree)
;;     (backward-char 1)))

;; (use-package org
;;   :hook (org-mode . (lambda ()
;;                       (define-key org-mode-map (kbd "l") 'my-org-cycle-or-move-right)
;;                       (define-key org-mode-map (kbd "h") 'my-org-close-or-move-left))))

(use-package projectile
  :config
  (projectile-mode 1))

(delete-selection-mode 1)    ;; You can select text and delete it by typing.
(electric-indent-mode -1)    ;; Turn off the weird indenting that Emacs does by default.
(electric-pair-mode 1)       ;; Turns on automatic parens pairing
;; The following prevents <> from auto-pairing when electric-pair-mode is on.
;; Otherwise, org-tempo is broken when you try to <s TAB...
(add-hook 'org-mode-hook (lambda ()
           (setq-local electric-pair-inhibit-predicate
                   `(lambda (c)
                  (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))
(global-auto-revert-mode t)  ;; Automatically show changes if the file has changed
(global-display-line-numbers-mode 1) ;; Display line numbers
(global-visual-line-mode t)  ;; Enable truncated lines
(menu-bar-mode -1)           ;; Disable the menu bar 
(scroll-bar-mode -1)         ;; Disable the scroll bar
(tool-bar-mode -1)           ;; Disable the tool bar
(setq org-edit-src-content-indentation 0) ;; Set src block automatic indent to 0 instead of 2.

(setq completing-read-function 'ivy-completing-read)
(setq use-dialog-box nil)
(setq use-short-answers t)

(global-set-key [escape] 'keyboard-escape-quit)

(use-package eshell-toggle
  :custom
  (eshell-toggle-size-fraction 3)
  (eshell-toggle-use-projectile-root t)
  (eshell-toggle-run-command nil)
  (eshell-toggle-init-function #'eshell-toggle-init-ansi-term))

  (use-package eshell-syntax-highlighting
    :after esh-mode
    :config
    (eshell-syntax-highlighting-global-mode +1))

  ;; eshell-syntax-highlighting -- adds fish/zsh-like syntax highlighting.
  ;; eshell-rc-script -- your profile for eshell; like a bashrc for eshell.
  ;; eshell-aliases-file -- sets an aliases file for the eshell.

  (setq eshell-rc-script (concat user-emacs-directory "eshell/profile")
        eshell-aliases-file (concat user-emacs-directory "eshell/aliases")
        eshell-history-size 5000
        eshell-buffer-maximum-lines 5000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t
        eshell-destroy-buffer-when-process-dies t
        eshell-visual-commands'("bash" "fish" "htop" "ssh" "top" "zsh"))

(use-package vterm
:config
(setq shell-file-name "/bin/sh"
      vterm-max-scrollback 5000))

(use-package vterm-toggle
  :after vterm
  :config
  ;; When running programs in Vterm and in 'normal' mode, make sure that ESC
  ;; kills the program as it would in most standard terminal programs.
  (evil-define-key 'normal vterm-mode-map (kbd "<escape>") 'vterm--self-insert)
  (setq vterm-toggle-fullscreen-p nil)
  (setq vterm-toggle-scope 'project)
  (add-to-list 'display-buffer-alist
               '((lambda (buffer-or-name _)
                     (let ((buffer (get-buffer buffer-or-name)))
                       (with-current-buffer buffer
                         (or (equal major-mode 'vterm-mode)
                             (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                  (display-buffer-reuse-window display-buffer-at-bottom)
                  ;;(display-buffer-reuse-window display-buffer-in-direction)
                  ;;display-buffer-in-direction/direction/dedicated is added in emacs27
                  ;;(direction . bottom)
                  ;;(dedicated . t) ;dedicated is supported in emacs27
                  (reusable-frames . visible)
                  (window-height . 0.4))))

(use-package sudo-edit)

(use-package tldr)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(use-package amx
  :ensure t
  :after ivy
  :custom
  (amx-backend 'auto)
  (amx-save-file "~/.config/emacs/amx-items")
  (amx-history-length 50)
  (amx-show-key-bindings nil)
  :config
  (amx-mode 1))

;; (defun edwina-toggle-mode-based-on-window-count ()
;;   "Toggle edwina-mode based on window count.
;; Enable if there are two or more windows, disable if there's only one."
;;   (if (= 1 (count-windows))
;;       (when edwina-mode (edwina-mode -1))
;;     (unless edwina-mode (edwina-mode 1))))


(defun edwina-toggle-mode-based-on-window-count ()
  "Toggle edwina-mode based on window count.
Enable if there are two or more windows, disable if there's only one.
However, don't toggle if which-key is currently displayed."
  (let ((which-key-buffer (get-buffer which-key-buffer-name)))
    (if (and which-key-buffer (get-buffer-window which-key-buffer))
        nil ;; Do nothing if which-key is displayed
      (if (= 1 (count-windows))
          (when edwina-mode (edwina-mode -1))
        (unless edwina-mode (edwina-mode 1))))))

(add-hook 'window-configuration-change-hook 'edwina-toggle-mode-based-on-window-count)

(use-package edwina
  :ensure t
  :config
  (setq display-buffer-base-action '(display-buffer-below-selected))
  (edwina-setup-dwm-keys)
  (define-key edwina-mode-map (kbd "M-q") 'delete-window))

(define-key global-map [remap dired] 'counsel-dired)
(global-set-key [remap describe-variable] 'counsel-describe-variable)
(global-set-key [remap describe-function] 'counsel-describe-function)

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                   (if treemacs-python-executable 3 0)
          treemacs-deferred-git-apply-delay        0.5
          treemacs-directory-name-transformer      #'identity
          treemacs-display-in-side-window          t
          treemacs-eldoc-display                   'simple
          treemacs-file-event-delay                2000
          treemacs-file-extension-regex            treemacs-last-period-regex-value
          treemacs-file-follow-delay               0.2
          treemacs-file-name-transformer           #'identity
          treemacs-follow-after-init               t
          treemacs-expand-after-init               t
          treemacs-find-workspace-method           'find-for-file-or-pick-first
          treemacs-git-command-pipe                ""
          treemacs-goto-tag-strategy               'refetch-index
          treemacs-header-scroll-indicators        '(nil . "^^^^^^")
          treemacs-hide-dot-git-directory          t
          treemacs-indentation                     2
          treemacs-indentation-string              " "
          treemacs-is-never-other-window           nil
          treemacs-max-git-entries                 5000
          treemacs-missing-project-action          'ask
          treemacs-move-forward-on-expand          nil
          treemacs-no-png-images                   nil
          treemacs-no-delete-other-windows         t
          treemacs-project-follow-cleanup          nil
          treemacs-persist-file                    (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                        'left
          treemacs-read-string-input               'from-child-frame
          treemacs-recenter-distance               0.1
          treemacs-recenter-after-file-follow      nil
          treemacs-recenter-after-tag-follow       nil
          treemacs-recenter-after-project-jump     'always
          treemacs-recenter-after-project-expand   'on-distance
          treemacs-litter-directories              '("/node_modules" "/.venv" "/.cask")
          treemacs-project-follow-into-home        nil
          treemacs-show-cursor                     t 
          treemacs-show-hidden-files               t
          treemacs-silent-filewatch                nil
          treemacs-silent-refresh                  nil
          treemacs-sorting                         'alphabetic-asc
          treemacs-select-when-already-in-treemacs 'move-back
          treemacs-space-between-root-nodes        t
          treemacs-tag-follow-cleanup              t
          treemacs-tag-follow-delay                1.5
          treemacs-text-scale                      nil
          treemacs-user-mode-line-format           nil
          treemacs-user-header-line-format         nil
          treemacs-wide-toggle-width               70
          treemacs-width                           35
          treemacs-width-increment                 1
          treemacs-width-is-initially-locked       t
          treemacs-workspace-switch-cleanup        nil)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    ;;(treemacs-resize-icons 44)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode 'always)
    (when treemacs-python-executable
      (treemacs-git-commit-diff-mode t))

    (pcase (cons (not (null (executable-find "git")))
                 (not (null treemacs-python-executable)))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple)))

    (treemacs-hide-gitignored-files-mode nil))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t d"   . treemacs-select-directory)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after (treemacs evil)
  :ensure t)

(use-package treemacs-projectile
  :after (treemacs projectile)
  :ensure t)

(use-package treemacs-icons-dired
  :hook (dired-mode . treemacs-icons-dired-enable-once)
  :ensure t)

(use-package treemacs-magit
  :after (treemacs magit)
  :ensure t)

(use-package treemacs-persp ;;treemacs-perspective if you use perspective.el vs. persp-mode
  :after (treemacs persp-mode) ;;or perspective vs. persp-mode
  :ensure t
  :config (treemacs-set-scope-type 'Perspectives))

(use-package treemacs-tab-bar ;;treemacs-tab-bar if you use tab-bar-mode
  :after (treemacs)
  :ensure t
  :config (treemacs-set-scope-type 'Tabs))

(setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp
    projectile hydra flycheck company avy  helm-xref dap-mode))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

;; sample `helm' configuration use https://github.com/emacs-helm/helm/ for details
(helm-mode)
(require 'helm-xref)
;; (define-key global-map [remap find-file] #'helm-find-files)
;; (define-key global-map [remap execute-extended-command] #'helm-M-x)
;; (define-key global-map [remap switch-to-buffer] #'helm-mini)

;; (which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)

(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1
      lsp-idle-delay 0.1)  ;; clangd is fast

(with-eval-after-load 'lsp-mode
  ;; (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

(with-eval-after-load 'helm
  (define-key helm-map (kbd "C-j") 'helm-next-line)
  (define-key helm-map (kbd "C-k") 'helm-previous-line))

(use-package which-key
  :init
    (which-key-mode 1)
  :diminish
  :config
  (setq which-key-side-window-location 'bottom
	  which-key-sort-order #'which-key-key-order-alpha
	  which-key-allow-imprecise-window-fit nil
	  which-key-sort-uppercase-first nil
	  which-key-add-column-padding 1
	  which-key-max-display-columns nil
	  which-key-min-display-lines 6
	  which-key-side-window-slot -10
	  which-key-side-window-max-height 0.25
	  which-key-idle-delay 0.8
	  which-key-max-description-length 25
	  which-key-allow-imprecise-window-fit nil
	  which-key-separator " → " ))

(setq which-key--prefix-title-alist
      (cl-remove-if (lambda (elem)
                      (string-prefix-p "M-SPC" (car elem)))
                    which-key--prefix-title-alist))

(defun laluxx/hide-which-key-mode-line-and-line-numbers (&rest _)
  "Hide the mode line and line numbers in the `which-key' popup window."
  (let* ((buf (get-buffer which-key-buffer-name))
         (window (and buf (get-buffer-window buf))))
    (when window
      (with-selected-window window
        (setq mode-line-format nil)
        (display-line-numbers-mode -1)))))

(advice-add 'which-key--show-popup :after 'laluxx/hide-which-key-mode-line-and-line-numbers)

(use-package dashboard
  :ensure t 
  :init
  (setq initial-buffer-choice 'dashboard-open)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  (setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  ;; (setq dashboard-startup-banner "~/.config/emacs/images/dtmacs-logo.png")
  (setq dashboard-startup-banner "~/xos/emacs/dashboard/xos-logo.png") ;; logo
  (setq dashboard-center-content t) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)
                          (registers . 3)))
  :custom 
  (dashboard-modify-heading-icons '((recents . "file-text")
				    (bookmarks . "book")))
  :config
  (dashboard-setup-startup-hook)
  
  ;; Ensure dashboard is in evil normal mode
  (add-hook 'dashboard-mode-hook 'evil-normal-state)

  ;; Map j to widget-forward and k to widget-backward for evil-normal-state
  (evil-define-key 'normal dashboard-mode-map (kbd "j") 'widget-forward)
  (evil-define-key 'normal dashboard-mode-map (kbd "k") 'widget-backward))

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don"t accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

;; (setq scroll-step 23) ;; keyboard scroll one line at a time
;; (setq scroll-conservatively 10000)
;; (setq auto-window-vscroll nil)
;; (setq scroll-margin 5)

(setq double-buffering t)

(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/")

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; Sets the default theme to load!!! 
  ;; (load-theme 'doom-one t)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(require 'theme-magic)
;;(theme-magic-export-theme-mode)

(use-package ewal
  :ensure t
  :init
  (setq ewal-use-built-in-always-p nil
        ewal-use-built-in-on-failure-p t
        ewal-built-in-palette "sexy-material"))

;; ** Ewal-Doom-Theme Configuration
(use-package ewal-doom-themes
  :ensure t
  :init
  ;; If you've set ewal-use-built-in-always-p to nil in ewal configuration
  ;; This might be unnecessary, but doesn't hurt to ensure.
  (setq ewal-use-built-in-always-p nil
        ewal-use-built-in-on-failure-p t
        ewal-built-in-palette "sexy-material")
  :config
  (load-theme 'ewal-doom-vibrant t))

;; (add-to-list 'default-frame-alist '(alpha-background . 85)) ; For hardcoded alpha

(defun set-theme-transparency (&rest args)
  "Set the frame transparency based on the theme loaded."
  (let* ((transparent-themes '(ewal-doom-one ewal-doom-vibrant))
         (current-theme (car args)) ; the first argument to `load-theme` is the theme name
         (alpha-value (if (member current-theme transparent-themes) 85 100)))
    ;; Remove old setting
    (setq default-frame-alist (assq-delete-all 'alpha-background default-frame-alist))
    ;; Apply new setting
    (add-to-list 'default-frame-alist `(alpha-background . ,alpha-value))
    ;; Update current frames
    (dolist (frame (frame-list))
      (set-frame-parameter frame 'alpha-background alpha-value))))

(advice-add 'load-theme :after 'set-theme-transparency)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 35      ;; sets modeline height
        doom-modeline-bar-width 5    ;; sets left bar width
        doom-modeline-persp-name t   ;; adds perspective name to modeline
        doom-modeline-persp-icon t)) ;; adds folder icon next to persp name

(use-package hl-todo
  :hook ((org-mode . hl-todo-mode)
         (prog-mode . hl-todo-mode))
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       warning bold)
          ("FIXME"      error bold)
          ("HACK"       font-lock-constant-face bold)
          ("REVIEW"     font-lock-keyword-face bold)
          ("NOTE"       success bold)
          ("DEPRECATED" font-lock-doc-face bold))))

(use-package rainbow-delimiters
  :hook ((emacs-lisp-mode . rainbow-delimiters-mode)
         (clojure-mode . rainbow-delimiters-mode)))

(use-package rainbow-mode
  :diminish
  :hook org-mode prog-mode)

(use-package general
  :config
  (general-evil-setup)
  
  ;; set up 'SPC' as the global leader key
  (general-create-definer laluxx/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC") ;; access leader in insert mode

  (laluxx/leader-keys
    "SPC" '(counsel-M-x :wk "Counsel M-x")
    "." '(find-file :wk "Find file")
    "=" '(perspective-map :wk "Perspective") ;; Lists all the perspective keybindings
    "TAB TAB" '(comment-line :wk "Comment lines")
    "u" '(universal-argument :wk "Universal argument"))

  (laluxx/leader-keys
    "b" '(:ignore t :wk "Bookmarks/Buffers")
    "b b" '(counsel-switch-buffer :wk "Switch to buffer")
    "b c" '(clone-indirect-buffer :wk "Create indirect buffer copy in a split")
    "b C" '(clone-indirect-buffer-other-window :wk "Clone indirect buffer in new window")
    "b d" '(bookmark-delete :wk "Delete bookmark")
    "b i" '(ibuffer :wk "Ibuffer")
    "b k" '(kill-current-buffer :wk "Kill current buffer")
    "b K" '(kill-some-buffers :wk "Kill multiple buffers")
    "b l" '(list-bookmarks :wk "List bookmarks")
    "b m" '(bookmark-set :wk "Set bookmark")
    "b n" '(next-buffer :wk "Next buffer")
    "b p" '(previous-buffer :wk "Previous buffer")
    "b r" '(revert-buffer :wk "Reload buffer")
    "b R" '(rename-buffer :wk "Rename buffer")
    "b s" '(basic-save-buffer :wk "Save buffer")
    "b S" '(save-some-buffers :wk "Save multiple buffers")
    "b w" '(bookmark-save :wk "Save current bookmarks to bookmark file"))

  (laluxx/leader-keys
    "d" '(:ignore t :wk "Dired")
    "d d" '(dired :wk "Open dired")
    "d j" '(dired-jump :wk "Dired jump to current")
    "d n" '(neotree-dir :wk "Open directory in neotree")
    "d i" '(laluxx/diff-buffer-with-file :wk "Diff buffer with file")
    "d p" '(peep-dired :wk "Peep-dired"))

  (laluxx/leader-keys
    "e" '(:ignore t :wk "Eshell/Evaluate")    
    "e b" '(eval-buffer :wk "Evaluate elisp in buffer")
    "e d" '(eval-defun :wk "Evaluate defun containing or after point")
    "e e" '(eval-expression :wk "Evaluate and elisp expression")
    "e h" '(counsel-esh-history :which-key "Eshell history")
    "e l" '(eval-last-sexp :wk "Evaluate elisp expression before point")
    "e r" '(eval-region :wk "Evaluate elisp in region")
    "e R" '(eww-reload :which-key "Reload current page in EWW")
    "e s" '(eshell :which-key "Eshell")
    "e w" '(eww :which-key "EWW emacs web wowser"))

  (laluxx/leader-keys
    "f" '(:ignore t :wk "Files")    
    "f c" '((lambda () (interactive)
              (find-file "~/.config/emacs/config.org")) 
            :wk "Open emacs config.org")
    "f e" '((lambda () (interactive)
              (dired "~/.config/emacs/")) 
            :wk "Open user-emacs-directory in dired")
    "f d" '(find-grep-dired :wk "Search for string in files in DIR")
    "f g" '(counsel-grep-or-swiper :wk "Search for string current file")
    ;; "f i" '((lambda () (interactive)
    ;;           (find-file "~/.config/emacs/init.el")) 
    ;;         :wk "Open emacs init.el")
    "f i" '(swiper :wk "Swiper")
    "f j" '(laluxx/file-jump :wk "Jump to a file")
    ;; "f l" '(counsel-locate :wk "Locate a file")
    "f l" '(find-library :wk "Locate a file")
    "f r" '(counsel-recentf :wk "Find recent files")
    "f u" '(sudo-edit-find-file :wk "Sudo find file")
    "f f" '(counsel-find-file :wk "Find file")
    "f s" '(helm-lsp-workspace-symbol :wk "Find symbol")
    "f h" '(laluxx/find-header :wk "Find header")
    "f U" '(sudo-edit :wk "Sudo edit file"))

  (laluxx/leader-keys
    "q" '(:ignore t :wk "Quit")
    "q r" '(restart-emacs :wk "Restart emacs"))

  (laluxx/leader-keys
    "i" '(:ignore t :wk "Insert")
    "i i" '(all-the-icons-insert-faicon :wk "Insert FontAwesome")
    "i f" '(all-the-icons-insert-fileicon :wk "Insert file icon") ;
    "i g" '(all-the-icons-insert-octicon :wk "Insert github icon"))

  (laluxx/leader-keys
    "k" '(:ignore t :wk "Kill")
    "k p" '(kill-process :wk "Kill process"))

  (laluxx/leader-keys
    "g" '(:ignore t :wk "Git")    
    "g /" '(magit-displatch :wk "Magit dispatch")
    "g ." '(magit-file-displatch :wk "Magit file dispatch")
    "g b" '(magit-branch-checkout :wk "Switch branch")
    "g c" '(:ignore t :wk "Create") 
    "g c b" '(magit-branch-and-checkout :wk "Create branch and checkout")
    "g c c" '(magit-commit-create :wk "Create commit")
    "g c f" '(magit-commit-fixup :wk "Create fixup commit")
    "g C" '(magit-clone :wk "Clone repo")
    "g f" '(:ignore t :wk "Find") 
    "g f c" '(magit-show-commit :wk "Show commit")
    "g f f" '(magit-find-file :wk "Magit find file")
    "g f g" '(magit-find-git-config-file :wk "Find gitconfig file")
    "g F" '(magit-fetch :wk "Git fetch")
    "g g" '(magit-status :wk "Magit status")
    "g i" '(magit-init :wk "Initialize git repo")
    "g l" '(magit-log-buffer-file :wk "Magit buffer log")
    "g r" '(vc-revert :wk "Git revert file")
    "g s" '(magit-stage-file :wk "Git stage file")
    "g t" '(git-timemachine :wk "Git time machine")
    "g u" '(magit-stage-file :wk "Git unstage file"))

  (laluxx/leader-keys
    "h" '(:ignore t :wk "Help")
    "h a" '(counsel-apropos :wk "Apropos")
    "h b" '(describe-bindings :wk "Describe bindings")
    "h c" '(describe-char :wk "Describe character under cursor")
    "h d" '(:ignore t :wk "Emacs documentation")
    "h d a" '(about-emacs :wk "About Emacs")
    "h d d" '(view-emacs-debugging :wk "View Emacs debugging")
    "h d f" '(view-emacs-FAQ :wk "View Emacs FAQ")
    "h d m" '(info-emacs-manual :wk "The Emacs manual")
    "h d n" '(view-emacs-news :wk "View Emacs news")
    "h d o" '(describe-distribution :wk "How to obtain Emacs")
    "h d p" '(view-emacs-problems :wk "View Emacs problems")
    "h d t" '(view-emacs-todo :wk "View Emacs todo")
    "h d w" '(describe-no-warranty :wk "Describe no warranty")
    "h e" '(view-echo-area-messages :wk "View echo area messages")
    "h f" '(describe-function :wk "Describe function")
    "h F" '(describe-face :wk "Describe face")
    "h g" '(describe-gnu-project :wk "Describe GNU Project")
    "h i" '(info :wk "Info")
    "h I" '(describe-input-method :wk "Describe input method")
    "h k" '(describe-key :wk "Describe key")
    "h l" '(view-lossage :wk "Display recent keystrokes and the commands run")
    "h L" '(describe-language-environment :wk "Describe language environment")
    "h m" '(describe-mode :wk "Describe mode")
    "h s" '(helm-lsp-workspace-symbol :wk "Symbol")
    "h r" '(:ignore t :wk "Reload")
    "h r r" '((lambda () (interactive)
                (load-file "~/.config/emacs/init.el")
                (ignore (elpaca-process-queues)))
              :wk "Reload emacs config")
    ;; "h t" '(counsel-load-theme :wk "Load theme")
    "h t" '(laluxx/load-theme :wk "Load theme")
    "h T" '(laluxx/wal-set :wk "Wal set")
    "h v" '(describe-variable :wk "Describe variable")
    "h w" '(where-is :wk "Prints keybinding for command if set")
    "h x" '(describe-command :wk "Display full documentation for command"))

  (laluxx/leader-keys
    "m" '(:ignore t :wk "Org")
    "m a" '(org-agenda :wk "Org agenda")
    "m e" '(org-export-dispatch :wk "Org export dispatch")
    "m i" '(org-toggle-item :wk "Org toggle item")
    "m t" '(org-todo :wk "Org todo")
    "m B" '(org-babel-tangle :wk "Org babel tangle")
    "m T" '(org-todo-list :wk "Org todo list"))

  (laluxx/leader-keys
    "m b" '(:ignore t :wk "Tables")
    "m b -" '(org-table-insert-hline :wk "Insert hline in table"))

  (laluxx/leader-keys
    "m d" '(:ignore t :wk "Date/deadline")
    "m d t" '(org-time-stamp :wk "Org time stamp"))

  (laluxx/leader-keys
    "o" '(:ignore t :wk "Open")
    "o d" '(dashboard-open :wk "Dashboard")
    "o e" '(elfeed :wk "Elfeed RSS")
    "o f" '(make-frame :wk "Open buffer in new frame")
    "o F" '(select-frame-by-name :wk "Select frame by name"))

  ;; projectile-command-map already has a ton of bindings 
  ;; set for us, so no need to specify each individually.
  (laluxx/leader-keys
    "p" '(projectile-command-map :wk "Projectile"))

  (laluxx/leader-keys
    "s" '(:ignore t :wk "Search")
    "s d" '(dictionary-search :wk "Search dictionary")
    "s m" '(man :wk "Man pages")
    "s t" '(tldr :wk "Lookup TLDR docs for a command")
    "s i" '(counsel-imenu :wk "Counsel imenu")
    "s w" '(woman :wk "Similar to man but doesn't require man"))

  (laluxx/leader-keys
    "t" '(:ignore t :wk "Toggle")
    "t e" '(eshell-toggle :wk "Toggle eshell")
    "t f" '(flycheck-mode :wk "Toggle flycheck")
    "t l" '(display-line-numbers-mode :wk "Toggle line numbers")
    "t n" '(neotree-toggle :wk "Toggle neotree file viewer")
    "t o" '(org-mode :wk "Toggle org mode")
    "t r" '(rainbow-mode :wk "Toggle rainbow mode")
    "t t" '(visual-line-mode :wk "Toggle truncated lines")
    "t v" '(vterm-toggle :wk "Toggle vterm"))

  (laluxx/leader-keys
    "w" '(:ignore t :wk "Windows")
    ;; Window splits
    "w c" '(evil-window-delete :wk "Close window")
    "w n" '(evil-window-new :wk "New window")
    "w s" '(evil-window-split :wk "Horizontal split window")
    "w v" '(evil-window-vsplit :wk "Vertical split window")
    ;; Window motions
    "w h" '(evil-window-left :wk "Window left")
    "w j" '(evil-window-down :wk "Window down")
    "w k" '(evil-window-up :wk "Window up")
    "w l" '(evil-window-right :wk "Window right")
    "w w" '(evil-window-next :wk "Goto next window")
    ;; Move Windows
    "w H" '(buf-move-left :wk "Buffer move left")
    "w J" '(buf-move-down :wk "Buffer move down")
    "w K" '(buf-move-up :wk "Buffer move up")
    "w L" '(buf-move-right :wk "Buffer move right"))
  )

(defun laluxx/mark-word (&optional arg allow-extend)
  "Mark the whole word at point. 
This function is a modified version of the built-in `mark-word'."
  (interactive "P\np")
  (let ((x "forward-word"))
    (cond ((and allow-extend
               (or (and (eq last-command this-command) (mark t))
                   (region-active-p)))
          (setq arg (if arg (prefix-numeric-value arg)
                      (if (< (mark) (point)) -1 1)))
          (set-mark
           (save-excursion
             (goto-char (mark))
             (funcall (intern x) arg)
             (point))))
         (t
          (let ((bounds (bounds-of-thing-at-point 'word)))
            (unless (consp bounds)
              (user-error "No word at point"))
            (if (>= (prefix-numeric-value arg) 0)
                (goto-char (car bounds))
              (goto-char (cdr bounds)))
            (push-mark
             (save-excursion
               (funcall (intern x) (prefix-numeric-value arg))
               (point)))
            (activate-mark))))))

(defun laluxx/mark-word-backward (&optional arg allow-extend)
  "Mark the whole word backward from point. 
This function is a modified version of `laluxx/mark-word' but moves backward."
  (interactive "P\np")
  (laluxx/mark-word (- (or arg 1)) allow-extend))

(with-eval-after-load 'evil
  (evil-define-key 'normal 'global "w" 'laluxx/mark-word)
  (evil-define-key 'normal 'global "W" 'laluxx/mark-word-backward))

(defvar laluxx/window-configuration nil
  "Current window configuration.
Intended for use by `laluxx/window-monocle'.")

(define-minor-mode laluxx/window-single-toggle
  "Toggle between multiple windows and single window.
This is the equivalent of maximizing a window. Tiling window
managers such as DWM, BSPWM refer to this state as 'monocle'."
  :lighter " [M]"
  :global nil
  (if (one-window-p)
      (when laluxx/window-configuration
        (set-window-configuration laluxx/window-configuration))
    (setq laluxx/window-configuration (current-window-configuration))
    (delete-other-windows)))

(global-unset-key (kbd "M-<space>"))
(global-set-key (kbd "M-<space>") 'laluxx/window-single-toggle)

;; (defun laluxx/org-move-to-begin-src ()
;;   "Move cursor to the line below #+begin_src."
;;   (interactive)
;;   (search-backward "#+begin_src")
;;   (forward-line 1))

;; (defun laluxx/org-move-to-end-src ()
;;   "Move cursor to the line above #+end_src."
;;   (interactive)
;;   (search-forward "#+end_src")
;;   (forward-line -1))

;; (defun laluxx/setup-org-evil-bindings ()
;;   (evil-define-key 'visual org-mode-map (kbd "C-k") 'laluxx/org-move-to-begin-src)
;;   (evil-define-key 'visual org-mode-map (kbd "C-j") 'laluxx/org-move-to-end-src)
;;   (evil-define-key 'visual-line org-mode-map (kbd "C-k") 'laluxx/org-move-to-begin-src)
;;   (evil-define-key 'visual-line org-mode-map (kbd "C-j") 'laluxx/org-move-to-end-src)
;;   (evil-define-key 'block org-mode-map (kbd "C-k") 'laluxx/org-move-to-begin-src)
;;   (evil-define-key 'block org-mode-map (kbd "C-j") 'laluxx/org-move-to-end-src))

;; (add-hook 'org-mode-hook 'laluxx/setup-org-evil-bindings)




(defun laluxx/org-move-to-begin-src ()
  "Move cursor to the line below #+begin_src."
  (interactive)
  (let ((original-pos (point)))
    (search-backward "#+begin_src")
    (forward-line 1)
    (when (and (evil-visual-state-p) (evil-visual-line))
      (evil-visual-select original-pos (point) 'line))))

(defun laluxx/org-move-to-end-src ()
  "Move cursor to the line above #+end_src."
  (interactive)
  (let ((original-pos (point)))
    (search-forward "#+end_src")
    (forward-line -1)
    (when (and (evil-visual-state-p) (evil-visual-line))
      (evil-visual-select original-pos (point) 'line))))

(defun laluxx/setup-org-evil-bindings ()
  (evil-define-key 'visual org-mode-map (kbd "C-k") 'laluxx/org-move-to-begin-src)
  (evil-define-key 'visual org-mode-map (kbd "C-j") 'laluxx/org-move-to-end-src)
  (evil-define-key 'visual-line org-mode-map (kbd "C-k") 'laluxx/org-move-to-begin-src)
  (evil-define-key 'visual-line org-mode-map (kbd "C-j") 'laluxx/org-move-to-end-src)
  (evil-define-key 'block org-mode-map (kbd "C-k") 'laluxx/org-move-to-begin-src)
  (evil-define-key 'block org-mode-map (kbd "C-j") 'laluxx/org-move-to-end-src))

(add-hook 'org-mode-hook 'laluxx/setup-org-evil-bindings)

(defvar laluxx/excluded-themes 
  '(whiteboard light-blue wombat wheatgrass tsdh-light tsdh-dark tango tango-dark modus-operandi misterioso monoj-dark light-blue leuven leuven-dark adwaita
	       deeper-blue dichromacy doom-bluloco-light doom-acario-light doom-ayu-light doom-feather-light doom-gruvbox-light doom-nord-light doom-oksolar-light
	       doom-one-light doom-opera-light doom-solarized-light) ;; ... add other light theme names here ...
  "List of themes that should be excluded from laluxx/load-theme.")

(defun laluxx/load-theme ()
  "Load a theme, but exclude light themes based on laluxx/excluded-themes list."
  (interactive)
  (let ((available-dark-themes (seq-difference (custom-available-themes) laluxx/excluded-themes)))
    (load-theme (intern (ivy-completing-read "Load dark theme: " (mapcar 'symbol-name available-dark-themes))) t)))

(defun laluxx/diff-buffer-with-file (&optional arg)
  "Compare buffer to its file, else run `vc-diff'.
With \\[universal-argument] also enable highlighting of word-wise
changes, local to the current buffer."
  (interactive "P")
  (let ((buf nil))     ; this method will "fail" if multi diff buffers
    (if (buffer-modified-p)
        (progn
          (diff-buffer-with-file (current-buffer))
          (setq buf "*Diff*"))
      (vc-diff)
      (setq buf "*vc-diff*"))
    (when arg
      (with-current-buffer (get-buffer buf)
        (setq-local diff-refine 'font-lock)))))

(defun laluxx/find-header ()
  (interactive)
  (let* ((cmd "rg --files /usr/include --follow --hidden -g \"*.h\"")
         (headers (split-string (shell-command-to-string cmd) "\n" t)))
    (ivy-read "Choose header: " headers
              :action (lambda (x) (find-file-other-window x)))))

(defun laluxx/file-jump ()
  "Open a file in a new split. Vertical split if one window, horizontal otherwise."
  (interactive)
  (let ((current-buffer (current-buffer))
        (selected-file (counsel-find-file))
        (split-fn (if (= (length (window-list)) 1) 'split-window-right 'split-window-below)))
    (when selected-file
      (funcall split-fn)             ; Split based on number of windows
      (switch-to-buffer current-buffer) ; Switch back to the original buffer
      (other-window 1)              ; Move to the newly created window
      (find-file selected-file))))

(defun laluxx/wal-set ()
  (interactive)
  (let* ((default-directory "~/xos/wallpapers/static")
         (theme-directory "~/xos/theme")
         (pywal-scripts-directory "~/xos/pywal-scripts")
         (image-files (directory-files-recursively default-directory "\\.\\(png\\|jpg\\|jpeg\\|webp\\)$"))
         (current-buffer-name (buffer-name))
         (wm-name (string-trim (shell-command-to-string "wmctrl -m | awk 'NR==1 {print $2}'"))))
    (ivy-read "Choose wallpaper: "
              image-files
              :action (lambda (wallpaper)
                        (when (and (not (string-empty-p wallpaper))
                                   (file-exists-p wallpaper))
                          (let ((abs-wallpaper (expand-file-name wallpaper)))
                            (shell-command-to-string (concat "wal -i " abs-wallpaper))
                            (with-temp-file (concat theme-directory "/.wallpaper")
                              (insert abs-wallpaper))
                            (shell-command-to-string "theme pywal --no-random")
                            (dolist (script '("xmonad-dark-wal.py" "nvim-wal.py" "nvim-wal-dark.py"))
                              (shell-command-to-string (concat "python3 " pywal-scripts-directory "/" script)))
                            (cond
                             ((string-equal wm-name "LG3D") (shell-command-to-string "xmonad --restart"))
                             ((string-equal wm-name "dwm") (shell-command-to-string "xdotool key super+F5")))
                            (shell-command-to-string "dashboard-wal-gen")
                            ;; Start picom
                            (start-process "picom" nil "picom")
                            ;; If the current buffer was the dashboard, refresh it
                            (when (equal current-buffer-name "*dashboard*")
                              (run-at-time "0.5 sec" nil 'open-dashboard))
                            (run-at-time "1 sec" nil 'spaceline-compile)))))))

(defun laluxx/wal-set-animated ()
  "Set an animated wallpaper and configure theme based on it."
  (interactive)
  (let* ((default-directory "~/xos/wallpapers/animated")
         (theme-directory "~/xos/theme")
         (pywal-scripts-directory "~/xos/pywal-scripts")
         (video-files (directory-files-recursively default-directory "\\.\\(mp4\\|mkv\\|webm\\|avi\\)$"))
         (current-buffer-name (buffer-name)))
    (ivy-read "Choose animated wallpaper: "
              video-files
              :action (lambda (video)
                        (when (and (not (string-empty-p video))
                                   (file-exists-p video))
                          (let* ((abs-video (expand-file-name video))
                                 (first-frame-image (concat abs-video "-frame1.png")))
                            ;; Extract the first frame of the video
                            (shell-command (concat "ffmpeg -i " abs-video " -vframes 1 " first-frame-image))
                            ;; Use the extracted frame with `wal` to generate and set the theme (but not set as wallpaper)
                            (shell-command (concat "wal -n -i " first-frame-image))
                            ;; Rest of the commands similar to your wal-set function
                            (with-temp-file (concat theme-directory "/.wallpaper")
                              (insert first-frame-image))
                            (shell-command "theme pywal --no-random")
                            (dolist (script '("xmonad-dark-wal.py" "nvim-wal.py" "nvim-wal-dark.py"))
                              (shell-command (concat "python3 " pywal-scripts-directory "/" script)))
                            (shell-command "xmonad --restart")
                            (shell-command "dashboard-wal-gen")
                            (when (equal current-buffer-name "*dashboard*")
                              (run-at-time "0.5 sec" nil 'open-dashboard))
                            (run-at-time "1 sec" nil 'spaceline-compile)
                            ;; Finally, set the video as the animated wallpaper
                            (start-process "set-animated-wallpaper" nil "xwinwrap" "-o" "1.0" "-nf" "-ovr" "--"
                                           "mpv" "-wid" "WID" "--loop-file=inf" "--video-unscaled"
                                           "--no-terminal" "--no-audio" "--no-input-default-bindings"
                                           "--no-border" "--no-window-dragging" "--no-osc" "--no-osd-bar" abs-video)))))))



;; ORIGINAL Xmobar below
;; (defun laluxx/wal-set-animated ()
;;   (interactive)
;;   (let* ((default-directory "~/xos/wallpapers/animated")
;;          (theme-directory "~/xos/theme")
;;          (pywal-scripts-directory "~/xos/pywal-scripts")
;;          (video-files (directory-files-recursively default-directory "\\.\\(mp4\\|mkv\\|webm\\|avi\\)$"))
;;          (current-buffer-name (buffer-name)))
;;     (ivy-read "Choose animated wallpaper: "
;;               video-files
;;               :action (lambda (video)
;;                         (when (and (not (string-empty-p video))
;;                                    (file-exists-p video))
;;                           (let* ((abs-video (expand-file-name video))
;;                                  (first-frame-image (concat abs-video "-frame1.png")))
;;                             ;; Extract the first frame of the video
;;                             (shell-command-to-string (concat "ffmpeg -i " abs-video " -vframes 1 " first-frame-image))
;;                             ;; Use the extracted frame with `wal` to generate and set the theme (but not set as wallpaper)
;;                             (shell-command-to-string (concat "wal -n -i " first-frame-image))
;;                             ;; Rest of the commands similar to your wal-set function
;;                             (with-temp-file (concat theme-directory "/.wallpaper")
;;                               (insert first-frame-image))
;;                             (shell-command-to-string "theme pywal --no-random")
;;                             (dolist (script '("xmonad-dark-wal.py" "nvim-wal.py" "nvim-wal-dark.py"))
;;                               (shell-command-to-string (concat "python3 " pywal-scripts-directory "/" script)))
;;                             (shell-command-to-string "xmonad --restart")
;;                             (shell-command-to-string "dashboard-wal-gen")
;;                             (when (equal current-buffer-name "*dashboard*")
;;                               (run-at-time "0.5 sec" nil 'open-dashboard))
;;                             (run-at-time "1 sec" nil 'spaceline-compile)
;;                             ;; Finally, set the video as the animated wallpaper
;;                             (start-process "set-animated-wallpaper" nil "xwinwrap" "-o" "1.0" "-nf" "-ovr" "--"
;;                                            "mpv" "-wid" "WID" "--loop-file=inf" "--video-unscaled"
;;                                            "--no-terminal" "--no-audio" "--no-input-default-bindings"
;;                                            "--no-border" "--no-window-dragging" "--no-osc" "--no-osd-bar" abs-video)))))))

(defun laluxx/wal-set-favourite ()
  (interactive)
  (let* ((default-directory "~/xos/wallpapers/favourites")
         (theme-directory "~/xos/theme")
         (pywal-scripts-directory "~/xos/pywal-scripts")
         (image-files (directory-files-recursively default-directory "\\.\\(png\\|jpg\\|jpeg\\|webp\\)$")))
    (ivy-read "Favourite wallpapers: "
              image-files
              :action (lambda (wallpaper)
                        (when (and (not (string-empty-p wallpaper))
                                   (file-exists-p wallpaper))
                          (let ((abs-wallpaper (expand-file-name wallpaper)))
                            (shell-command-to-string (concat "wal -i " abs-wallpaper))
                            (with-temp-file (concat theme-directory "/.wallpaper")
                              (insert abs-wallpaper))
                            (shell-command-to-string "theme pywal --no-random")
                            (dolist (script '("xmonad-dark-wal.py" "nvim-wal.py" "nvim-wal-dark.py"))
                              (shell-command-to-string (concat "python3 " pywal-scripts-directory "/" script)))
                            (shell-command-to-string "xmonad --restart")
                            ;; (shell-command "papirus-wal")
                            ;; (shell-command-to-string "oomox-gtk-gen")
                            (shell-command-to-string "dashboard-wal-gen")
                            ;; (laluxx/load-org-wal-colors)
                            (run-at-time "1 sec" nil 'spaceline-compile)))))))  ; Delay spaceline-compile

(defun laluxx/wal-set-solid ()
  (interactive)
  (let* ((default-directory "~/xos/wallpapers/static")
         (theme-directory "~/xos/theme")
         (pywal-scripts-directory "~/xos/pywal-scripts")
         (solid-wallpapers-directory "~/xos/wallpapers/solid")
         (image-files (directory-files-recursively default-directory "\\.\\(png\\|jpg\\|jpeg\\|webp\\)$")))
    (ivy-read "Wallpapers to turn solid: "
              image-files
              :action (lambda (wallpaper)
                        (when (and (not (string-empty-p wallpaper))
                                   (file-exists-p wallpaper))
                          (let* ((abs-wallpaper (expand-file-name wallpaper))
                                 (base-wallpaper-name (file-name-base wallpaper))  ;; Get the filename without extension
                                 (solid-wallpaper (concat solid-wallpapers-directory "/" base-wallpaper-name "-SOLID.png")))
                            (if (file-exists-p solid-wallpaper)
                                (shell-command-to-string (concat "wal -i " solid-wallpaper))
                              (progn
                                (shell-command-to-string (concat "wal -n -i " abs-wallpaper)) ;; Use wal -n to generate colors without setting wallpaper
                                (shell-command-to-string (concat "wal-set-solid " base-wallpaper-name))))
                            (with-temp-file (concat theme-directory "/.wallpaper")
                              (insert abs-wallpaper))
                            (shell-command-to-string "theme pywal --no-random")
                            (dolist (script '("xmonad-dark-wal.py" "nvim-wal.py" "nvim-wal-dark.py"))
                              (shell-command-to-string (concat "python3 " pywal-scripts-directory "/" script)))
                            (shell-command-to-string "xmonad --restart")
                            (run-at-time "1 sec" nil 'spaceline-compile)))))))  ; Delay spaceline-compile

(defun laluxx/set-wallpaper ()
  (interactive)
  (let* ((default-directory "~/xos/wallpapers/static")
         (image-files (directory-files-recursively default-directory "\\.\\(png\\|jpg\\|jpeg\\|webp\\)$")))
    (ivy-read "Choose wallpaper: "
              image-files
              :action (lambda (wallpaper)
                        (when (and (not (string-empty-p wallpaper))
                                   (file-exists-p wallpaper))
                          (let ((abs-wallpaper (expand-file-name wallpaper)))
                            (shell-command-to-string (concat "feh --bg-scale " abs-wallpaper))))))))

;; work original
(defvar laluxx/last-animated-wallpaper nil "Path to the last set animated wallpaper.")

(defun laluxx/set-animated-wallpaper ()
  (interactive)
  (let* ((default-directory "~/xos/wallpapers/animated")
         (video-files (directory-files-recursively default-directory "\\.\\(mp4\\|mkv\\|webm\\|avi\\)$")))
    (ivy-read "Choose animated wallpaper: "
              video-files
              :action (lambda (video)
                        (when (and (not (string-empty-p video))
                                   (file-exists-p video))
                          (let ((abs-video (expand-file-name video)))
                            ;; Kill mpv if the new wallpaper is different from the last one
                            (when (not (equal abs-video laluxx/last-animated-wallpaper))
                              (shell-command "pkill mpv"))
                            (setq laluxx/last-animated-wallpaper abs-video)
                            (start-process "set-animated-wallpaper" nil "xwinwrap" "-o" "1.0" "-nf" "-ovr" "--"
                                           "mpv" "-wid" "WID" "--loop-file=inf" "--video-unscaled"
                                           "--no-terminal" "--no-audio" "--no-input-default-bindings"
                                           "--no-border" "--no-window-dragging" "--no-osc" "--no-osd-bar" abs-video)))))))

(run-with-idle-timer
 1 nil
 (lambda ()
   (file-notify-add-watch
    "~/.cache/wal/colors"
    '(change)
    (lambda (event)
      (load-theme 'ewal-doom-vibrant t)
      (enable-theme 'ewal-doom-vibrant)))))
