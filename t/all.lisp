(in-package :cl-user)
(defpackage ttt-test.all
  (:use :cl :fiveam)
  (:export :all-tests))
(in-package :ttt-test.all)

(def-suite all-tests)
