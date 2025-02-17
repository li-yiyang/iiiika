;;; core.lisp --- Core replacement rules for IIIIka

;; File:        core.lisp
;; Description: Core replacement rules for IIIIka
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-02-13 14:36
;; Version: 0.0.0
;; Last-Updated: 2025-02-16 11:30
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

(define-condition iiiika-error (error)
  ((elem :initarg :elem)
   (msg  :initarg :msg)))

(define-condition unknown-rule (iiiika-error) ())

(define-condition invalid-rule (iiiika-error) ())

(defparameter *strictp* T)

(defparameter *default-fallback-character*
  "ロ"
  "Default fallback character when `ikasu-char' failed
to find rule for the input character. ")

(defparameter *rule-table*
  (make-hash-table)
  "A simplified mapping rule table.

The rule table should be like:

    {char | keyword} -> ({char | keyword | list})

FROM
+ `char' chinese word;
+ `keyword' nickname of the `char',
  also could be used as defining phrase and shortcuts;

TO
+ `char' and `keyword' should be another FROM element
  in `*rule-table*';
+ `list' should be the character (use `find-character'
  to index the character)

Use `defrule' and `defrule*' to define the mapping rule.
")

(defun ikasu-char (char &optional (fallback *default-fallback-character*))
  "Make char ikasu by `*rule-table*'.
Return an ikasu string. "
  (declare (type (or character keyword list) char))
  (handler-case
      (with-output-to-string (stream)
        (labels ((evaluate (char)
                   (etypecase char
                     ((or character keyword)
                      (or (mapcar #'evaluate (gethash+ char *rule-table*))
                          (when (and (characterp     char)
                                     (find-character char))
                            (write-char char stream))
                          (error 'unknown-rule :elem char :msg :unknown-rule)))
                     (list
                      (write-char (or (find-character char)
                                      (error 'unknown-rule :elem char
                                                           :msg :unknown-char))
                                  stream)))))
          (values (evaluate char) NIL)))
    (unknown-rule (err)
      (values fallback (list (slot-value err 'msg)
                             (slot-value err 'elem))))))

(defun ikasu (input)
  "Make `input' ikasu.
Return an ikasu output string.
The input white spaces will be ignored
and turned into single white space. "
  (let ((whitespace NIL))
    (with-output-to-string (output)
      (map NIL (lambda (char)
                 (cond ((or (char= char #\Newline)
                            (char= char #\Space))
                        (unless whitespace
                          (setf whitespace T)
                          (write-char #\Space output)))
                       (T
                        (setf whitespace NIL)
                        (write-string (ikasu-char char) output))))
           input))))

(defun define-rule (from to &optional (strict *strictp*))
  "Define rule for the `from' to `to'.
Return values are `from'.

Arguments:
+ `from'   should be {character | keyword}
  `from'   should not be character;
+ `to'     should be ({character | keyword | list})
+ `strict' raise error/warn when:
  + `from' is invalid ---> invalid-from-rule
  + `to'   is invalid ---> invalid-to-rule
"
  (declare (type (or character keyword) from))
  (declare (type list to))
  (loop for elem in to
        do (unless (or (characterp elem)
                       (keywordp   elem)
                       (and (listp elem)
                            (find-character elem)))
             (if strict
                 (error 'invalid-rule :elem elem :msg :invalid-to-elem)
                 (warn  'invalid-rule :elem elem :msg :invalid-to-elem))))
  (if (find-character from)
      (if strict
          (error 'invalid-rule :elem from :msg :locked-from)
          (warn  'invalid-rule :elem from :msg :locked-from))
      (setf (gethash+ from *rule-table*) to))
  from)

(defmacro defrule (from &rest to)
  "Wrap for `define-rule' for easy rule definition.

Syntax:
+ `from'

    {
      character ---> character
    | string    ---> only use first character
    | keyword   ---> keyword
    | symbol    ---> variable
    | list      ---> multiple from
    }
+ `to' elem:

   {
     character ---> character
   | string    ---> list of character
   | list      ---> list of `to' elem
   | keyword   ---> keyword
   | symbol    ---> variable
   }

Example:

    (defrule \"他\" :单人旁 #\也)
"
  (labels ((flatten (tree)
             (let (list)
               (labels ((iter (sub)
                          (when sub
                            (cond ((and (listp sub)
                                        (keywordp (first  sub))
                                        (keywordp (second sub))
                                        (not (third sub))
                                        (find-character sub))
                                   (push (list 'quote sub) list))
                                  ((consp sub)
                                   (iter (car sub))
                                   (iter (cdr sub)))
                                  (T (push sub list))))))
                 (iter tree))
               (nreverse list)))
           (to-elem (elem)
             (etypecase elem
               ((or character keyword) elem)
               (string (map 'list #'identity elem))
               (symbol elem)
               (list   (mapcar #'to-elem elem))))
           (single-rule (from to)
             (let ((from (etypecase from
                           ((or character keyword) from)
                           (string (aref from 0)))))
               `(define-rule ,from ,(cons 'list (flatten to))))))
    (let ((to (mapcar #'to-elem to)))
      (if (atom from)
          (single-rule from to)
          `(progn ,@(loop for fr in from collect (single-rule fr to)))))))

(defmacro defrule* (&body bindings)
  "Define multiple rules.

Syntax:
The `bindings' of each rule definition should
be like:

   (from . to)

Example:

    (defrule*
      (#\力 (:katakana :ka))
      (#\工 (:katakana :e)))

See `defrule' for each `from' and `to' syntax. "
  `(progn
     ,@(loop for (from . to) in bindings
             collect `(defrule ,from ,@to))))

;;; core.lisp ends here
