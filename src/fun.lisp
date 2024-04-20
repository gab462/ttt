(in-package :cl-user)
(defpackage ttt.fun
  (:use :cl)
  (:export :with :update))
(in-package :ttt.fun)

(defun with (xs k v)
  (if (numberp k)
      (append (subseq xs 0 k) (list v) (subseq xs (+ k 1)))
      (let ((pos (position k xs)))
        (cond
          ((numberp pos)
           (append (subseq xs 0 pos) (list k v) (subseq xs (+ pos 2))))
          ((eq pos nil)
           (append xs (list k v)))))))

(defun update (xs k f)
  (with xs k (funcall f (getf xs k))))
