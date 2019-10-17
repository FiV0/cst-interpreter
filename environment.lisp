;;; 
(in-package :cst-interpreter)

(defstruct (env
             (:constructor %make-env (parent vars funs)))
  parent
  vars
  funs)

(defun make-env (&key parent vars funs)
  (%make-env parent
             (append vars (env-vars parent))
             (append funs (env-funs parent))))

(defun make-null-environment ()
  (%make-env nil nil nil))

(defun push-var (name value env)
  (push (cons name value) (env-vars env)))

(defun push-fun (name value &optional (type :normal))
  (push (cons name (values value type)) (env-funs env)))

(define-condition unknown-variable (error) ())

(defun lookup-var (name env)
  (dolist (var (env-vars env))
    (when (equal name (car var))
      (return-from lookup-var (cdr var))))
  (error 'unknown-variable))

(defun var-in-env? (name env)
  (handler-case (lookup-var name env)
    (unknown-variable (c) (declare (ignore c)) nil)
    (t (c)  (declare (ignore c)) t)))

(define-condition unknown-function (error) ())

(defun lookup-fun (name env)
  (dolist (fun (env-funs env))
    (when (equal name (car fun))
      (return-from lookup-fun (cdr fun))))
  (error 'unknown-function))

(defun fun-in-env? (name env)
  (handler-case (lookup-fun name env)
    (unknown-function (c) (declare (ignore c)) nil)
    (t (c) (declare (ignore c)) t)))
