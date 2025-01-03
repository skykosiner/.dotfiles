(setq user-full-name "Sky Kosiner"
      user-mail-address "sky@skykosiner.com")

(setq doom-font (font-spec :family "TX-02":size 23))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq doom-theme 'doom-one)
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

(global-set-key (kbd "C-c l") 'display-line-numbers-mode)

(global-set-key (kbd "C-c d") 'helm-lsp-diagnostics)

(map! :i "C-y" 'company-complete-selection)
(global-set-key (kbd "C-c g") 'magit)

(global-set-key (kbd "C-c i") 'lsp-ui-imenu)

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

;; Start to scroll 8 lines before the end
(setq scroll-margin 8)
(setq smooth-scroll-margin 8)

;; Transpparent emacs
;; (set-frame-parameter (selected-frame) 'alpha '(95 95))
;; (add-to-list 'default-frame-alist '(alpha 95 95))

;; Automatically start eglot when entering a new project
(add-hook 'projectile-after-switch-project-hook 'eglot-ensure)

;; Format go code on save
(add-hook 'before-save-hook 'gofmt-before-save)
