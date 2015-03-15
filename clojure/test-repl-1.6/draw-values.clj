#!/usr/bin/env lein-exec
;; modified, from Joy of Clojure chapter 3 p.54

(defn f-values [f xs ys]
  (for [x (range xs) y (range ys)]
  	[x y (f x y)]
))

(def frame (java.awt.Frame.))

(.setVisible frame true)

(def gfx (.getGraphics frame))

(defn clear [gfx w h] (.clearRect gfx 0 0 w h))

(defn draw-values [f w h]
  (clear gfx w h)
  (.setSize frame (java.awt.Dimension. w h))
  (doseq [[x y v] (f-values f w h)]
    (let [color (mod v 256)]
      (.setColor gfx (java.awt.Color. color color color))
      (.fillRect gfx x y 1 1)
    )
))

;(draw-values bit-and 600 400)
;(draw-values (fn [x y] (int (* (/ x 2) (/ y 2))) ) 600 400)
;(draw-values (fn [x y] (if (= x 0) 0 (int (* 1000 (/ y x)))) ) 600 400)
(draw-values (fn [x y] (if (= x 0) 0 (int (* 2 y (Math/sin (/ x 50 ))))) ) 600 600)

;TODO как несколько функций в теле if?

(if (not-empty *command-line-args*)
	;TODO: event loop
	(Thread/sleep 2000)
	(println "run from REPL")
)

