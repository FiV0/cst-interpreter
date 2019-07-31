#|
  This file is a part of cst-interpreter.
  (c) 2019 Finn Völkel 
  Author: Finn Völkel  (first.lastname@gmail.com)
|#

(asdf:defsystem cst-interpreter
  :version "0.0.1"
  :author "Finn Völkel"
  :license "MIT Licence"
  :serial t
  :depends-on ("concrete-syntax-tree"
               "eclector"
               "eclector-concrete-syntax-tree")
  :components ((:file "cst-interpreter"))
  :description ""
  :in-order-to ((test-op (test-op "cst-interpreter-test"))))
