;;; config.lisp --- Configuration of IIIIka web

;; File:        config.lisp
;; Description: Configuration of IIIIka web
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-02-14 08:42
;; Version: 0.0.0
;; Last-Updated: 2025-03-17 01:11
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

(defparameter *banner*
  '("S3_Banner_1.png"
    "S3_Banner_901.png"
    "S3_Banner_902.png"
    "S3_Banner_911.png"
    "S3_Banner_912.png"
    "S3_Banner_921.png"
    "S3_Banner_922.png"
    "S3_Banner_923.png"
    "S3_Banner_924.png"
    "S3_Banner_936.png"
    "S3_Banner_931.png"
    "S3_Banner_937.png"
    "S3_Banner_1001.png"
    "S3_Banner_1002.png"
    "S3_Banner_1003.png"
    "S3_Banner_11081.png"
    "S3_Banner_11082.png"
    "S3_Banner_12001.png"
    "S3_Banner_12002.png"
    "S3_Banner_13001.png"
    "S3_Banner_13002.png"
    "S3_Banner_14001.png"
    "S3_Banner_14002.png"
    "S3_Banner_15001.png"
    "S3_Banner_15002.png"
    "S3_Banner_16001.png"
    "S3_Banner_16002.png"
    "S3_Banner_17001.png"
    "S3_Banner_17002.png"
    "S3_Banner_18001.png"
    "S3_Banner_18002.png"
    "S3_Banner_800.png"
    "S3_Banner_810.png"
    "S3_Banner_951.png"
    "S3_Banner_952.png"
    "S3_Banner_953.png"
    "S3_Banner_954.png"
    "S3_Banner_961.png"
    "S3_Banner_971.png"
    "S3_Banner_972_revoked.png"
    "S3_Banner_972.png"
    "S3_Banner_981.png"
    "S3_Banner_991.png"
    "S3_Banner_992.png"
    "S3_Banner_993.png"
    "S3_Banner_11001.png"
    "S3_Banner_11002.png"
    "S3_Banner_11003.png"
    "S3_Banner_11004.png"
    "S3_Banner_11005.png"
    "S3_Banner_11006.png"
    "S3_Banner_11007.png"
    "S3_Banner_11008.png"
    "S3_Banner_11009.png"
    "S3_Banner_11010.png"
    "S3_Banner_11011.png"
    "S3_Banner_11012.png"
    "S3_Banner_11013.png"
    "S3_Banner_11014.png"
    "S3_Banner_11015.png"
    "S3_Banner_11016.png"
    "S3_Banner_11017.png"
    "S3_Banner_11018.png"
    "S3_Banner_11019.png"
    "S3_Banner_11020.png"
    "S3_Banner_11021.png"
    "S3_Banner_11022.png"
    "S3_Banner_11023.png"
    "S3_Banner_11024.png"
    "S3_Banner_11025.png"
    "S3_Banner_11026.png"
    "S3_Banner_11027.png"
    "S3_Banner_11028.png"
    "S3_Banner_11029.png"
    "S3_Banner_11030.png"
    "S3_Banner_11031.png"
    "S3_Banner_11032.png"
    "S3_Banner_11033.png"
    "S3_Banner_11034.png"
    "S3_Banner_11035.png"
    "S3_Banner_11036.png"
    "S3_Banner_11037.png"
    "S3_Banner_11038.png"
    "S3_Banner_11039.png"
    "S3_Banner_11040.png"
    "S3_Banner_11041.png"
    "S3_Banner_11042.png"
    "S3_Banner_11043.png"
    "S3_Banner_11044.png"
    "S3_Banner_11045.png"
    "S3_Banner_11046.png"
    "S3_Banner_11047.png"
    "S3_Banner_11048.png"
    "S3_Banner_11049.png"
    "S3_Banner_11050.png"
    "S3_Banner_11051.png"
    "S3_Banner_11052.png"
    "S3_Banner_11053.png"
    "S3_Banner_11054.png"
    "S3_Banner_11055.png"
    "S3_Banner_11056.png"
    "S3_Banner_11057.png"
    "S3_Banner_11058.png"
    "S3_Banner_11059.png"
    "S3_Banner_11060.png"
    "S3_Banner_11061.png"
    "S3_Banner_11062.png"
    "S3_Banner_11063.png"
    "S3_Banner_11064.png"
    "S3_Banner_11065.png"
    "S3_Banner_11066.png"
    "S3_Banner_11067.png"
    "S3_Banner_11068.png"
    "S3_Banner_11069.png"
    "S3_Banner_11070.png"
    "S3_Banner_11071.png"
    "S3_Banner_11072.png"
    "S3_Banner_11073.png"
    "S3_Banner_11074.png"
    "S3_Banner_11075.png"
    "S3_Banner_11076.png"
    "S3_Banner_11077.png"
    "S3_Banner_11078.png"
    "S3_Banner_11079.png"
    "S3_Banner_11080.png"
    "S3_Banner_15003.png"
    "S3_Banner_15004.png"
    "S3_Banner_15005.png"
    "S3_Banner_15006.png"
    "S3_Banner_15007.png"
    "S3_Banner_15008.png"
    "S3_Banner_15009.png"
    "S3_Banner_15010.png"
    "S3_Banner_15011.png"
    "S3_Banner_15012.png"
    "S3_Banner_15013.png"
    "S3_Banner_15014.png"
    "S3_Banner_15015.png"
    "S3_Banner_15016.png"
    "S3_Banner_15017.png"
    "S3_Banner_15018.png"
    "S3_Banner_15019.png"
    "S3_Banner_15020.png"
    "S3_Banner_15021.png"
    "S3_Banner_15022.png"
    "S3_Banner_15023.png"
    "S3_Banner_15024.png"
    "S3_Banner_15025.png"
    "S3_Banner_15026.png"
    "S3_Banner_15027.png"
    "S3_Banner_15028.png"
    "S3_Banner_15029.png"
    "S3_Banner_15030.png"
    "S3_Banner_15031.png"
    "S3_Banner_15032.png"
    "S3_Banner_15033.png"
    "S3_Banner_15034.png"
    "S3_Banner_15035.png"
    "S3_Banner_15036.png"
    "S3_Banner_15037.png"
    "S3_Banner_15038.png"
    "S3_Banner_15039.png"
    "S3_Banner_15040.png"
    "S3_Banner_15041.png"
    "S3_Banner_15042.png"
    "S3_Banner_15043.png"
    "S3_Banner_15044.png"
    "S3_Banner_15045.png"
    "S3_Banner_15046.png"
    "S3_Banner_15047.png"
    "S3_Banner_15048.png"
    "S3_Banner_15049.png"
    "S3_Banner_15050.png"
    "S3_Banner_15051.png"
    "S3_Banner_15052.png"
    "S3_Banner_15053.png"
    "S3_Banner_15054.png"
    "S3_Banner_15055.png"
    "S3_Banner_15056.png"
    "S3_Banner_15057.png"
    "S3_Banner_15058.png"
    "S3_Banner_15059.png"
    "S3_Banner_15060.png"
    "S3_Banner_15061.png"
    "S3_Banner_15062.png"
    "S3_Banner_15063.png"
    "S3_Banner_15064.png"
    "S3_Banner_15065.png"
    "S3_Banner_15066.png"
    "S3_Banner_15067.png"
    "S3_Banner_15068.png"
    "S3_Banner_15069.png"
    "S3_Banner_15070.png"
    "S3_Banner_15071.png"
    "S3_Banner_15072.png"
    "S3_Banner_15073.png"
    "S3_Banner_15074.png"
    "S3_Banner_15075.png"
    "S3_Banner_15076.png"
    "S3_Banner_15077.png"
    "S3_Banner_15078.png"
    "S3_Banner_15079.png"
    "S3_Banner_15080.png"
    "S3_Banner_15081.png"
    "S3_Banner_15082.png"
    "S3_Banner_10001.png"
    "S3_Banner_2001.png"
    "S3_Banner_2101.png"
    "S3_Banner_2002.png"
    "S3_Banner_2301.png"
    "S3_Banner_2402.png"
    "S3_Banner_2003.png"
    "S3_Banner_2104.png"
    "S3_Banner_2201.png"
    "S3_Banner_2004.png"
    "S3_Banner_2005.png"
    "S3_Banner_2204.png"
    "S3_Banner_2006.png"
    "S3_Banner_2302.png"
    "S3_Banner_2401.png"
    "S3_Banner_2102.png"
    "S3_Banner_2007.png"
    "S3_Banner_2008.png"
    "S3_Banner_2203.png"
    "S3_Banner_2304.png"
    "S3_Banner_2403.png"
    "S3_Banner_2010.png"
    "S3_Banner_2009.png"
    "S3_Banner_2202.png"
    "S3_Banner_2103.png"
    "S3_Banner_2303.png"
    "S3_Banner_2404.png"
    "S3_Banner_851.png"
    "S3_Banner_852.png"
    "S3_Banner_853.png"
    "S3_Banner_861.png"
    "S3_Banner_862.png"
    "S3_Banner_863.png"
    "S3_Banner_864.png")
  "All the banner image name. ")

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
