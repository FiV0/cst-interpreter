#|
  This file is a part of cst-interpreter.
  (c) 2019 Finn Völkel 
  Author: Finn Völkel  (first.lastname@gmail.com)
|#

(defpackage cst-interpreter
  (:use :cl
        :eclector.concrete-syntax-tree)
  (:export :repl
           :evaluate))
(in-package :cst-interpreter)

(defun repl (&optional (stream *standard-input*))
  (format *standard-output* ">")
  (-> (cst-read stream) cst-evaluate cst-print)
  (repl stream))

(defun cst-evaluate (cst)
  cst)

(defun cst-print (cst)
  (format *standard-output* "~a~%" cst))


;; helper stuff
(defmacro -> (x &rest forms)
  "Thread first macro."
  (chain-expander forms x))

(defun chain-expander (forms res)
  (if forms
      (let ((first-form (car forms)))
        (if (listp first-form) 
            (chain-expander (cdr forms)
                            (cons (car first-form)
                                  (cons res (cdr first-form))))
            (chain-expander (cdr forms) (list first-form res))))
      res))
