;;; xos-catppuccin-mocha-theme.el --- Theme


;;; Commentary:



;;;; Code:

(deftheme xos-catppuccin-mocha
  "A mocha theme inspired by Catppuccin colors for Emacs.")

(let ((class '((class color) (min-colors 89)))
      ;; Color definitions
      (rosewater "#f5e0dc")
      (flamingo "#f2cdcd")
      (pink "#f5c2e7")
      (mauve "#cba6f7")
      (red "#f38ba8")
      (maroon "#eba0ac")
      (peach "#fab387")
      (yellow "#f9e2af")
      (green "#a6e3a1")
      (teal "#94e2d5")
      (sky "#89dceb")
      (sapphire "#74c7ec")
      (blue "#89b4fa")
      (lavender "#b4befe")
      (text "#cdd6f4")
      (subtext1 "#bac2de")
      (subtext0 "#a6adc8")
      (overlay2 "#9399b2")
      (overlay1 "#7f849c")
      (overlay0 "#6c7086")
      (surface2 "#585b70")
      (surface1 "#45475a")
      (surface0 "#313244")
      (base "#1e1e2e")
      (mantle "#181825")
      (crust "#11111b"))

  ;; Face customizations
  (custom-theme-set-faces
   'xos-catppuccin-mocha
   
   `(default ((,class (:background ,base :foreground ,text))))
   `(cursor ((,class (:background ,text))))
   `(region ((,class (:background ,overlay2))))
   `(font-lock-builtin-face ((,class (:foreground ,mauve))))
   `(font-lock-comment-face ((,class (:foreground ,subtext1))))
   `(font-lock-constant-face ((,class (:foreground ,yellow))))
   `(font-lock-function-name-face ((,class (:foreground ,green))))
   `(font-lock-keyword-face ((,class (:foreground ,blue))))
   `(font-lock-string-face ((,class (:foreground ,rosewater))))
   `(font-lock-type-face ((,class (:foreground ,teal))))
   `(font-lock-variable-name-face ((,class (:foreground ,peach))))
   `(font-lock-warning-face ((,class (:foreground ,red :weight bold))))
   `(fringe ((,class (:background ,surface1))))
   `(header-line ((,class (:background ,surface2))))
   `(highlight ((,class (:background ,overlay0))))
   `(lazy-highlight ((,class (:background ,overlay1))))
   `(mode-line ((,class (:background ,surface2 :foreground ,text))))
   `(mode-line-inactive ((,class (:background ,surface1 :foreground ,subtext1))))
   `(secondary-selection ((,class (:background ,overlay2))))
   `(shadow ((,class (:foreground ,subtext0))))
   `(trailing-whitespace ((,class (:background ,red))))
   `(vertical-border ((,class (:foreground ,overlay0)))))

   ;; And so on for other face definitions...
   )

(provide-theme 'xos-catppuccin-mocha)

(provide 'xos-catppuccin-mocha)

;;; xos-catppuccin-mocha.el ends here

