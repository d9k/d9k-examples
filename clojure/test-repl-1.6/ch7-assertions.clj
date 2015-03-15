#!/usr/bin/env lein-exec

(def directions {:north {:x  0, :y -1}
                 :east  {:x  1, :y  0}
                 :south {:x  0, :y  1}
                 :west  {:x -1, :y  0}})

(defn move-to [pos direction-key]
  ;{:test (fn []
  ;     (assert (= (move-to [1 2] :north)  [1 1]))
  ;     (assert (= (move-to [1 2] :east )  [2 2]))
  ;     (assert (= (move-to [1 2] :west )  [0 2]))
  ;     (assert (= (move-to [1 2] :south ) [1 0])))}
  [(+ (pos 0) (:x (directions direction-key)))
   (+ (pos 1) (:y (directions direction-key)))])

(clojure.test/deftest test-move-to
  (assert (= (move-to [1 2] :north)  [1 1]))
  (assert (= (move-to [1 2] :east )  [2 2]))
  (assert (= (move-to [1 2] :west )  [0 2]))
  (assert (= (move-to [1 2] :south)  [1 3])))

(clojure.test/run-tests 'user)

;(clojure.test/successful?)

