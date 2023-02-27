;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Sky Kosiner"
      user-mail-address "yoni@kosiner.co.uk")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Inconsolata Nerd Font" :size 40))
(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))
(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(after! org
  (setq
   org-directory "~/org/"
   org-agenda-block-separator 45
   org-hide-emphasis-markers t)
  )

     ;; doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

; TURN OFF DAMN AUTOPAIRS
(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

;; (use-package undo-tree
;; :ensure t
;; :init
;; (global-undo-tree-mode))

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

;; Lsp stuff
(global-set-key (kbd "C-c d") 'helm-lsp-diagnostics)

(map! :i "C-y" 'company-complete-selection)
;; Find way to unmap enter from company-complete-selection
;; (global-set-key (kbd "C-m") nil)

;; Open magit
(global-set-key (kbd "C-c g") 'magit)

;; Note stuff with org
(global-set-key (kbd "C-c i") (lambda () (interactive) (find-file "~/org/index.org")))

;; (setq org-agenda-files (list "~/org"))
(setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$"))

;; Spell me daddy
(define-key ctl-x-map "\C-i"
  #'endless/ispell-word-then-abbrev)

(defun endless/simple-get-word ()
  (car-safe (save-excursion (ispell-get-word nil))))

(defun endless/ispell-word-then-abbrev (p)
;; "Call `ispell-word', then create an abbrev for it.
;; With prefix P, create local abbrev. Otherwise it will
;; be global.
;; If there's nothing wrong with the word at point, keep
;; looking for a typo until the beginning of buffer. You can
;; skip typos you don't want to fix with `SPC', and you can
;; abort completely with `C-g'."
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

;; SPOTIFY CONTROL IN EMACS
(setq smudge-oauth2-client-secret "499f45c0540c42a4afab64d38b3f5ab2")
(setq smudge-oauth2-client-id "3b360e20f6e44db28e576110ae6975e7")
(global-set-key (kbd "C-c .") 'smudge-command-map)

(setq elfeed-feeds
      '(
        ("https://macstories.net/rss" apple)
        ("https://lukesmith.xyz/rss.xml" tech)
))

(setq-default elfeed-search-filter "@90-days-ago +unread")
(setq-default elfeed-search-title-max-width 100)
(setq-default elfeed-search-title-min-width 100)


;; HARPOON
(global-set-key (kbd "C-c a") 'harpoon-add-file)
(global-set-key (kbd "C-c h") 'harpoon-go-to-1)
(global-set-key (kbd "C-c t") 'harpoon-go-to-2)
(global-set-key (kbd "C-c n") 'harpoon-go-to-3)
(global-set-key (kbd "C-c s") 'harpoon-go-to-4)
