;;; utils.lisp --- Utils for iiiika

;; File:        utils.lisp
;; Description: Utils for iiiika
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-02-13 14:34
;; Version: 0.0.0
;; Last-Updated: 2025-02-13 16:01
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

(in-package :iiiika)

;; Note:
;; in order to build and port to JSCL, here's the compatibiliy
;; layer of some missing JSCL features in Common Lisp.
;;
;; this would not affect how it works under normal Lisp distribution
;; (like SBCL or so)

#-jscl (declaim (inline make-keyword))
(defun make-keyword (elem)
  "Make keyword (copied from alexandria:make-keyword). "
  #-jscl (alexandria:make-keyword elem)
  #+jscl (etypecase elem
           (string (intern elem :keyword))
           (symbol (intern (symbol-name elem) :keyword))))

#-jscl (declaim (inline param-case))
(defun param-case (str)
  "Make string like `param-case'. (like `str:param-case'). "
  (declare (string str))
  #-jscl (str:param-case (string-upcase str))
  #+jscl (map 'string
              (lambda (char)
                (if (char= char #\_) #\- char))
              (string-upcase str)))

#-jscl (declaim (inline gethash*))
(defun gethash+ (key hash-table &optional default)
  "For JSCL:
If `key' is character, use `char-code' as hash key.
For other situation, `gethash*' is equal to `gethash'. "
  (declare (type hash-table hash-table))
  #-jscl (gethash key hash-table default)
  #+jscl (if (characterp key)
             (gethash (char-code key) hash-table default)
             (gethash key hash-table default)))

(defun (setf gethash+) (value key hash-table &optional default)
  (declare (type hash-table hash-table))
  (declare (ignore default))
  #-jscl (setf (gethash key hash-table) value)
  #+jscl (if (characterp key)
             (setf (gethash (char-code key) hash-table) value)
             (setf (gethash key hash-table) value)))

;;; utils.lisp ends here
