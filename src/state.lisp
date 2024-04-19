(in-package :cl-user)
(defpackage ttt.state
  (:use :cl :arrow-macros :ttt.fun)
  (:export :*initial* :click-cell :cell-pos :get-winner :next-turn))
(in-package :ttt.state)

(cl-punch:enable-punch-syntax)

(defvar *initial*
  '(:turn (:player :x
           :count 0)
    :winner nil
    :size (300 300)
    :board (nil nil nil
            nil nil nil
            nil nil nil)))

(defun click-cell (board turn pos)
  (with board pos turn))

(defun cell-pos (coord size)
  (destructuring-bind (x y w h) (append coord size)
    (let ((col (floor (/ x (/ w 3))))
          (row (floor (/ y (/ h 3)))))
      (+ col (* row 3)))))

(defun get-winner (board)
  (let ((positions `((0 4 8)
                     (2 4 6)
                     ,@(mapcar ^(list _ (+ 1 <_) (+ 2 <_)) '(0 3 6))
                     ,@(mapcar ^(list _ (+ 3 <_) (+ 6 <_)) '(0 1 2)))))
    (->> positions
         (mapcar (lambda (cells)
                   (destructuring-bind (a b c) (mapcar ^(nth _ board) cells)
                     (if (and (not (eq a nil)) (eq a b) (eq a c))
                         a nil))))
         (some 'identity))))

(defun next-turn (state coords)
  (destructuring-bind (&key turn winner size board) state
    (destructuring-bind (&key player count) turn
      (cond
        ((or (>= count 9) (not (eq winner nil)))
         *initial*)
        ((not (eq (nth (cell-pos coords size) board) nil))
         state)
        (t
         (let ((new-board (click-cell board player (cell-pos coords size))))
           `(:turn (:player ,(if (eq player :x) :o :x)
                    :count ,(+ 1 count))
             :winner ,(get-winner new-board)
             :size ,size
             :board ,new-board)))))))
