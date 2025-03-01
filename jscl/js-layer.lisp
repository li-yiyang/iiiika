;;; js-layer.lisp --- JavaScript-Lisp layer

;; File:        js-layer.lisp
;; Description: JavaScript-Lisp layer
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-02-15 16:40
;; Version: 0.0.0
;; Last-Updated: 2025-02-16 11:59
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

#-jscl (error "This file only work under JSCL")

;; Note: found this is not so useful...
(defvar *self* NIL
  "Used for self reference. ")

;;; JS utils wraps

(defmacro attr (elem &rest attr-chain)
  "Make JS chain accessing lispy.

Syntax:
`attr-chain' should be like:

    {string | keyword}

If given attr is keyword, trun it into string by
`js-like-case' first.

Example

    ;; elem.attrList.attr2.attrUPPER...
    (attr elem :attr-list :attr2 \"attrUPPER\")
"
  (if (endp attr-chain)
      elem
      (let* ((attr (first attr-chain))
             (attr (if (keywordp attr)
                       (js-like-case (symbol-name attr))
                       attr)))
        `(attr (jscl::oget ,elem ,attr) ,@(rest attr-chain)))))

(defmacro call (elem &body fn-params)
  "Make JS chain calling lispy.

Syntax:
`fn-params' can be:

    string | keyword -> *.fnParams
    list : ({string | keyword} . param) -> *.fn(param*)

Example:

    ;; elem.fn1().fn2.fn3(x, y, z)
    (call elem (:fn1) :fn2 (:fn3 x y z))
"
  (if (endp fn-params)
      elem
      (let ((fn-param (first fn-params)))
        (if (listp fn-param)
            (let* ((fn (first fn-param))
                   (fn (if (keywordp fn)
                           (js-like-case (symbol-name fn))
                           fn)))
              `(call ((jscl::oget ,elem ,fn) ,@(rest fn-param)) ,@(rest fn-params)))
            `(call (attr ,elem ,fn-param) ,@(rest fn-params))))))

(defun set-time-out (delay fn)
  "setTimeout(fn, delay)

Argument:
`delay' seconds;
`fn'    function;"
  (declare (function fn))
  (declare (number   delay))
  (#j:setTimeout fn delay))

(defmacro wait (sec &body body)
  "Wait `sec' and execute `body'. "
  `(set-time-out ,sec (lambda () ,body)))

(defun add-event-listener (elem type fn)
  "elem.addEventListener(type, fn)

Argument:
`type' could be
    {string | keyword}
if is `keyword', turn it into js-like string first.
`fn' should be function"
  (declare (type (or string keyword) type))
  (declare (function fn))
  (call elem (:add-event-listener
                 (if (keywordp type)
                     (js-like-case (symbol-name type))
                     type)
               fn)))

(defun get-elem-by-id (id)
  "Get element by `id'.
Return HTML element or `NIL' if could not get. "
  (let ((elem (#j:document:getElementById id)))
    (unless elem
      (error (format NIL "Cannot found elem with id `~A'. " id)))
    elem))

(defun text (elem)
  "Get/Set `elem' text by setting innerText. "
  (attr elem :inner-text))

(defun (setf text) (text elem)
  (setf (attr elem :inner-text) text))

(defun inner-html (elem)
  "Get/Set `elem' inner HTML by setting innerHTML. "
  (attr elem "innerHTML"))

(defun (setf inner-html) (html elem)
  (setf (attr elem "innerHTML") html))

(defmacro add-event ((elem type &optional (event (gensym "EVENT")))
                              &body body)
  "Add event listener to `elem'.

Syntax:
`elem' is the HTML element
`*self*' could be used to refer `elem'
`event' is the callback `event' var
"
  (declare (symbol event))
  (let ((el (gensym "ELEM")))
    `(let* ((,el    ,elem)
            (*self* ,el))
       (add-event-listener
        ,el ,type
        (lambda (,event) (declare (ignorable ,event)) ,@body)))))

(defun create-elem (tag inner-html)
  "Create <tag>inner-html</tag> like HTML object. "
  (let ((elem (#j:document:createElement tag)))
    (setf (inner-html elem) inner-html)
    elem))

(defun append-children (parent children)
  (call parent (:append-child children)))

(defun add-css-class (elem class)
  (call elem :class-list (:add class)))

(defun remove-css-class (elem class)
  (call elem :class-list (:remove class)))

(defun has-css-class-p (elem class)
  (call elem :class-list (:contains class)))

(defun attach-tooltip (elem tooltip)
  (let ((tooltip (create-elem "span" tooltip)))
    (call tooltip :class-list (:add "tooltiptext"))
    (call elem    :class-list (:add "tooltip"))
    (append-children elem tooltip)))

;; Widgets

(defun hide-elem (elem)
  (call elem :class-list (:remove "fade-in"))
  (call elem :class-list (:add    "fade-out")))

(defun show-elem (elem)
  (call elem :class-list (:remove "fade-out"))
  (call elem :class-list (:add    "fade-in")))

;;; js-layer.lisp ends here
