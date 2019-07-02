;;;; cst-interpreter.asd

(asdf:defsystem #:cst-interpreter
  :description "Describe cst-interpreter here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:eclector #:eclector-concrete-syntax-tree #:parachute)
  :components ((:file "package")
               (:file "cst-interpreter")))
