;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(after! org
        (defvar org-dir "~/Dropbox/org/")
        (setq org-directory "~/Dropbox/org/" )
        (setq org-agenda-files (list org-dir))
        ;;(add-to-list 'org-modules 'org-habit)
        ;(setq org-habit-show-habits-only-for-today t)
        (add-to-list 'org-modules 'org-habit)
        (setq org-habit-show-habits t)
        (setq org-habit-graph-column 60)
        (setq org-habit-following-days 3)
        (setq org-habit-show-all-today t)
        (setq org-deadline-warning-days 14)
        (setq org-todo-keywords '((sequence "TODO(t)" "|" "ONHOLD" "DONE(d)")))
;(setq org-todo-keywords
;      '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELED(c@)")))
        (setq org-capture-templates
              '(
                ("l" "Lunch" entry (file+datetree "~/Dropbox/org/notes.org" )
                 "* lunch%?\n%U\n:PROPERTIES:\n:Meal: lunch\n:END:\n%^{Description}")
                ("t" "TODO" entry (file+headline "~/Dropbox/org/notes.org" "Tasks")
                 "* TODO %^{Description}  \n%?\nAdded: %U")
                ("w" "Weight" table-line
                 (id "7c721aac-eafa-4a42-9354-fbc151402510")
                 "| | %U | %^{Weight} | %^{Fat}" :immediate-finish t)
                ("a" "alcohol" table-line
                 (id "4793ddda-7c57-4b92-bcdd-b8f937aaf9d4")
                 "| | %U | %^{Units} | %^{Comment}" :immediate-finish t)

                ("d" "Dinner" entry (file+datetree "~/Dropbox/org/notes.org" )
                 "* Dinner%?\n%U\n:PROPERTIES:\n:Meal: Dinner\n:END:\n%^{Description}")
                ))
        )

(setq lsp-metals-java-home "/usr/lib/jvm/java-1.11.0-openjdk-amd64")
