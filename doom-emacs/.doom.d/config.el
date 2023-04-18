(setq user-full-name "Sky Kosiner"
      user-mail-address "yoni@kosiner.co.uk")

(setq doom-font (font-spec :family "Hack Nerd Font Mono" :size 20))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(after! org
  (setq
   org-directory "~/org/"
   org-hide-emphasis-markers t)
  )
(setq doom-theme 'nil)
(setq display-line-numbers-type 'relative)

(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

(use-package tree-sitter-langs :ensure t)

(use-package tree-sitter
  :ensure t
  :after tree-sitter-langs
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package all-the-icons)
(use-package all-the-icons-dired)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c C-l") 'org-insert-link)


(global-set-key (kbd "C-c d") 'helm-lsp-diagnostics)

(map! :i "C-y" 'company-complete-selection)
(global-set-key (kbd "C-c g") 'magit)
(global-set-key (kbd "C-c i") (lambda () (interactive) (find-file "~/org/index.org")))
(global-set-key (kbd "C-c r") (lambda () (interactive) (find-file "~/org/school/revison.org")))
(setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$"))
(define-key ctl-x-map "\C-i"
  #'endless/ispell-word-then-abbrev)

(defun endless/simple-get-word ()
  (car-safe (save-excursion (ispell-get-word nil))))

(defun endless/ispell-word-then-abbrev (p)
  (interactive "P")
  (let (bef aft)
    (save-excursion
      (while (if (setq bef (endless/simple-get-word))
                 ;; Word was corrected or used quit.
                 (if (ispell-word nil 'quiet)
                     nil ; End the loop.
                   ;; Also end if we reach `bob'.
                   (not (bobp)))
               ;; If there's no word at point, keep looking
               ;; until `bob'.
               (not (bobp)))
        (backward-word)
        (backward-char))
      (setq aft (endless/simple-get-word)))
    (if (and aft bef (not (equal aft bef)))
        (let ((aft (downcase aft))
              (bef (downcase bef)))
          (define-abbrev
            (if p local-abbrev-table global-abbrev-table)
            bef aft)
          (message "\"%s\" now expands to \"%s\" %sally"
                   bef aft (if p "loc" "glob")))
      (user-error "No typo at or before point"))))

(setq save-abbrevs 'silently)
(setq-default abbrev-mode t)

;; (set-frame-parameter (selected-frame) 'alpha '(80 80))
;; (add-to-list 'default-frame-alist '(alpha 80 80))
