(in-package :cl-user)
(defpackage ttt-asd
  (:use :cl :asdf))
(in-package :ttt-asd)

(defsystem ttt
  :license "MIT"
  :depends-on (:arrow-macros :cl-punch)
  :serial T
  :pathname "src"
  :components ((:file "fun")
               (:file "state")
               (:file "core"))
  :build-operation :program-op
  :build-pathname "ttt"
  :entry-point "ttt.core:main"
  :in-order-to ((test-op (test-op :ttt-test))))
