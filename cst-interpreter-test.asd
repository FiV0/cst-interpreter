#|
  This file is a part of cst-interpreter.
  (c) 2019 Finn Völkel 
  Author: Finn Völkel  (first.lastname@gmail.com)
|#

(asdf:defsystem cst-interpreter-test
  :name "cst-interpreter-test"
  :version "1.0.0"
  :author "Finn Völkel  (first.lastname@gmail.com)"
  :license "MIT Licence"
  :description "Test system for cst-interpreter"
  :depends-on (:cst-interpreter
               :parachute)
  :components ((:file "cst-interpreter-test"))
  :perform (asdf:test-op (op c) (uiop:symbol-call :parachute :test
                                                  :cst-interpreter-test)))
