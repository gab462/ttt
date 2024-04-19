(in-package :cl-user)
(defpackage ttt.fun
  (:use :cl)
  (:export :drop :take :with :update))
(in-package :ttt.fun)

(defun drop (n xs)
  (if (= n 0) xs
      (drop (- n 1) (cdr xs))))

(defun take (n xs &optional (acc '()))
  (if (= n 0) acc
      (take (- n 1) (cdr xs) (append acc (list (car xs))))))

(defun with (xs k v)
  (if (numberp k)
      (append (take k xs) (list v) (drop (+ k 1) xs))
      (let ((pos (position k xs)))
        (cond
          ((numberp pos)
           (append (take pos xs) (list k v) (drop (+ pos 2) xs)))
          ((eq pos nil)
           (append xs (list k v)))))))

(defun update (xs k f)
  (with xs k (funcall f (getf xs k))))
