#!/usr/bin/env lein-exec


(println (clojure-version))

; doesnt' work from instarepl and cmdline either :(
; F**K!

(defn slope2 [p1 p2]
  ""
  {:pre [(not= p1 p2) (vector? p1) (vector? p2)]
   :post [(float? %)]}
  (float (/ (- (p2 1) (p1 1))
            (- (p2 0) (p1 0)))))





;(slope2 [10 10] [10 10])

;(slope2 [10 1] '(1 20))

;(slope2 [10 1] [1 20])

;(slope2 [10.0 1] [1 20])
