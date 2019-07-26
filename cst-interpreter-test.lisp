(defpackage cst-interpreter-test
  (:use :cl
        :cst-interpreter
        :parachute)
  (:shadow #:run)
  (:export cst-interpreter-test))
(in-package :cst-interpreter-test)

;; NOTE: To run this test file, execute `(asdf:test-system :cst-interpreter)' in your Lisp.

(define-test text-target-1 
  (is-values (values 0 "1")
    (= 0)
    (equal "1")))
