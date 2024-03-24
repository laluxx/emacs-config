(org-babel-load-file
 (expand-file-name
  "config.org"
  user-emacs-directory))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("8d412c0ed46b865312d6df5c1dfd1821d349dd3cba00049cf88c4ad34403597e" "f4e05e6f2ec50b1ed61aa406b478fb95caa3994f07622fb97022216a5538d321" "dc2e1b0abb9a5d2033f6d881618932dcdb9af7633d8fa44336f9c9a3484379bd" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" "6945dadc749ac5cbd47012cad836f92aea9ebec9f504d32fe89a956260773ca4" "944d52450c57b7cbba08f9b3d08095eb7a5541b0ecfb3a0a9ecd4a18f3c28948" "636b135e4b7c86ac41375da39ade929e2bd6439de8901f53f88fde7dd5ac3561" "1f669e8abe4dc2855268c9a607b5e350e2811b3c5afd09af5939ff0c01a89c5a" default))
 '(inhibit-startup-screen t)
 '(org-agenda-files '("~/.config/emacs/config.org"))
 '(package-selected-packages
   '(visual-fill-column watch-buffer smooth-scroll ewal-doom-themes ewal theme-magic))
 '(warning-suppress-types '((emacs) (emacs))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(deadgrep-filename-face ((t (:inherit org-level-1))))
 '(deadgrep-match-face ((t (:inherit font-lock-constant-face))))
 '(minibuffer-prompt ((t (:family "JetBrains Mono NL ExtraBold" :height 120))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.7))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.6))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.5))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.4))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.3))))
 '(org-level-6 ((t (:inherit outline-5 :height 1.2))))
 '(org-level-7 ((t (:inherit outline-5 :height 1.1)))))
