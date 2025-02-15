;;; utils.lisp --- Utils for JSCL and IIIIka/web

;; File:        utils.lisp
;; Description: Utils for JSCL and IIIIka/web
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-02-14 19:27
;; Version: 0.0.0
;; Last-Updated: 2025-02-14 19:27
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

(defun js-like-case (string)
  "Trun a-like-string to aLikeString. "
  (with-output-to-string (js-like)
    (let ((break-p NIL))
      (map NIL
           (lambda (char)
             (cond ((char= #\- char) (setf break-p T))
                   (break-p
                    (write-char (char-upcase char) js-like)
                    (setf break-p NIL))
                   (T                (write-char (char-downcase char) js-like))))
           string))))

(defun gethash* (hash-table &rest keys)
  "Get nested `hash-table' value by unpacking the `keys'. "
  (if (endp keys)
      hash-table
      (when (hash-table-p hash-table)
        (apply #'gethash* (gethash (first keys) hash-table) (rest keys)))))

(defun list->array (list)
  (map 'vector #'identity list))

(defun array->list (array)
  (map 'list #'identity array))

;;; utils.lisp ends here
