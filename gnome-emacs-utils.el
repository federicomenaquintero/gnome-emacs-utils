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

(add-to-list 'auto-mode-alist '("\\.page\\'" . xml-mode))

(add-hook 'nxml-mode-hook
	  (lambda ()
	    ;; FIXME: this has an absolute pathname.  How should we locate this file?
	    (add-to-list 'rng-schema-locating-files
			 "/home/federico/src/gnome-emacs-utils/mallard-locating-schema.xml")

	    ;; FIXME: In theory calling rng-auto-set-schema-and-validate below should not be necessary, because
	    ;; nxml-mode does it automatically when you load a file.  However, it *is* necessary for the
	    ;; *first* time you load an XML/Mallard file into Emacs.  Our function for nxml-mode-hook runs
	    ;; *after* nxml-mode is started, and so we don't have a chance to tweak rng-schema-locating-files
	    ;; until after the file has been loaded.  I guess nxml-mode assumes that the *user* will be
	    ;; customizing this variable, but we want gnome-emacs-utils to add values to it itself, without
	    ;; user intervention.
	    (rng-auto-set-schema-and-validate)))
