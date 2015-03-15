; Functional programming

; comp - composition

(def fifth (comp first rest rest rest rest))

(fifth [1 2 3 4 5])

(defn fnth [n]
  (apply comp
         (cons first
               (take (dec n) (repeat rest)))))

((fnth 5) '[a b c d e])

(map (comp keyword #(.toLowerCase %) name) '(a B C))

((partial + 5) 100 200)

; complement takes bool function and returns function with oposite bool value

(let [truthiness (fn [v] v)]
  [((complement truthiness) true)
   ((complement truthiness) 42)
   ((complement truthiness) false)
   ((complement truthiness) nil)])

((complement even?) 2)

(defn join
  "doc"
  {:test (fn []
           (assert
            ;error: (= (join "," [1 2 3]) "1,3,3")))}
            (= (join "," [1 2 3]) "1,2,3")))}
  [sep s]
  (apply str (interpose sep s)))

(use '[clojure.test :as t])

(t/run-tests)

(def plays [{:band "Burial"     :plays 987    :loved 9  }
            {:band "Eno"        :plays 2353   :loved 15 }
            {:band "Bill Evans" :plays 979    :loved 10  }
            {:band "Magma"      :plays 2333   :loved 12 }
            {:band "Beatles"    :plays 2017   :loved 8 }])

((partial sort-by #(/ (:plays %)) plays))


((partial sort-by #(/ (:loved %)) plays))

(def sort-by-loved-ratio (partial sort-by #(/ (:plays %) (:loved %))))

(sort-by-loved-ratio plays)
(defn columns [column-names]
    (fn [row]
        (vec (map row column-names))))



((columns [:plays :loved :band]) (first plays))

(sort-by (columns [:plays :loved :band]) plays)
; strange.. don't work
(sort-by (columns [:plays]) plays)

((columns [:plays]) (first plays))
((columns [:plays]) (plays 0))
((columns [:plays]) (plays 1))

(for [x plays] ((columns [:plays]) x))

(sort-by (columns [:plays]) plays)

(for [x plays] x)
(for [x plays] ((columns [:plays]) x))

(for [x plays] (first ((columns [:plays]) x)))

(sort (for [x plays] (first ((columns [:plays]) x))))

(sorted? (sort (for [x plays] (first ((columns [:plays]) x)))))

(defn keys-apply [f ks m]
  "Takes a function, a set of keys, and a map and applies the function
  to the map on the given keys. A new map of the results of the function
  applied to the keyed entries is returned."
  (let [only (select-keys m ks)]
    (zipmap (keys only) (map f (vals only)))))

(select-keys {:a 1 :b 2 :c 3 :d 4} [:a :e :c])

(reverse {:p 4 :d 6})

(zipmap [:potatoes :tomatoes] [5 7])

(keys {:p 4 :d 6})

(vals {:p 4 :d 6})


(keys-apply #(.toUpperCase %) #{:band} (plays 0))
(keys-apply #(.toUpperCase %) [:band] (plays 0))

(type '(+ 1 2))
(type #(+ 1 2))

(def a #(+ 1 2))

(a)

(defn manip-map [f ks m]
  "Takes a function, a set of keys, and a map and applies the function
  to the map on the given keys. A modified version of the original map
  is returned with the results of the function applied to each keyed entry."
  (conj m (keys-apply f ks m)))

(manip-map #(int (/ % 2)) #{:plays :loved} (plays 0))


(defn halve! [ks m]
  (map (partial manip-map #(int (/ % 2)) ks) m))

(halve! [:plays] plays)
(halve! [:plays :loved] plays)
; named args

; python:
;
; def slope(p1=(0,0), p2=(1,1)):
;     return (float(p2[1] - p1[1])) / (p2[0] - p1[0])

(defn slope
  [& {:keys [p1 p2] :or {p1 [0 0] p2 [1 1]}}]
  (float (/ (- (p2 1) (p1 1))
            (- (p2 0) (p1 0)))))

(slope :p1 [4 15] :p2 [3 21])

(slope :p2 [2 1])

(slope)

; pre & post constraints

(defn slope2 [p1 p2]
  ""
  {:pre [(not= p1 p2) (vector? p1) (vector? p2)]}
   ; don't work - unexpected % symbol
   ;:post [(float? %)]}
  (float (/ (- (p2 1) (p1 1))
            (- (p2 0) (p1 0)))))

;doesnt' work from instarepl

;(slope2 [10 10] [10 10])

;(slope2 [10 1] '(1 20))

(defn put-things [m]
  (into m {:meat "beef" :veggie "broccoli"}))

(put-things {:meat "pork"})

;doesnt' work from instarepl
;(defn vegan-constraints [f m]
;  {:pre [(:veggie m)]
;   :post [(:veggie %) (nil? (:meat %))]}
;  (f m))

;(vegan-constraints put-things {:veggie "carrot"})

; TODO more constraints at p.135 which don't work on instarepl

; clojures p.135

(def times-two
  (let [x 2]
    (fn [y] (* y x))))

(times-two 5)

; works as static field

(def add-and-get
  (let [ai (java.util.concurrent.atomic.AtomicInteger.)]
    (fn [y] (.addAndGet ai y))))

(add-and-get 2)

(add-and-get 7)

(add-and-get 9)

(defn times-n [n]
  (let [x n]
    (fn [y] (* y x))))


(def times-three (times-n 3))

(times-three 5)

(defn divisible [denom]
  (fn [num]
    (zero? (rem num denom))))

((divisible 3) 6)

((divisible 3) 7)

(filter even? (range 10))

(filter (divisible 4) (range 10))

(defn filter-divisible [denom s]
  (filter (fn [num] (zero? (rem num denom))) s))

(filter-divisible 5 (range 20))


(def directions {:north {:x  0, :y -1}
                 :east  {:x  1, :y  0}
                 :south {:x  0, :y  1}
                 :west  {:x -1, :y  0}})

(def directions-keys (into [] (keys directions)))


(type directions-keys)

(.indexOf directions-keys :east )

(defn move-to [pos direction-key]
  {:test (fn []
       (assert (= (move-to [1 2] :north) [1 1]))
       (assert (= (move-to [1 2] :east ) [2 2]))
       (assert (= (move-to [1 2] :south) [1 0]))
       (assert (= (move-to [1 2] :west ) [1 3])))}
  [(+ (pos 0) (:x (directions direction-key)))
   (+ (pos 1) (:y (directions direction-key)))])

(move-to [1 2] :north)

(move-to [1 2] :east)

(move-to [1 2] :south)

(move-to [1 2] :west)

(defn bot [pos direction-key]
  {:coords pos
   :direction direction-key
   :forward (fn [] (bot [(+ (pos 0) (:x (directions direction-key)))
                         (+ (pos 1) (:y (directions direction-key)))]
                          direction-key))})

(:coords (bot [1 2] :north))

(:direction (bot [1 2] :north))

((:forward (bot [1 2] :north)))

((:forward ((:forward (bot [1 2] :north)))))


(defn bot [pos direction-key]
  {:coords pos
   :direction direction-key
   :forward (fn [] (bot [(+ (pos 0) (:x (directions direction-key)))
                         (+ (pos 1) (:y (directions direction-key)))]
                          direction-key))
   :turn-right (fn [] (bot pos (directions-keys (mod (+ (.indexOf directions-keys direction-key) 1) 4 )) ))
   :turn-left  (fn [] (bot pos (directions-keys (mod (- (.indexOf directions-keys direction-key) 1) 4 )) ))
})

((:turn-right (bot [1 2] :north)))

((:turn-left (bot [1 2] :north)))

(defn mirror-bot [pos direction-key]
  {:coords pos
   :direction direction-key
   :forward (fn [] (bot [(- (pos 0) (:x (directions direction-key)))
                         (- (pos 1) (:y (directions direction-key)))]
                          direction-key))
   :turn-right (fn [] (bot pos (directions-keys (mod (- (.indexOf directions-keys direction-key) 1) 4 )) ))
   :turn-left  (fn [] (bot pos (directions-keys (mod (+ (.indexOf directions-keys direction-key) 1) 4 )) ))
})

((:turn-right (mirror-bot [1 2] :north)))
((:turn-left (mirror-bot [1 2] :north)))

((:forward (mirror-bot [1 2] :east)))

; recursion

; mundane recursion

(defn pow [base exp]
  (if (zero? exp)
    1
    (* base (pow base (dec exp)))))

(pow 2 10)

(pow 1.003 365)

;(pow 2M 10000) => StackOverflowError

; tail recursion p.142
; explicit recur avoids stack consumption

(defn pow [base exp]
  (letfn [(kapow [base exp acc]
              (if (zero? exp)
                  acc
                  ; (kapow base (dec exp) (* base acc))))] - causes StackOverflowError - no tail call optimisation
                  (recur base (dec exp) (* base acc))))]
    (kapow base exp 1)))

; 2M - BigInt (BigDecimal)

(pow 2M 10000)

; p. 146

(defn elevator [commands]
  (letfn
    [(ff-open [[cmd & r]]
           "When the elevator is open on the 1st floor
            it can either close or be done."
           #(case cmd
              :close (ff-closed r)
              :done true
              false))
     (ff-closed [[cmd & r]]
           #(case cmd
              :open (ff-open r)
              :up   (sf-closed r)
              false))
     (sf-closed [[cmd & r]]
           #(case cmd
              :down (ff-closed r)
              :open (sf-open r)
              false))
     (sf-open [[cmd & r]]
           #(case cmd
              :close (sf-closed r)
              :done true
              false))]
    (trampoline ff-open commands)))


(elevator [:close :open :done])

(elevator [:close :up :open :done])

(elevator [:close :open :close :up :open :done])

;(elevator (cycle [:close :open])) - runs forever

(elevator (conj (take 10000 (cycle [:close :open])) :done) )

; factorial function
; CPS - continuation-passing style

(defn fac-cps [n k]
    (letfn [(cont [v] (k (* v n)))]
        (if (zero? n)
            (k 1)
            (recur (dec n) cont))))

(defn fac [n]
  (fac-cps n identity))

(fac 10)

(defn mk-cps [accept? end-value kend kont]
  (fn [n]
    ((fn [n k]
       (let [cont (fn [v] (k (kont v n)))]
         (if (accept? n)
           (k end-value)
           (recur (dec n) cont))))
     n kend)))

(def fac (mk-cps zero? 1 identity #(* %1 %2)))

(fac 10)

(def tri (mk-cps zero? 1 dec #(+ %1 %2)))

(tri 10)

(peek [1 3 4])

(peek '(1 3 4))

(time (peek [1 3 4]))

(time (peek '(1 3 4)))

(time (first '(1 3 4)))

(type [1 3 4])

(type '(1 3 4))


; neighbors function from chapter 5 ~p.82-86

(defn neighbors
  ([size yx] (neighbors [[-1 0][1 0][0 -1][0 1]] size yx))
  ([deltas size yx]
    (filter (fn [new-yx]
        (every? #(< -1 % size) new-yx))
        (map #(map + yx %) deltas)
    )
  )
)

(neighbors 5 [0 0])

(defn min-by [f coll]
  (when (seq coll)
    (reduce (fn [min this]
              (if (> (f min) (f this)) this min))
             coll)))

(min-by :cost [{:cost 100} {:cost 36} {:cost 9}])

(defn estimate-cost [step-cost-est size y x]
  (* step-cost-est
     (- (+ size size y x 2))))

(defn path-cost [node-cost cheapest-nbr]
  (+ node-cost
     (:cost cheapest-nbr 0)))

(path-cost 900 {:cost 1})

(defn total-cost [newcost step-cost-est size y x]
  (+ newcost
     (estimate-cost step-cost-est size y x)))


(def world [[   1   1   1   1   1]
            [ 999 999 999 999   1]
            [   1   1   1   1   1]
            [   1 999 999 999 999]
            [   1   1   1   1   1]])

;main A* algo p.
;how it works??


; into - java.lang.ClassCastException: clojure.lang.LazySeq cannot be cast to java.lang.Comparable

(defn astar [start-yx step-est cell-costs]
  (let [size (count cell-costs)]
    (loop [steps 0
           routes (vec (replicate size (vec (replicate size nil))))
           work-todo (sorted-set [0 start-yx])]
      (if (empty? work-todo)
        [(peek (peek routes)) :steps :steps]
        (let [[_ yx :as work-item] (first work-todo)
              rest-work-todo (disj work-todo work-item)
              nbr-yxs (neighbors size yx)
              cheapest-nbr (min-by :cost
                                   (keep #(get-in routes %)
                                         nbr-yxs))
              newcost (path-cost (get-in cell-costs yx)
                                 cheapest-nbr)
              oldcost (:cost (get-in routes yx))]
          (if (and oldcost (>= newcost oldcost))
            (recur (inc steps) routes rest-work-todo)
            (recur (inc steps)
                   (assoc-in routes yx
                             {:cost newcost
                              :yxs (conj (:yxs cheapest-nbr [])
                                         yx)})
                   (into rest-work-todo
                         (map
                            (fn [w]
                               (let [[y x] w]
                                 [(total-cost newcost step-est size y x) w]))
                          nbr-yxs)))))))))

(astar [0 0]
       900
       world)







