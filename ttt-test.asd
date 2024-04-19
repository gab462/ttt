(in-package :cl-user)
(defpackage ttt-test-asd
  (:use :cl :asdf :uiop))
(in-package :ttt-test-asd)

(defsystem ttt-test
  :license "MIT"
  :depends-on (:ttt :fiveam)
  :pathname "t"
  :serial T
  :components ((:file "all")
               (:file "state"))
  :perform (test-op (o s)
             (symbol-call :fiveam :run! (find-symbol* :all-tests :ttt-test.all))))
