;;; gen-banner.lisp --- Generate/Download banner images from Inkipedia

;; File:        gen-banner.lisp
;; Description: Generate/Download banner images from Inkipedia
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-03-17 00:12
;; Version: 0.0.0
;; Last-Updated: 2025-03-17 00:12
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

(ql:quickload '(:dexador :clss :str))

(defparameter *inkpedia-banner-html*
  (plump:parse (dex:get "https://splatoonwiki.org/wiki/Banner"
                        :proxy "http://127.0.0.1:7890"))
  "Inkpedia Banner database. ")

(defparameter *banner-list*
  (map 'list (lambda (img) (plump:attribute img "src"))
       (clss:select "table > tbody > tr > td > figure > a > img" *inkpedia-banner-html*))
  "Banner definition. ")

;; https://cdn.wikimg.net/en/splatoonwiki/images/0/0d/S3_Banner_1.png
(defparameter *banner-url-list*
  (mapcar (lambda (thumb)
            (str:join "/"
                      (cons "http:/"
                            (delete "thumb"
                                    (butlast (str:split "/" thumb :omit-nulls t))
                                    :test #'equal))))
          *banner-list*))

(defun download (list &optional (dir (merge-pathnames "img/banner/" *iiiika-web-path*)))
  (uiop:with-current-directory (dir)
    (loop for url in list
          for file = (first (last (str:split "/" url)))
          do (with-open-file (img file :direction :output
                                       :if-exists :supersede
                                       :if-does-not-exist :create
                                       :element-type '(unsigned-byte 8))
               (write-sequence (dex:get url :force-binary t)
                               img))
          collect file)))

;; (download *banner-url-list*)

(defparameter *inkpedia-badge-html*
  (plump:parse (dex:get "https://splatoonwiki.org/wiki/Badge"
                        :proxy "http://127.0.0.1:7890"))
  "Inkpedia Badge database. ")

(defparameter *badge-list*
  (map 'list (lambda (img) (plump:attribute img "src"))
       (clss:select "table > tbody > tr > td > span > a > img" *inkpedia-badge-html*))
  "Badge definition. ")

(defparameter *badge-url-list*
  (mapcar (lambda->
            (str:join "/")
            (cons "http:/")
            (delete "thumb" :test #'equal)
            butlast
            (str:split "/" :omit-nulls t))
          *badge-list*))

(download *badge-url-list* (merge-pathnames "img/badge/" *iiiika-web-path*))

(defun split-list (list &key (test (constantly t)) (includes t))
  "Split a list if element is keyword. "
  (loop for (first . rest) on list by #'cdr
        if (funcall test first)
          return (values left (if includes (cons first rest) rest))
        collect first into left
        finally (return (values left nil))))

(defmacro -> (expr &rest chain)
  (if (endp chain) expr
      (if (listp expr)
          (multiple-value-bind (expr keys) (split-list expr :test #'keywordp)
            `(,@expr (-> ,@chain) ,@keys))
          `(,expr (-> ,@chain)))))

(defmacro lambda-> (&rest chain)
  `(lambda (x) (-> ,@chain x)))

(mapcar (lambda-> print first last (str:split "/"))
         *banner-url-list*)

;;; gen-banner.lisp ends here
