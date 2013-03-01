;; Gnome-emacs-utils - Emacs utilities for Gnome developers
;; Copyright (C) 2013 Federico Mena Quintero
;;
;; Authors: Federico Mena Quintero <federico@gnome.org>
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.


;; Make Emacs know about Mallard documents
;;
;; To ensure that this works, load a .page file (a Mallard document)
;; and check for these:
;;
;; 1. The modeline should show nXML mode.
;;
;; 2. Hit C-c C-s C-w and the minibuffer should tell you, "Using schema /usr/share/xml/mallard/1.0/mallard.rnc"
;;    or something similar.  If it tells you "Using vacuous schema" instead, it means
;;    that nxml-mode did not find the mallard.rnc file on your system.  Check that the
;;    path for mallard.rnc is correct in gnome-emacs-utils/mallard-locating-schema.xml

;; FIXME: this has an absolute pathname.  How should we locate this file?
(defvar gnome/mallard-locating-schema "/home/federico/src/gnome-emacs-utils/mallard-locating-schema.xml")

(add-to-list 'auto-mode-alist '("\\.page\\'" . xml-mode))

(require 'nxml-mode)

(push gnome/mallard-locating-schema rng-schema-locating-files)

;; We advice nxml-mode with our checking code, instead of putting
;; something in nxml-mode-hook, as the hook will not run if an error
;; happens while the nxml-mode function is being run.  For example,
;; a hook would not run if nxml-mode fails to open the mallard.rnc file.

(defadvice nxml-mode (after gnome/check-mallard-schema-is-being-used protect activate)
  "After nxml-mode has been activated, checks if the file in the buffer
is a .page file (i.e. a Mallard document).  If so, this funtion checks that
the RNG/RNC schema file for Mallard is indeed being used, and tells the
user about it.  This is to ensure that Mallard's schema files and
gnome-emacs-utils in general are installed correctly."
  (interactive)
  (when (string-match "\\.page$" buffer-file-name)
    (if (and rng-current-schema-file-name
	     (string-match "mallard.rnc$" rng-current-schema-file-name))
	(rng-what-schema) ;; This will print "Using mallard.rnc" on the minibuffer, to reassure the user
      (message "Mallard schema is not loaded; please fix gnome/mallard-locating-schema in gnome-emacs-utils.el and ensure the Mallard schema is installed")
      (sit-for 2))))
