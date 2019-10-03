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

(define-test def-lambda-test
  (let ((lambda-list (eclector.concrete-syntax-tree:read-from-string "(x y)"))
        (body (eclector.concrete-syntax-tree:read-from-string "(list x y)"))
        (lambda-function (eclector.concrete-syntax-tree:read-from-string
                          "(lambda (x y) (list x y))")))
    ;; FIXME
    (is cst::equal
        (cst-interpreter::def-lambda lambda-list body)
        lambda-function)))

(parachute:test 'def-lambda-test)
