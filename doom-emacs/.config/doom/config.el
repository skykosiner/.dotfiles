(setq user-full-name "Sky Kosiner"
      user-mail-address "sky@skykosiner.com")

(setq doom-font (font-spec :family "BerkeleyMono Nerd Font":size 16))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq doom-theme 'doom)
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

(obsidian-specify-path "~/Documents/Linux-btw")
;; If you want a different directory of `obsidian-capture':
(setq obsidian-inbox-directory "📥 Inbox")

;; Define obsidian-mode bindings
(add-hook
 'obsidian-mode-hook
 (lambda ()
   ;; Replace standard command with Obsidian.el's in obsidian vault:
   ;; (local-set-key (kbd "C-c C-o") 'obsidian-follow-link-at-point)

   ;; Use either `obsidian-insert-wikilink' or `obsidian-insert-link':
   (local-set-key (kbd "C-c C-l") 'obsidian-insert-wikilink)

   ;; Following backlinks
   (local-set-key (kbd "C-c C-b") 'obsidian-backlink-jump)))

;; Optionally you can also bind `obsidian-jump' and `obsidian-capture'
;; replace "YOUR_BINDING" with the key of your choice:
(global-set-key (kbd "C-c C-o") 'obsidian-jump)
(global-set-key (kbd "C-c C-c") 'obsidian-capture)

;; Activate detection of Obsidian vault
(global-obsidian-mode t)

;; (setq-default elfeed-search-filter "@2-weeks-ago +unread")
(setq-default elfeed-search-title-max-width 100)
(setq-default elfeed-search-title-min-width 100)

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
