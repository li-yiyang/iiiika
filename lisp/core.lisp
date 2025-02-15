;;; core.lisp --- Core replacement rules for IIIIka

;; File:        core.lisp
;; Description: Core replacement rules for IIIIka
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-02-13 14:36
;; Version: 0.0.0
;; Last-Updated: 2025-02-13 14:36
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

(defparameter *word-split-rule*
  (make-hash-table)
  "Chinese word split rule.

The word split rule should be like:

    #\夕 -> (#\夕)
    #\阳 -> (#\阝 #\日)
    #\红 -> (#\纟 #\工)

Use `defword' to define the split rule.
Note: since JSCL does not support using character
as the hash-key, so the key will be `char-code'
instead. ")

(defparameter *part-nicknames*
  (make-hash-table)
  "Nicknames (keyword) for part names.

This the nicknames map should be like:

    :绞丝旁 -> #\纟
    :双耳旁 -> #\阝

This should be only used when defining the
word split rule and part mapping rule.

Use `defpart' to define part with nickname. ")

(defparameter *nicknames-part*
  (make-hash-table)
  "Map `nicknames' from `part'.

This the nicknames map should be like:

    #\纟-> :绞丝旁
    #\阝-> :双耳旁

This should be only used when defining the
word split rule and part mapping rule.

Use `defpart' to define part with nickname.

Still, due to the limitation of JSCL, the key
is `char-code' rather than char directly. ")

(defparameter *part-map-rule*
  (make-hash-table)
  "Chinese word part mapping rule.

The part map rule should be like:

    part-char -> character-name
    #\夕 -> (:katakana    :ta)      ;; => #\タ
    #\阝 -> (:symbol-3    :beta)    ;; => #\β
    #\日 -> (:symbol-3    :theta)   ;; => #\θ
    #\纟 -> (:symbol-3    :xi)      ;; => #\ξ
    #\工 -> (:katakana    :e)       ;; => #\エ

The `character-name' should be the full form (explicit
indexing defintion).

It could use short form or search form when defining the
mapping rule.

Use `defpart' to define the map rule.

Still, due to the limitation of JSCL, the key
is `char-code' rather than char directly. ")

(define-condition iiiika-error (error) ())

(define-condition unknown-error (iiiika-error)
  ((type :initarg :type :reader which-unknown)
   (what :initarg :what :reader what-unknown))
  (:report (lambda (condition stream)
             (format stream "Unknown ~A for given `~A'. "
                     (which-unknown condition)
                     (what-unknown  condition)))))

(define-condition unknown-part (unknown-error)
  ((type :initform :part)))

(define-condition unknown-part-nickname (unknown-error)
  ((type :initform :part-nickname)))

(define-condition unknown-word (unknown-error)
  ((type :initform :word)))

(define-condition unknown-character (unknown-error)
  ((type :initform :character)))

(defun (setf map-part) (character part-name)
  "Set part map rule by given `part-name' and `character'.

Arguments:
`character': should be able to be found by `find-character'.
If `character' could not be found, raise `unknown-character' error. "
  (let ((part-name (etypecase part-name
                     (character part-name)
                     (keyword   (nickname->part-name part-name)))))
    (multiple-value-bind (res char) (find-character character)
      (declare (ignore res))
      (if char
          (setf (gethash+ part-name *part-map-rule*) char)
          (error 'unknown-character :what character)))))

(defun map-part (part)
  "Map the `part' to character definition.

Arguments:
`part'
+ char -> search the `*part-map-rule*' dirctly;
+ keyword -> search by `part-nickname' first;

If `part' not found, raise `unknown-part' error. "
  (let* ((part-name (etypecase part
                      (character part)
                      (keyword   (nickname->part-name part))))
         (map (gethash+ part-name *part-map-rule*)))
    (restart-case
        (or map (error 'unknown-part :what part))
      (define-new (char)
        :report "Define new map rule"
        :interactive (lambda ()
                       (prompt-query-for "Character: " '(or keyword list character)))
        (setf (map-part part-name)
              (or (find-character char)
                  (error 'unknown-character :what char)))
        (map-part part)))))

(defun (setf nickname->part-name) (part-name nickname)
  "Set `nickname' bound to `part-name'.

Arguments:
`part-name'
+ keyword -> apply expand by `nickname->part-name'
+ character -> assume that part-name rule exists "
  (declare (keyword nickname))
  (declare (type (or keyword character) part-name))
  (let ((part-name (etypecase part-name
                     (character part-name)
                     (keyword   (nickname->part-name part-name)))))
    ;; assert `part-name' is non-nil
    (assert (map-part part-name))
    (setf (gethash+ nickname *part-nicknames*) part-name)))

(defun nickname->part-name (nickname)
  "Get part character (part-name) by `nickname'.
Return part character of nickname.

If could not found, raise `unknown-part-nickname' error. "
  (declare (keyword nickname))
  (restart-case
      (let ((part-name (gethash+ nickname *part-nicknames*)))
        (or part-name (error 'unknown-part-nickname :what nickname)))
    (define-new (part-name)
      :report "Define a new nickname"
      :interactive (lambda () (prompt-query-for "Part Name: " 'character))
      (setf (nickname->part-name nickname) part-name)
      (nickname->part-name nickname))))

(defun (setf get-word-split) (split-rule word)
  "Set the word split rule.
Check the `split-rule' before appling the settings. "
  (declare (list split-rule))
  (setf (gethash+ word *word-split-rule*)
        (mapcar (lambda (rule)
                  (let ((part (etypecase rule
                                (character rule)
                                (keyword   (nickname->part-name rule)))))
                    (assert (map-part part)) ;; assume part mapping rule exists
                    part))
                split-rule)))

(defun get-word-split (word)
  "Get word splited.
Return splited word if possible.

Arguments:
If `word' is either a known word, a known part, nor a valid character,
will raise error of `unknown-word'. "
  (restart-case
      (or (gethash+ word *word-split-rule*)
          (when (gethash+ word *part-map-rule*)
            (list word))
          (multiple-value-bind (res char) (find-character word)
            (declare (ignore res))
            (or char (error 'unknown-word :what word))))
    (define-new (split-rule)
      :report "Define a new word split rule. "
      :interactive (lambda () (prompt-query-for "Split Rule: " 'list))
      (setf (get-word-split word) split-rule)
      (get-word-split word))))

(defun ikasu (input)
  "Make `input' string ikasu.
Return the ikasu escaped string. "
  (declare (string input))
  (let ((res ()))
    (loop for parts in (map 'list #'get-word-split input) do
      (loop for part in parts do
        (push (map-part part) res)))
    (map 'string #'find-character (nreverse res))))

;; Helpful macros used to define the rules

(defmacro defpart (part &body map)
  "Define a part mapping rule.

Syntax:
`part' could be a
+ string -> each char would mapped with `map' (multiple rule);
+ char   -> single rule definition;
+ list like -> (:nickname char) (:nickname string) (:nickname :nickname)
  only use the first char in string or the char for part char

`map' could be like
+ string (only use the first char) or char
+ list -> explicitly define the char

Example:

    (defpart #\夕 (:katakana :ta))
    (defpart ((:双耳旁 #\阝)) #\β)
    (defpart \"日工\" \"θ\" (:katakana :e))
"
  (flet ((single-part (part map)
           (let* ((nickname  NIL)
                  (part-name (etypecase part
                               ;; char for part name
                               (character part)
                               ;; "char" -> use only first
                               (string    (aref part 0))
                               ;; (:nickname char)
                               (list
                                (destructuring-bind (nick char) part
                                  (declare (keyword nick))
                                  (setf nickname nick)
                                  (etypecase char
                                    ;; char
                                    (character char)
                                    ;; string: only first
                                    (string    (aref char 0))
                                    ;; nickname
                                    (keyword   (nickname->part-name char)))))))
                  (map  (etypecase map
                          (character map)
                          (string    (aref map 0))
                          (keyword   (nickname->part-name map))
                          (list      (or (find-character map)
                                         (error 'unknown-character :what map)))))
                  (code `(setf (map-part ,part-name) ',map)))
             (when nickname
               (setf code `(progn
                             ,code
                             (setf (nickname->part-name ,nickname) ,part-name))))
             code)))
    (etypecase part
      ((or list string) `(progn ,@(map 'list #'single-part part map)))
      (character         (single-part part (first map))))))

(defmacro defword (word &body split)
  "Define a word split rule.

Syntax:
`word' could be a
+ string -> then the `split' should be each mapped to the char;
+ char   -> `split' would be all added to single char expand;

`split' could be a
+ top-level list -> used for grouping elements;
  list in list   -> as expression of single character;
+ char -> single expanded rule;
+ string -> equal to a list of characters;

Example:

    (defword \"夕阳红\"
      #\夕
      \"阝日\"
      (:绞丝旁 #\工))
"
  (labels ((single-word (word split)
             (etypecase split
               (character
                (single-word word (list split)))
               ((or list string)
                `(setf (get-word-split ,word)
                       ',(map 'list
                              (lambda (part-name)
                                (let ((part (etypecase part-name
                                              (character part-name)
                                              (string    (aref part-name 0))
                                              (keyword   (nickname->part-name part-name)))))
                                  ;; ensure part exists
                                  (assert (map-part part))
                                  part))
                              split))))))
    (etypecase word
      ((or list string) `(progn ,@(map 'list #'single-word word split)))
      (character        (single-word word (first split))))))

(defmacro defpart* (&body bindings)
  "Define multiple parts.

Syntax:
The `bindings' of each part definition should
be like:

   (part . map)

Example:

    (defparts*
      (#\力 (:katakana :ka))
      (#\工 (:katakana :e)))

See `defpart' for each `part' and `map' syntax. "
  `(progn
     ,@(loop for (part . map) in bindings
             collect `(defpart ,part ,@map))))

(defmacro defword* (&body bindings)
  "Define multiple words.

Syntax:
The `bindings' of each word definition should
be like:

   (word . split)

Example:

    (defword*
      (#\他 #\亻 #\也)
      (#\打 :提手旁 #\丁))

See `defpart' for each `part' and `map' syntax. "
  `(progn
     ,@(loop for (word . split) in bindings
             collect `(defword ,word ,@split))))

;;; core.lisp ends here
