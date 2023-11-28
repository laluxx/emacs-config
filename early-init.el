;;; package --- Summary
;;; Commentary:
;;; Code:

;; Function to read the background color from static-variables file
(defun laluxx/read-background-color ()
  (when (file-exists-p "~/.config/emacs/static-variables")
    (with-temp-buffer
      (insert-file-contents "~/.config/emacs/static-variables")
      (goto-char (point-min))
      (forward-line 1) ;; Move to the second line
      (buffer-substring-no-properties (line-beginning-position) (line-end-position)))))


;; Reading background color
(let ((background-color (laluxx/read-background-color)))
  (when background-color
    ;; Set the background color for initial frame
    (setq default-frame-alist `((background-color . ,background-color)))))




(setq package-enable-at-startup nil)

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(provide 'early-init)
;;; early-init.el ends here
