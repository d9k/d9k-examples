(def ds (into-array [:willie :barnabas :adam]))
(seq ds)
(seq [:willie :barnabas :adam])

(aset ds 1 :quentin)
(seq ds)

(def pds [:willie :barnabas :adam])

(def pds1 (replace {:barnabas :quentin} pds))

pds
pds1

; sequences p.76

(first pds1)
(rest pds1)
(first [])

; the same values in the same order:
(= [1 2 3] '(1 2 3))

; maps are not sequential
(= [1 2 3] #{1 2 3})

(hash-map :a 1 :b 2)
(class (hash-map :a 1 :b 2))
(seq (hash-map :a 1 :b 2))
(class (seq (hash-map :a 1 :b 2)))

(range 10)
(vec (range 10))

(let [my-vector [3 5 7]]
  (into my-vector (range 10))
)

(map vector [1 3 5] [2 4 6])
(into (vector-of :char) [120 121 33])
(into (vector-of :int) [Math/PI 2 1.3])
(into (vector-of :int) [4 "5"])

(def a-to-j (vec (map char (range 65 75))))
(nth a-to-j 4)
(get a-to-j 4)
(a-to-j 4)

(seq a-to-j)
(rseq a-to-j)
(def a-to-j (assoc a-to-j 4 "no longer E"))

(get a-to-j 4)


(replace {2 12, 4 14} [1 2 3 2 3 4])

(def matrix
  [[1 2 3]
   [4 5 6]
   [7 8 9]])

(get-in matrix [1 2])
((matrix 0) 2)
(assoc-in matrix [1 2] 'x)
(update-in matrix [1 2] * 100)
matrix

(defn neighbours
  ([size yx] (neighbours [[-1 0][1 0][0 -1][0 1]] size yx))
  ([deltas size yx]
    (filter (fn [new-yx]
        (every? #(< -1 % size) new-yx))
        (map #(map + yx %) deltas)
    )
  )
)

; about nt sign:
; (see http://www.braveclojure.com/do-things/)

(#(str %1 " and " %2 ) "corn bread" "butter beans")
(map #(get-in matrix %) (neighbours 3 [0 0]))
(map #(get-in matrix %) (neighbours 3 [0 1]))


(def my-stack [1 2 3])
(peek my-stack)
my-stack
(pop my-stack)
my-stack
(+
  (peek my-stack) ; 3
  (peek (pop my-stack)) ; [1 2] -> 2
)

; TODO strict-map function implementation p. 87

(def a-to-j (vec (map char (range 65 75))))
(subvec a-to-j 3 6)

(second a-to-j)

(cons 1 '(2 3))
(conj '(2 3) 1 0 -1)

; Queues

(defmethod print-method clojure.lang.PersistentQueue [q, w]
  (print-method '<- w) (print-method (seq q) w) (print-method '-< w))

clojure.lang.PersistentQueue/EMPTY

(def schedule
  (conj clojure.lang.PersistentQueue/EMPTY
        :wake-up :shower :brush-teeth))

(peek schedule)

(first schedule)

(pop schedule)

; returns vector, not queue
(rest schedule)

schedule

; persistent sets
; can contain only unique elements:
; #{[] ()} -> #{[]}
; #{[1 2] (1 2)} -> #{[1 2]}
; #{[] () #{} {}} -> #{#{} {} []}

(#{:a :b: :c :d} :c)

(#{:a :b: :c :d} :g)

; sets - search for containtment

(some #{:b} [:a 1 :b 2])

(some #{1 :b} [:a 1 :b 2])

(some #{2 :b} [:a 1 :b 2])

(some #{:g} [:a 1 :b 2])

(get #{:a 1 :b 2} :b)

(get #{:a 1 :b 2} :nothing-to-do)


; sorted set - args must be mutually comparable

(sorted-set :Bill :Bian :Antony)

(sorted-set [1 5] [3 5] [1 2])

(sorted-set 4 5 1)

(contains? #{1 2 3 4} 4)

(contains? [1 2 3 4] 4)

(clojure.set/intersection #{:humans :fruit-bats :zombies}
                          #{:chupacabra :zombies :humans})

(clojure.set/intersection #{:1 :2 :3 :4}
                          #{:1 :4 :5}
                          #{:5 :2 :4})


(clojure.set/union #{:humans :fruit-bats :zombies}
                   #{:chupacabra :zombies :humans})


(clojure.set/union #{:1 :2 :3 :4}
                   #{:1 :4 :5}
                   #{:5 :2 :4})


(clojure.set/difference #{:humans :fruit-bats :zombies}
                   #{:chupacabra :zombies :humans})


(clojure.set/difference #{:1 :2 :3 :4}
                       #{:1 :4 :5}
                       #{:5 :2 :4})

; hash maps {} - unsorted ket-value associative structure


(hash-map :a 1, :b 2, :c 3, :d 4, :e 5)

(let [m {:a 1, 1 :b, [1 2 3] "4 5 6"}]
  [(m 1) (m [1 2 3])])

(seq {:a 1, :b 2})


(into {:p 5, :a 2} [[:a 1][:b 2]])
(into (sorted-map) [ {:a 1} {:c 3} {:b 2} ] )

(apply hash-map [:a 1 :b 2])


(zipmap [:a :b :c] [1 2])


(sorted-map :thx 1138 :r2d 2)

(assoc {1 :int} 1.0 :float)

(assoc (sorted-map 1 :int) 1.0 :float)


(defn pos [e coll]
 (let [cmp (if (map? coll)
             #(= (second %1) %2)
             #(= %1 %2)
           )
      ]

   (loop [s coll idx 0]
     (when (seq s)
       (if (cmp (first s) e)
          (if (map? coll)
             (first (first s))
             idx)
          (recur (next s) (inc idx))
       )
     )
   )
 )
)


;(defn pos [e coll]
; (let [cmp (if (map? coll)
;       #(= (second %1) %2)
;       #(= %1 %2))]
;   (loop [s coll idx 0]
;     (when (seq s)
;       (if (cmp (first s) e)
;         (if (map? coll)
;           (first (first s))
;            idx)
;         (recur (next s) (inc idx)))))))


(pos 3 [:a 1 :b 2 :c 3 :d 4])

(pos :foo [:a 1 :b 2 :c 3 :d 4])

(= {:a 1, :b 2, :c 3, :d 4} {:a 1 :b 2 :c 3 :d 4})

(pos 3 {:a 1 :b 2 :c 3 :d 4})

(pos 3 '(:a 1 :b 2 :c 3 :d 4))

(pos \3 ":a 1 :b 2 :c 3 :d 4")

(defn index [coll]
    (cond
        (map? coll) (seq coll)
        (set? coll) (map vector coll coll)
        :else (map vector (iterate inc 0) coll)))

(index [:a 1 :b 2 :c 3 :d 4])

(index {:a 1 :b 2 :c 3 :d 4})

(index {:a 1 :b 2 :c 3 :d 4})

(defn pos [e coll]
  (for [[i v] (index coll) :when (= e v)] i))


(for [i (range 1 6)] (print i))


(pos 3 [:a 1 :b 2 :c 3 :d 4])

(pos 3 {:a 1 :b 2 :c 3 :d 4})

(pos 3 {:a 3 :b 3 :c 3 :d 4})

(defn pos [pred coll]
  (for [[i v] (index coll) :when (pred v)] i))

(pos #{2} {:a 1 :b 2 :c 3 :d 4})

(pos #{2 4} {:a 1 :b 2 :c 3 :d 4})

(index [2 3 6 7])
(pos even? [2 3 6 7])

