#|
  This file is a part of cst-interpreter.
  (c) 2019 Finn Völkel 
  Author: Finn Völkel  (first.lastname@gmail.com)
|#

(defpackage cst-interpreter
  (:use :cl)
  (:import-from :arrow-macros
                :->
                :->>)
  (:export :repl
           :cst-evaluate))
(in-package :cst-interpreter)

(defun repl (&optional (stream *standard-input*))
  (format *standard-output* ">")
  (-> (eclector.concrete-syntax-tree:read stream) cst-evaluate cst-print)
  (repl stream))

(define-condition not-implemented (error) ())
(define-condition illegal-function-call (error) ())
(define-condition unknown-symbol (error) ())

(defun cst-evaluate (cst)
  "Evaluates a cst."
  (if (cst:atom cst)
      cst
      (evaluate-compound-form cst)))

(defun evaluate-csts (csts)
  "Evaluates a list of csts."
  (mapcar #'evaluate-cst csts))

(defun evaluate-compound-form (cst)
  (let ((first-raw (-> cst cst:first cst:raw)))
    ))

(defun evaluate-function-form (cst)
  (error 'not-implemented))

(defun evaluate-macro-form (cst)
  (error 'not-implemented))

(defun evaluate-special-form (cst)
  (error 'not-implemented))

(defun cst-print (cst)
  (format *standard-output* "~a~%" cst))


;; helper stuff
(defun cst-to-list (cst)
  "Transforms a cst into a list of csts of its subexpressions."
  (cond
    ((cst:null cst)
     '())
    ((cst:consp cst)
     (cons (cst:first cst) (cst-to-list (cst:rest cst))))
    (T (list cst))))
