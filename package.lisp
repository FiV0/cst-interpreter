;; package.lisp

(defpackage cst-interpreter
  (:use :cl)
  (:import-from :arrow-macros
                :->
                :->>)
  (:export :repl
           :cst-evaluate))
