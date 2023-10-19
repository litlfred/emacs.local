;; Emacs Load Path 
(setq load-path (cons "~/.emacs.local" load-path))

(require 'php-mode)

(setq-default save-place t)
(setq indent-tabs-mode nil)
(setq c-default-style "bsd" c-basic-offset 4)


(global-font-lock-mode 't)


(setq delete-old-versions 'f) 

(setq indent-tabs-mode nil)

(set-background-color nil)

(require 'uniquify) 
(setq 
  uniquify-buffer-name-style 'forward
  uniquify-separator "/")



;;(autoload 'javascript-mode "javascript-mode" nil t)
(autoload 'javascript-mode "javascript" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
(defun jslint-thisfile ()
  (interactive)
  (compile (format "jsl -process %s" (buffer-file-name))))

(add-hook 'javascript-mode-hook
  '(lambda ()
  (local-set-key [f8] 'jslint-thisfile)))

;;(autoload 'php-lint "php-lint-mode" nil t)
;;(autoload 'php-lint-mode "php-lint-mode" nil t)


(defun sw-php-lint () "Run a lint check on the file the current buffer is visiting." 
  (interactive) 
  (let 
      ( (php-interpreter "/usr/bin/php -l") ) 
    ;;(shell-command (format "%s %s" php-interpreter (buffer-file-name))) 
    (compile (format "%s %s" php-interpreter (buffer-file-name))) 
    )
  )

(defun my-php-lint () "Run a lint check on the file the current buffer is visiting." 
  (interactive) 
  (compile (format "php -l %s" (buffer-file-name))))


(add-hook 'php-mode-hook 
  '(lambda () 
     (local-set-key [f8] 'my-php-lint)
     (auto-fill-mode 0)
     (c-set-style '"bsd")
     (setq indent-tabs-mode nil)
     (setq c-basic-offset 4)
     (set-face-foreground 'font-lock-warning-face "red")
     (set-face-background 'font-lock-warning-face nil)
     (setq compilation-error-regexp-alist  '(("Parse error: .*in\\(.*\\)on line\\([0-9]+\\)" 1 2)))
     ))
;;  (local-set-key [f8] 'sw-php-lint)))
;;  (local-set-key [f8] 'php-lint)))

;;(require 'flymake-php)
;;(add-hook 'php-mode-user-hook 'flymake-php-load)


(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

(add-hook 'yaml-mode-hook
	  '(lambda ()
;;	     (local-set-key "\C-m" 'newline-and-indent)
	     ))





;; Automatically enable php-lint-mode for php-mode
;;(eval-after-load "php-mode" '(add-hook 'php-mode-hook 'php-lint-mode))

(autoload 'nxml-mode "nxml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.html\\'" . nxml-mode))




(global-set-key "\C-t" 'copy-region-as-kill)
(global-set-key "\C-o" 'undo)
(global-set-key "\C-p" 'delete-region)


(define-key function-key-map "\e[1;5C" [C-right])
(define-key function-key-map "\e[1;5D" [C-left])

(global-set-key [(C-right)] 'forward-word)
(global-set-key [(C-left)] 'backward-word) 
(global-set-key [(C-down)] 'end-of-buffer)
(global-set-key [(C-up)] 'beginning-of-buffer)



(define-key function-key-map "\eO1;5A" [C-up])
(define-key function-key-map "\eO1;5B" [C-down])
(define-key function-key-map "\eO1;5C" [C-right])
(define-key function-key-map "\eO1;5D" [C-left])



;; display the current time 
(display-time) 
;; Show column number at bottom of screen 
(column-number-mode 1)
;; goo line function C-c C-g 
(global-set-key [ (control c) (control g) ] 'goto-line)

;; disable startup message
(setq inhibit-startup-message t)

;; Pgup/dn will return exactly to the starting point. 
(setq scroll-preserve-screen-position 1)

;; scroll just one line when hitting the bottom of the window
(setq scroll-step 1)
(setq scroll-conservatively 1)

;; show a menu only when running within X (save real estate when
;; in console)
(menu-bar-mode (if window-system 1 -1))

(setq tags-table-list '("~/alf/I2CE"))
(global-set-key (kbd "M-,") 'complete-tag)




(defun litlfreds-create-function (name type) (interactive "*sfunction name:\ncprIvate/prOtected/pUblic:")
  (let ( (function-begin (point))  function-parameters function-end)
    (save-excursion 
      (insert "/**\n")
      (insert (concat "   * function "  name "\n"))
      (insert "* \n")
      (insert "* @param \n")
      (insert "* @return \n")
      (insert "*/\n")
      (cond ((equal type ?i)   (insert "private"))
	    ((equal type ?o)   (insert "protected"))
	    ((equal type ?u)   (insert "public"))
	    )
      (insert (concat " function "  name " (")) 
      (setq function-parameter (point))
      (indent-region function-begin function-parameter nil)
      (setq function-parameter (point))
      (insert ") {\n\n\n\n")
      (insert "}\n\n")
      (setq function-end (point))
      (indent-region function-parameter function-end nil)
      )
    (goto-char function-parameter)
    )
)


(defun litlfreds-i2ce-file (class package subpackage version) (interactive "sclass name:\nspackage name:\nssubpackage name:\nsversion:")
  (let ( class-begin) 
    (switch-to-buffer (concat "class "  class " {\n\n\n\n"))
    (save-excursion
     (insert "<?php\n")
     (insert "/**\n")
     (insert (concat "* © Copyright " (substring (current-time-string) 20 24)  " IntraHealth International, Inc.\n"))
     (insert "* \n")
     (insert "* This File is part of I2CE \n")
     (insert "* \n")
     (insert "* I2CE is free software; you can redistribute it and/or modify \n")
     (insert "* it under the terms of the GNU General Public License as published by \n")
     (insert "* the Free Software Foundation; either version 3 of the License, or\n")
     (insert "* (at your option) any later version.\n")
     (insert "* \n")
     (insert "* This program is distributed in the hope that it will be useful, \n")
     (insert "* but WITHOUT ANY WARRANTY; without even the implied warranty of \n")
     (insert "* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the \n")
     (insert "* GNU General Public License for more details.\n")
     (insert "* \n")
     (insert "* You should have received a copy of the GNU General Public License \n")
     (insert "* along with this program.  If not, see <http://www.gnu.org/licenses/>.\n")
     (insert (concat "* @package " package "\n"))
     (insert (concat "* @subpackage " subpackage "\n"))
     (insert "* @author Carl Leitner <litlfred@ibiblio.org>\n")
     (insert (concat "* @version v" version "\n"))
     (insert (concat "* @since v" version "\n"))
     (insert "* @filesource \n")
     (insert "*/ \n")
     (insert "/** \n")
     (insert (concat "* Class " class "\n"))
     (insert "* \n")
     (insert "* @access public\n")
     (insert "*/\n\n\n")
     (insert (concat "class "  class " "))
     (setq class-begin (point))
     (insert "{\n\n\n\n")
     (insert "}\n")
     (insert "# Local Variables:\n")
     (insert "# mode: php\n")
     (insert "# c-default-style: \"bsd\"\n")
     (insert "# indent-tabs-mode: nil\n")
     (insert "# c-basic-offset: 4\n")
     (insert "# End:\n")
     (set-visited-file-name (concat class ".php"))
     )
    (goto-char class-begin)
    (php-mode)
    )
)







(defun litlfreds-php-code-thing ()
  (setq php-completion-file "~/.emacs.d/lisp/php-completions.txt")
  (define-key php-mode-map "\M-\\" 'litlfreds-create-function)
  (define-key php-mode-map "\M-l" 'php-complete-function)
  (turn-on-eldoc-mode)
)
(add-hook 'php-mode-user-hook 'litlfreds-php-code-thing)
(global-set-key  "\C-\\" 'litlfreds-i2ce-file)
  
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((c-default-style . bsd) (c-default-style . "bsd"))))
 '(speedbar-frame-parameters (quote ((minibuffer) (width . 20) (border-width . 0) (menu-bar-lines . 0) (tool-bar-lines . 0) (unsplittable . t) (set-background-color "black")))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(background "blue")
 '(font-lock-builtin-face ((((class color) (background dark)) (:foreground "Turquoise"))))
 '(font-lock-comment-face ((t (:foreground "MediumAquamarine"))))
 '(font-lock-constant-face ((((class color) (background dark)) (:bold t :foreground "DarkOrchid"))))
 '(font-lock-doc-string-face ((t (:foreground "green2"))))
 '(font-lock-function-name-face ((t (:foreground "SkyBlue"))))
 '(font-lock-keyword-face ((t (:bold t :foreground "CornflowerBlue"))))
 '(font-lock-preprocessor-face ((t (:italic nil :foreground "CornFlowerBlue"))))
 '(font-lock-reference-face ((t (:foreground "DodgerBlue"))))
 '(font-lock-string-face ((t (:foreground "LimeGreen"))))
 '(font-lock-type-face ((t (:foreground "#9290ff"))))
 '(font-lock-variable-name-face ((t (:foreground "PaleGreen"))))
 '(font-lock-warning-face ((((class color) (background dark)) (:foreground "yellow" :background "red"))))
 '(highlight ((t (:background "CornflowerBlue"))))
 '(list-mode-item-selected ((t (:background "gold"))))
 '(makefile-space-face ((t (:background "wheat"))))
 '(mode-line ((t (:background "Navy"))))
 '(paren-match ((t (:background "darkseagreen4"))))
 '(region ((t (:background "DarkSlateBlue"))))
 '(show-paren-match ((t (:foreground "black" :background "wheat"))))
 '(show-paren-mismatch ((((class color)) (:foreground "white" :background "red"))))
 '(speedbar-button-face ((((class color) (background dark)) (:foreground "green4"))))
 '(speedbar-directory-face ((((class color) (background dark)) (:foreground "khaki"))))
 '(speedbar-file-face ((((class color) (background dark)) (:foreground "cyan"))))
 '(speedbar-tag-face ((((class color) (background dark)) (:foreground "Springgreen"))))
 '(vhdl-speedbar-architecture-selected-face ((((class color) (background dark)) (:underline t :foreground "Blue"))))
 '(vhdl-speedbar-entity-face ((((class color) (background dark)) (:foreground "darkGreen"))))
 '(vhdl-speedbar-entity-selected-face ((((class color) (background dark)) (:underline t :foreground "darkGreen"))))
 '(vhdl-speedbar-package-face ((((class color) (background dark)) (:foreground "black"))))
 '(vhdl-speedbar-package-selected-face ((((class color) (background dark)) (:underline t :foreground "black"))))
 '(widget-field ((((class grayscale color) (background light)) (:background "DarkBlue")))))
