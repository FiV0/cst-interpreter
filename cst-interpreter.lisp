#|
  This file is a part of cst-interpreter.
  (c) 2019 Finn Völkel 
  Author: Finn Völkel  (first.lastname@gmail.com)
|#

(in-package :cst-interpreter)

(defun repl (&optional (stream *standard-input*) (env (make-null-environment)))
  (format *standard-output* ">")
  (multiple-value-bind (res env)
      (-> (eclector.concrete-syntax-tree:read stream) (cst-evaluate env))
    (cst-print res)
    (repl stream env)))

(define-condition not-implemented (error) ())
(define-condition illegal-function-call (error) ())
(define-condition unknown-symbol (error) ())

(defun cst-evaluate (cst &optional (env (make-null-environment)))
  "Evaluates a CST in the given ENV."
  (if (cst:atom cst)
      (cst-eval-atom cst env)
      (evaluate-compound-form cst env)))

(defun cst-eval-atom (cst env)
  ;;FIXME add symbols
  (if (find (type-of (cst:raw cst)) '(string integer character)
            :test #'subtypep)
      (values cst env)
      (values (lookup-var (symbol-name (cst:raw cst)) env) env)))

(defun evaluate-csts (csts env)
  "Evaluates a list of csts."
  (mapcar #'(lambda (cst) (cst-evaluate cst env)) csts))

(defun evaluate-compound-form (cst env)
  (let ((first-raw (-> cst cst:first cst:raw)))
    (when (eq first-raw 'set)
      (return-from evaluate-compound-form (eval-set cst env)))
    (unless (fun-in-env? (symbol-name first-raw) env)
      (error 'undefined-function))))


(defun evaluate-function-form (cst)
  (error 'not-implemented))

(defun evaluate-macro-form (cst)
  (error 'not-implemented))

(defun evaluate-special-form (cst)
  (error 'not-implemented))

(defun def-lambda (args body)
  (cst:cons (cst:cst-from-expression 'lambda) (cst:cons args (cst:cstify (list body)))))

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
