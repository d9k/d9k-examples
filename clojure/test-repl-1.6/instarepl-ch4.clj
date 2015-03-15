; Joy of Clojure, part 4

(clojure-version)

(use 'clojure.math.numeric-tower)

(def a  1.0e50)
(def b -1.0e50)
(def c 17.0e00)

(abs 5)

(+ (+ a b) c)

(+ a (+ b c))

(let [a (float 0.1)
      b (float 0.2)
      c (float 0.3)]
  (=
    (* a (+ b c))
    (+ (* a b) (* a c))
  )
)
$$$
(def a (rationalize 1.0e50))
(def b (rationalize -1.0e50))
(def c (rationalize 17.0e50))

(+ (+ a b) c)

(+ a (+ b c))

(let [a (rationalize 0.1)
      b (rationalize 0.2)
      c (rationalize 0.3)]
  (=
    (* a (+ b c))
    (+ (* a b) (* a c))
  )
)

(numerator (/ 34 5))

(denominator (/ 34 5))


(def population {:zombies 2750 :humans 9})

(:zombies population)

(println (int (ceil (/ (:zombies population)
            (:humans population))))
         "zombies per capita")

(defn pour [lb ub]
  (cond
     (= ub :hours) (range lb (+ 24 1))
     :else (range lb ub)
  )
)

(pour 1 20)
(pour 5 :hours)

::not-in-ns
:user/not-in-ns

*ns*


(identical? 'goat 'goat)

(= 'goat 'goat)

(name 'goat)

(let [x 'goat y x] (identical? x y))


; metadate p.71

(let [x (with-meta 'goat {:ornery true})
      y (with-meta 'goat {:ornery false})]

  [(= x y)
   (identical? x y)
   (meta x)
   (meta y)]
  )

*ns*

(ns where-is)
(def a-symbol 'where-am-i)

*ns*

a-symbol

(resolve 'a-symbol)

`a-symbol


(defn best [f xs]
  (reduce #(if (f % %2) % %2) xs)
)

(best > [1 3 4 2 7 5 3])

; regexes p.73

(java.util.regex.Pattern/compile "\\d")


(seq (.split #"," "one,two,three"))

(re-seq #"\w+" "one-two//three.four  five")

(re-seq #"\w*(\w)" "one-two/three")












