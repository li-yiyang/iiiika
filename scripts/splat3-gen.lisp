;;; splat3-gen.lisp --- Generate lisp data from splat3_CNzh_unicode.json

;; File:        splat3-gen.lisp
;; Description: Generate lisp data from splat3_CNzh_unicode.json
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-02-14 08:34
;; Version: 0.0.0
;; Last-Updated: 2025-02-14 08:34
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

;;; Credits
;; The splat3_CNzh_unicode.json is from Leanny's repo*.
;; *: https://github.com/Leanny/splat3

;;; Dependency
;;
;;    (ql:quickload :shasht)

;;; Configurable variables

(defvar *iiiika-web-path*
  (asdf:system-relative-pathname :iiiika "./")
  "Path to IIIIka sources. ")

(defparameter *splat3*
  (with-open-file (splat3 (merge-pathnames "./scripts/splat3_CNzh_unicode.json"
                                           *iiiika-web-path*))
    (shasht:read-json splat3))
  "Please refer to `splat3_CNzh_unicode.json' for details. ")

;;; Generate

;; generate header infomation

(defmacro with-gen-lisp ((stream file &key description) &body body)
  (let ((name (gensym "NAME")))
    `(with-open-file (,stream (merge-pathnames
                               ,file
                               (merge-pathnames "./jscl/" *iiiika-web-path*))
                              :direction         :output
                              :if-exists         :supersede
                              :if-does-not-exist :create)
       (let ((,name (file-namestring ,file)))
         (format ,stream ";;; ~A --- ~A

;; This file is auto generated.
;; Not recommanded to edit by hand.

;; File:        ~A
;; Description: ~A
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Version: 0.0.0
;; URL:
;; Keywords:
;; Compatibility: JSCL, scripts/splat3-gen.lisp
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

"
                 ,name ,description ,name ,description)
         ,@body
         (format stream "~&~%;;; ~A ends here" ,name)))))

;; byname adj

(defun gen-byname (&optional (language *language*))
  "Generate a `byname-<language>.lisp'. "
  (declare (keyword language))
  (let ((file (format NIL "byname-~(~A~).lisp" language))
        (desc (format NIL "Byname in ~A" language)))
    (with-gen-lisp (stream file :description desc)
      (format stream "(in-package :iiiika/web)~%~%")
      (format stream "(define-byname-adj :~A~%" language)
      (maphash (lambda (key adj)
                 (declare (ignore key))
                 (format stream "  ~S~%" adj))
               (gethash "CommonMsg/Byname/BynameAdjective" *splat3*))
      (format stream ")~%~%")
      (format stream "(define-byname-noun :~A~%" language)
      (maphash (lambda (key noun)
                 (declare (ignore key))
                 ;; strip [group...] like noun
                 (when (char/= (aref noun 0) #\[)
                   (format stream "  ~S~%" noun)))
               (gethash "CommonMsg/Byname/BynameSubject" *splat3*))
      (format stream ")~%~%"))))

;; byname noun

(gen-byname :cn-zh)

;;; splat3-gen.lisp ends here
