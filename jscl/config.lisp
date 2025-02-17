;;; config.lisp --- Configuration of IIIIka web

;; File:        config.lisp
;; Description: Configuration of IIIIka web
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-02-14 08:42
;; Version: 0.0.0
;; Last-Updated: 2025-02-14 08:42
;;           By: 凉凉
;; URL:
;; Keywords:
;; Compatibility: JSCL
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

(defparameter *default-language* :cn-zh
  "Default UI language. ")

(defparameter *language* :cn-zh
  "The UI language.

By default, the language is `*default-language*'.
Possible options:
+ `:en'
+ `:cn-zh'
+ ... (translation contribute is wanted)

To contribute translations, use `deftranslation'
macro for defining the translations. ")

(defparameter *common-message*
  (make-hash-table)
  "The common message goes here.

Use `deftranslation'. ")

(defparameter *byname*
  (make-hash-table)
  "The general CommonMsg/Byname Table.

The hash table is like:

    language -> [adj, noun]

where `adj' and `noun' is an array.

Use `define-byname-adj' and `define-byname-noun' to
sets the byname tags.

Note: please refer to `scripts/splat3-gen.lisp' and
`scripts/splat3_CNzh_unicode.json'.

Credit: Jeanny's repo*.
*: https://github.com/Leanny/splat3")

;;; Config Utils

;; translation

(defmacro deftranslation (language &body translations)
  "Define the translation of IIIIka.

Syntax:
`translations' should be like:

    (:ui \"Translation\")

Example:

    (deftranslation :cn-ika
      (:help \"鱿点不会用\")
      (:like \"鱿型\"))

See `jscl/translation-<language>.lisp' for details.
See `scripts/jscl-compile.lisp' for how translation parts
are compiled seperately as modules to load. "
  (declare (keyword language))
  (let ((message (gensym "TRANS")))
    `(let ((,message (make-hash-table)))
       ,@(loop for (ui translation) in translations
               do (assert (keywordp ui))
               do (assert (stringp  translation))
               collect `(setf (gethash ',ui ,message) ,translation))
       (setf (gethash ',language *common-message*) ,message))))

(defun getui (ui &optional (language *language*))
  "Get UI message for `language'.

If `ui' is not known to `language',
will fallback to `*default-language*'.
If `*default-language*' fails to render `ui',
will render `ui' as `ロロロ'. (Katakana RO, RO, RO)

Note: why `ロロロ'?
Normally if computer fails to render the character,
it will render white square `□'. So in chinese,
we are calling it `口' (kǒu, mouse, 嘴). To render it
using Splatoon fonts, using Katakana RO character. "
  (flet ((single (ui)
           (cond ((stringp    ui) ui)
                 ((characterp ui) (format NIL "~C" ui))
                 (T
                  (or (gethash* *common-message* language           ui)
                      (gethash* *common-message* *default-language* ui)
                      "ロロロ")))))
    (if (listp ui)
        (with-output-to-string (stream)
          (loop for single-ui in ui
                do (write-string (single single-ui) stream)
                do (write-char   #\Space stream)))
        (single ui))))

;; Byname

(defun ensure-byname-slot (language)
  "Ensure the existance of byname [adj, noun] structure. "
  (unless (gethash language *byname*)
    (let ((byname (make-array 2)))
      (setf (aref byname 0) (make-array 0 :adjustable T :fill-pointer 0))
      (setf (aref byname 1) (make-array 0 :adjustable T :fill-pointer 0))
      (setf (gethash language *byname*) byname))))

(defmacro define-byname--aref (language aref &body tags)
  "Define the `*byname*' of nth `aref'. "
  (let ((expand-p (and (listp language)
                       (eq :expand (second language))))
        (language (if (listp language)
                      (first language)
                      language)))
    `(progn
       (ensure-byname-slot ',language)

       ;; Note:
       ;; this is ugly because JSCL does not support
       ;; `:initial-contents' keyword when `make-array'
       ;; issue: https://github.com/jscl-project/jscl/issues/482
       ,(if expand-p
            `(setf (aref (gethash ',language *byname*) ,aref)
                   (list->array (list ,@tags)))
            `(setf (aref (gethash ',language *byname*) ,aref)
                   (list->array
                    (nconc (array->list (aref (gethash ',language *byname*) ,aref))
                           (list ,@tags))))))))

(defmacro define-byname-adj (language &body adj-tags)
  "Define the Byname adjactive tags.

Syntax:
`language' could be:

    :lang           ;; like `:cn-zh' for language

or

    (:lang :expand) ;; to expanding the exisiting adj list

if not setting `:expand', will overwrite the original adj list.

Note: please refer to `scripts/splat3-gen.lisp' for
generating the adj from `scripts/splat3_CNzh_unicode.json'.

Edit the `define-byname-adj' manually is only recommanded
when you what to add your own adj for the byname. "
  `(define-byname--aref ,language 0 ,@adj-tags))

(defmacro define-byname-noun (language &body noun-tags)
  "Define the Byname noun tags.

Syntax:
`language' could be:

    :lang           ;; like `:cn-zh' for language

or

    (:lang :expand) ;; to expanding the exisiting adj list

if not setting `:expand', will overwrite the original adj list.

Note: please refer to `scripts/splat3-gen.lisp' for
generating the noun from `scripts/splat3_CNzh_unicode.json'.

Edit the `define-byname-noun' manually is only recommanded
when you what to add your own adj for the byname. "
  `(define-byname--aref ,language 1 ,@noun-tags))

(defun get-byname--aref (aref &optional id (language *language*))
  "Get tag of `id' for byname with `aref'.
Return values are tag, id of tag.

If `id' is `NIL', will return random `id'. "
  (declare (type (or null integer) id))
  (declare (keyword language))
  (let* ((tags (aref (or (gethash language           *byname*)
                         (gethash *default-language* *byname*))
                     aref))
         (id   (if id
                   (mod id (length tags))
                   (random (length tags)))))
    (values (aref tags id) id)))

(defmacro get-byname-adj (&optional adj (language *language*))
  `(get-byname--aref 0 ,adj ,language))

(defmacro get-byname-noun (&optional noun (language *language*))
  `(get-byname--aref 1 ,noun ,language))

(defun get-byname (&optional adj noun (language *language*))
  "Get Byname as cons.
Return values are (adj . noun), (adj-id . noun-id).

If `adj' or `noun' is `NIL', return a random `adj' or `noun';
or `adj' or `noun' should be the index. "
  (declare (type (or null integer) adj noun))
  (declare (keyword language))
  (values-list
   (mapcar #'cons
           (multiple-value-list (get-byname--aref 0 adj  language))
           (multiple-value-list (get-byname--aref 1 noun language)))))

;;; config.lisp ends here
