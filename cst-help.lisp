;; cst-help.lisp

(in-package :cst-interpreter)

(defun cst-length (cst)
  "Returns the length of a cst. 0 in case of an atom."
  (if (cst:consp cst)
      (1+ (cst-length (cst:rest cst)))
      0))

