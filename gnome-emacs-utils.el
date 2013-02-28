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

;;; FIXME: this has an absolute pathname.  How should we locate this file?
(add-to-list 'rng-schema-locating-files "/home/federico/src/gnome-emacs-utils/mallard-locating-schema.xml" t)
