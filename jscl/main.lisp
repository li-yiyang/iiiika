;;; main.lisp --- Main logic of IIIIka web

;; File:        main.lisp
;; Description: Main logic of IIIIka web
;; Author:      凉凉
;; Maintainer:  凉凉
;; Copyright (c) 2025, 凉凉, all rights reserved
;; Created: 2025-02-13 23:44
;; Version: 0.0.0
;; Last-Updated: 2025-02-16 11:59
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

;;; Note: this file only works under JSCL.
;;; loading it into developing Lisp (like SBCL) will raise error.

#-jscl (error "This file only work under JSCL")

;; Widgets

(defun byname-select (type)
  "Popup byname-select. "
  (setf (text (get-elem-by-id "byname-select-title"))
        (getui (list :byname type)))
  (setf (text (get-elem-by-id "byname-select-message"))
        (getui (list :click :to :choose :byname type)))

  ;; Fill the Byname List
  (let ((list (get-elem-by-id "byname-select-list")))
    (setf (inner-html list) "")
    (map NIL (lambda (byname)
               (let ((tag (create-elem "li" byname)))
                 (add-event (tag "click")
                   (setf (text (get-elem-by-id (if (eq type :adj)
                                                   "byname-adj"
                                                   "byname-noun")))
                         byname)
                   (hide-elem (get-elem-by-id "mask"))
                   (hide-elem (get-elem-by-id "byname-select")))
                 (call list (:append-child tag))))
         (aref (gethash *language* *byname*)
               (if (eq type :adj) 0 1))))
  (show-elem (get-elem-by-id "mask"))
  (show-elem (get-elem-by-id "byname-select")))

(defun query-name ()
  "Like `query' but popup `query-name' widget.

The input name will be checked and goes to `query-name-message'
while input, if fails, will goes like color red. "
  (setf (text (get-elem-by-id "query-name-title")) (getui :usage))
  (let ((input   (get-elem-by-id "query-name-input"))
        (message (get-elem-by-id "query-name-message"))
        (confirm (get-elem-by-id "query-name-confirm"))
        (cancel  (get-elem-by-id "query-name-cancel")))
    (setf (inner-html message)      "")
    (setf (attr input :value)       "")
    (setf (attr input :placeholder) (getui :name))
    (setf (text confirm) (getui :confirm))
    (setf (text cancel)  (getui :cancel))
    (add-event (cancel "click")
      (hide-elem (get-elem-by-id "mask"))
      (hide-elem (get-elem-by-id "query-name")))
    (add-event (confirm "click")
      (setf (text (get-elem-by-id "name"))
            (iiiika:ikasu (attr input :value)))
      (hide-elem (get-elem-by-id  "mask"))
      (hide-elem (get-elem-by-id "query-name")))
    (add-event (input "input")
      (setf (inner-html message) "")
      (let ((whitespace NIL))
        (map NIL (lambda (char)
                   (cond ((or (char= char #\Newline)
                              (char= char #\Space))
                          (unless whitespace
                            (setf whitespace T)
                            (append-children message (create-elem "span" " "))))
                         (T
                          (setf whitespace NIL)
                          (multiple-value-bind (res reason)
                              (iiiika:ikasu-char char)
                            (let* ((char (if reason (format NIL "~C" char) res))
                                   (elem (create-elem "span" char)))
                              (when reason
                                (add-css-class  elem "unknown")
                                (attach-tooltip elem (getui reason)))
                              (append-children message elem))))))
             (attr input :value)))))
  (show-elem (get-elem-by-id "mask"))
  (show-elem (get-elem-by-id "query-name")))

;; Main

(defun main ()
  "Binds all the events to front-end UI. "

  ;;; Name
  (flet ((ask-input (event) (query-name)))
    (add-event-listener (get-elem-by-id "name") "click" #'ask-input))

  ;;; Byname
  (flet ((update-adj  (&optional event)
           (if (and event (= (attr event :detail) 2))
               (byname-select :adj)
               (setf (text (get-elem-by-id "byname-adj"))  (get-byname-adj))))
         (update-noun (&optional event)
           (if (and event (= (attr event :detail) 2))
               (byname-select :noun)
               (setf (text (get-elem-by-id "byname-noun")) (get-byname-noun)))))
    (add-event-listener (get-elem-by-id "byname-adj")  "click" #'update-adj)
    (add-event-listener (get-elem-by-id "byname-noun") "click" #'update-noun)
    (update-adj)
    (update-noun))

  ;;; Badge
  (flet ((sorry (event)
           (alert (getui '(:sorry :badge :*-is-working)))))
    (add-event-listener (get-elem-by-id "badge-1") "click" #'sorry)
    (add-event-listener (get-elem-by-id "badge-2") "click" #'sorry)
    (add-event-listener (get-elem-by-id "badge-3") "click" #'sorry))

  ;;; Alert Popup
  (add-event ((get-elem-by-id "alert-button") "click")
    (hide-elem (get-elem-by-id "alert"))
    (hide-elem (get-elem-by-id "mask")))

  ;;; Byname Select Cancel
  (add-event ((get-elem-by-id "byname-select-cancel") "click")
    (hide-elem (get-elem-by-id "byname-select"))
    (hide-elem (get-elem-by-id "mask")))

  ;;; IIIIka (now only for dbg new feature usage)
  (add-event ((get-elem-by-id "iiiika") "click")
    )
  )

(main)

;;; main.lisp ends here
