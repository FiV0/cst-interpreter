(defpackage cst-interpreter-test
  (:use :cl
        :cst-interpreter
        :parachute)
  (:shadow #:run)
  (:export cst-interpreter-test))
(in-package :cst-interpreter-test)

;; NOTE: To run this test file, execute `(asdf:test-system :cst-interpreter)' in your Lisp.

;; (defun add-nickname (package nickname)
;;   (when (stringp package)
;;     (setf package (find-package package)))
;;   (check-type package package)
;;   (check-type nickname string)
;;   (rename-package package (package-name package)
;;                   (adjoin nickname (package-nicknames package)
;;                           :test #'string=)))

;; (add-nickname (find-package 'eclector.concrete-syntax-tree) "e-cst")

;; start of tests

(defun cst-structure-equal (cst1 cst2)
  (equal (cst:raw cst1) (cst:raw cst2)))

(define-test cst-length-test
  (let ((funcall (eclector.concrete-syntax-tree:read-from-string "(+1 1)"))
        (atom-cst (eclector.concrete-syntax-tree:read-from-string "2")))
    (is-values (values (cst-interpreter::cst-length funcall)
                       (cst-interpreter::cst-length atom-cst))
      (= 2)
      (= 0))))

(define-test eval-set-test
  (let ((set-expr (eclector.concrete-syntax-tree:read-from-string "(set x 1)"))
        (res-expr (eclector.concrete-syntax-tree:read-from-string "1")))
    (multiple-value-bind (res env)
        (cst-interpreter::eval-set set-expr (cst-interpreter::make-null-environment))
      (is cst-structure-equal res-expr res)
      (true (cst-interpreter::var-in-env? (symbol-name 'x) env))
      (is cst-structure-equal res-expr (cst-interpreter::lookup-var (symbol-name 'x) env)))))


(define-test def-lambda-test
  (let ((lambda-list (eclector.concrete-syntax-tree:read-from-string "(x y)"))
        (body (eclector.concrete-syntax-tree:read-from-string "(list x y)"))
        (lambda-function (eclector.concrete-syntax-tree:read-from-string
                          "(lambda (x y) (list x y))")))
    (is cst-structure-equal 
        (cst-interpreter::def-lambda lambda-list body)
        lambda-function)))

;; (let ((expr1 (eclector.concrete-syntax-tree:read-from-string "(+1 1)"))
;;       (expr2 (eclector.concrete-syntax-tree:read-from-string "(+1 2)")))
;;   (values (cst::eq expr1 expr2) (equal (cst:raw expr1) (cst:raw expr2))))
