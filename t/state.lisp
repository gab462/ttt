(in-package :cl-user)
(defpackage ttt-test.state
  (:use :cl :fiveam :ttt.fun)
  (:local-nicknames (:state :ttt.state)))
(in-package :ttt-test.state)

(def-suite state-tests
  :in ttt-test.all:all-tests)

(in-suite state-tests)

(test click
  "Replace position with current player"
  (is (equal '(:x  nil nil
               nil nil nil
               nil nil nil)
             (state:click-cell (getf state:*initial* :board) :x 0)))
  (is (equal '(nil nil nil
               :o  nil nil
               nil nil nil)
             (state:click-cell (getf state:*initial* :board) :o 3)))
  (is (equal '(nil nil nil
               nil nil nil
               nil nil :x )
             (state:click-cell (getf state:*initial* :board) :x 8))))

(test cell-pos
  "Get cell position by coordinate"
  (is (equal 0 (state:cell-pos '(1 1) '(300 300))))
  (is (equal 3 (state:cell-pos '(1 150) '(300 300))))
  (is (equal 8 (state:cell-pos '(299 299) '(300 300)))))

(test winner
  "Get winner by board positions"
  (is (equal :x
             (state:get-winner '(:x  nil nil
                                 nil :x  nil
                                 nil nil :x ))))
  (is (equal :o
             (state:get-winner '(nil nil :o
                                 nil :o  nil
                                 :o  nil nil))))
  (is (equal :x
             (state:get-winner '(:x  :x  :x
                                 nil nil nil
                                 nil nil nil))))
  (is (equal :o
             (state:get-winner '(nil nil :o
                                 nil nil :o
                                 nil nil :o ))))
  (is (equal nil
             (state:get-winner '(nil nil nil
                                 nil nil nil
                                 nil nil nil)))))

(test next-turn
  "Advance state to next turn"
  (is (equal `(:turn (:player :o :count 1)
               :winner nil
               :size ,(getf state:*initial* :size)
               :board (:x  nil nil
                       nil nil nil
                       nil nil nil))
             (state:next-turn state:*initial* '(1 1))))
  (is (equal state:*initial*
             (state:next-turn
              (with state:*initial* :winner :o)
              '(1 1))))
  (let ((game-state (with state:*initial* :board '(:x  nil nil
                                                   nil nil nil
                                                   nil nil nil))))
    (is (equal game-state
               (state:next-turn game-state '(1 1))))))
