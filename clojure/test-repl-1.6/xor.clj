#!/usr/bin/env lein-exec
;; modified, from Joy of Clojure chapter 3 p.54

(defn xors [max-x max-y]
  (for [x (range max-x) y (range max-y)]
       [x y (bit-xor x y)]
))

(def frame (java.awt.Frame.))

(.setVisible frame true)

(.setSize frame (java.awt.Dimension. 600 400))

(def gfx (.getGraphics frame))

(defn draw-xor-pattern [w h]
  (doseq [[x y xor] (xors w h)]
    (let [color (mod xor 256)]
      (.setColor gfx (java.awt.Color. color color color))
      (.fillRect gfx x y 1 1)
    )
))

(draw-xor-pattern 600 400)

(Thread/sleep 3000)
