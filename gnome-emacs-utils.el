;;; Make Emacs know about Mallard documents
;;;
;;; To ensure that this works, load a .page file (a Mallard document)
;;; and check for these:
;;;
;;; 1. The modeline should show nXML mode.
;;;
;;; 2. Hit C-c C-s C-w and the minibuffer should tell you, "Using schema /usr/share/xml/mallard/1.0/mallard.rnc"
;;;    or something similar.  If it tells you "Using vacuous schema" instead, it means
;;;    that nxml-mode did not find the mallard.rnc file on your system.  Check that the
;;;    path for mallard.rnc is correct in gnome-emacs-utils/mallard-locating-schema.xml

(add-to-list 'auto-mode-alist '("\\.page\\'" . xml-mode))

;;; FIXME: this has an absolute pathname.  How should we locate this file?
(add-to-list 'rng-schema-locating-files "/home/federico/src/gnome-emacs-utils/mallard-locating-schema.xml" t)
