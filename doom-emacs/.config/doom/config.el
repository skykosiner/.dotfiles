(setq user-full-name "Sky Kosiner"
      user-mail-address "sky@skykosiner.com")

(setq doom-font (font-spec :family "Hack Nerd Font Mono":size 25))
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

;; Auto tangle org mode configs
(add-hook 'org-mode-hook 'org-auto-tangle-mode)

;; Transpparent emacs
(set-frame-parameter (selected-frame) 'alpha '(90 90))
(add-to-list 'default-frame-alist '(alpha 90 90))
