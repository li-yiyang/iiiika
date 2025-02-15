;;; characters.lisp --- Utils for storing the Nintendo Switch input method characters

;; File:        characters.lisp
;; Description: Utils for storing the Nintendo Switch input method characters
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-02-12 18:04
;; Version: 0.0.0
;; Last-Updated: 2025-02-12 19:23
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

(defparameter *character-sets*
  (make-hash-table)
  "An hashtable for all characters sets. ")

(defun make-character-set (character-alist &optional char-set)
  "Character set with name.

The `character-alist' should be like

    (:name . char)

Example:

    (:question-mark . #\?)
"
  (loop with fwd-set  = (or (getf char-set :fwd) (make-hash-table))
        with bwd-set  = (or (getf char-set :bwd) (make-hash-table))
        for (name . char) in character-alist
        do (setf (gethash+ name fwd-set) char)
        do (setf (gethash+ char bwd-set) name)
        finally (return (list :fwd fwd-set :bwd bwd-set))))

(defmacro defcharacters (name &body characters)
  "Defines a character set with `name' and `characters'.

The `characters' can be like:

    single-char (or \"a-string-of-character\" note: space will be ignored)

    or

    (:name . single-char) ;; cons

    or

    (:prefix start end)    ;; list

The defined character should be refered by `find-character'
explicitly like:

    (:name :character-name)

For example:

    \"?!@\"             ;; => #\? #\! #\@
    (:english :lower-x) ;; => #\x
    (:english :upper-y) ;; => #\Y
"
  (flet ((char->cons (char &optional prefix)
           #-jscl (declare (character char))
           (cons (make-keyword
                  (string-upcase
                   (if prefix
                       ;; JSCL has limited `format' support
                       #-jscl (format NIL "~A-~C" prefix char)
                       #+jscl (with-output-to-string (stream)
                                (write-string (symbol-name prefix) stream)
                                (write-char   #\-  stream)
                                (write-char   char stream))
                       (param-case (char-name char)))))
                 char)))
    (let ((alist ()))
      ;; expand characters to character-alist
      (loop for def in characters
            do (cond ((characterp def)        ;; single-char
                      (push (char->cons def) alist))
                     ((stringp def)
                      (map NIL (lambda (char)
                                 (unless (char= char #\Space)
                                   (push (char->cons char) alist)))
                           def))
                     ((consp (cdr def)) ;; list
                      (destructuring-bind (prefix start end) def
                        (loop for code from (char-code start) upto (char-code end)
                              do (push (char->cons (code-char code) prefix) alist))))
                     ((consp def)       ;; cons
                      (push def alist))
                     (T
                      (error (format NIL "Unsupported character definition of `~A'" def)))))
      `(progn
         (setf (gethash+ ',name *character-sets*)
               (make-character-set ',alist (gethash+ ',name *character-sets* NIL)))
         ',name))))

;; TODO: fuzzy search
(defun find-character (search)
  "Find characters in `*character-sets*'.
Return values are search-result, (character-setname character-name);
or `NIL' if could not found.

Arguments:
`search':
+ explicitly: (:character-set-name :character-name)
+ explicitly but no character-name: (:character-set-name char)
+ ambigiously: char or character-name

Note this will only find the EXACTLY the character.
"
  (cond ((null search)
         NIL)
        ((listp search)
         (destructuring-bind (set-name char) search
           (let ((set (gethash+ set-name *character-sets*)))
             (when set
               (if (characterp char)
                   (let ((name (gethash+ char (getf set :bwd))))
                     (when name (values name (list set-name name))))
                   (let ((chr  (gethash+ char (getf set :fwd))))
                     (when chr  (values chr  (list set-name char)))))))))
        ((characterp search)
         (block search
           (maphash (lambda (name sets)
                      (let ((got (gethash+ search (getf sets :bwd))))
                        (when got (return-from search (values got (list name got))))))
                    *character-sets*)))
        (T
         (block search
           (maphash (lambda (name sets)
                      (let ((got (gethash+ search (getf sets :fwd))))
                        (when got (return-from search (values got (list name search))))))
                    *character-sets*)))))

;;; characters.lisp ends here
