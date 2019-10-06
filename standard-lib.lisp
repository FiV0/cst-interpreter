;; standard-lib.lisp

(in-package :cst-interpreter)

(define-condition this-should-not-happen (error) ())
(define-condition invalid-number-of-arguments (error)
  ((nb-args :initarg :nb-args
            :reader nb-args))
  (:report (lambda (condition stream)
             (format stream "invalid number of arguments: ~S~&" (nb-args condition)))))

(defun eval-set (cst env)
  "Eval the set function."
  (when (not (eq (cst:raw (cst:first cst)) 'set))
    (error 'this-should-not-happen))
  (let ((nb-args (cst-length cst)))
    (when (/= nb-args 3)
      (error 'invalid-number-of-arguments :nb-args nb-args))
    (let ((res (cst-evaluate (cst:third cst) env))
          (symbol (cst:raw (cst:second cst))))
      (push-var (symbol-name symbol) res env)
      (values res env))))
