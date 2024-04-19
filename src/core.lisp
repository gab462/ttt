(in-package :cl-user)
(defpackage ttt.core
  (:use :cl :arrow-macros :ttt.fun)
  (:export :main))
(in-package :ttt.core)

(cl-punch:enable-punch-syntax)

(defun main ()
  (format t "Hello, World!~%"))
