;;; jscl-compile.lisp --- Using JSCL to compile the system

;; File:        jscl-compile.lisp
;; Description: Using JSCL to compile the system
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-02-14 06:42
;; Version: 0.0.0
;; Last-Updated: 2025-02-16 11:59
;;           By: 凉凉
;; URL:
;; Keywords:
;; Compatibility:
;;
;;

;;; License
;;
;; this package is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published
;; by the Free Software Foundation, either version 3 of the License,
;; or (at your option) any later version.
;;
;; this package is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this package. If not, see <https://www.gnu.org/licenses/>.

(in-package :iiiika/web)

;;; Setup env

;; To begin, you need to load JSCL* first.
;; *: https://github.com/jscl-project/jscl
;;
;;     (load "/path/to/jscl.lisp")

;; you need to bootstrap JSCL once.
;;
;;     (jscl:bootstrap)
;;
;; after which, copy the generated jscl.js to /js/jscl.js

;;; Configurable variables

(defvar *iiiika-web-path*
  (asdf:system-relative-pathname :iiiika "./")
  "Path to IIIIka sources. ")

;;; Compile

(defun compile-to-js (target src-dir &rest srcs)
  "Compile `srcs' under `src-dir' to `target' js.
Note: the `srcs' should come in dependency sequence. "
  (let ((*features* (cons :jscl *features*)))
    (uiop:with-current-directory ((format NIL "~A/~A/" *iiiika-web-path* src-dir))
      (jscl:compile-application srcs (format NIL "~A/js/~A" *iiiika-web-path* target)))))

;; iiiika/web

(defun compile-iiiika-web ()
  ;; This is core JSCL<->Lisp utils
  (compile-to-js "iiiika-web.js" "jscl"
                 "package.lisp"
                 "utils.lisp"
                 "config.lisp"
                 "js-layer.lisp")

  ;; This is a little wired, IIIIka depends on IIIIka/WEB,
  ;; while iiiika-main.js depends on IIIIka....
  (compile-to-js "iiiika-main.js" "jscl"
                 "main.lisp")

  ;; compile translations and byname
  (maphash
   (lambda (language val)
     (declare (ignore val))
     (let ((file (format NIL "translation-~(~A~).lisp" language)))
       (assert (uiop:file-exists-p (format NIL "~A/jscl/~A" *iiiika-web-path* file)))
       (compile-to-js (format NIL "translation-~(~A~).js" language) "jscl" file)))
   *common-message*)

  (maphash
   (lambda (language val)
     (declare (ignore val))
     (let ((file (format NIL "byname-~(~A~).lisp" language)))
       (assert (uiop:file-exists-p (format NIL "~A/jscl/~A" *iiiika-web-path* file)))
       (compile-to-js (format NIL "byname-~(~A~).js" language) "jscl" file)))
   *byname*))

;; iiiika-core.js
;; This will build the core part of iiiika.
;; IIIIka should depends on IIIIka/WEB

(defun compile-iiiika-core ()
  (compile-to-js "iiiika.js" "lisp"
                 "package.lisp"
                 "utils.lisp"
                 "characters.lisp"
                 "character-sets.lisp"
                 "core.lisp"))

;; iiiika-base.js
;; This is splited for incremental compiling.

(defun compile-iiiika-base ()
  (compile-to-js "iiiika-base.js" "lisp"
                 "base.lisp"))

(defun compile-iiiika ()
  "Compile all for IIIIka. "
  (compile-iiiika-web)
  (compile-iiiika-core)
  (compile-iiiika-base))

;;; jscl-compile.lisp ends here
