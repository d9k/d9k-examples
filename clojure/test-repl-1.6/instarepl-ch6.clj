; p.110 Designing a persistent toy

(def baselist (list :barnabas :adam))

(def lst1 (cons :willie baselist))

(def lst2 (cons :phoenix baselist))

(= (next lst1) (next lst2))

; same intance
(identical? (next lst1) (next lst2))


{:val 5, :L nil, :R nil}


; function for tree building:

(defn treeconj [t v]
  (cond

     (nil? t)        {:val v, :L nil, :R nil}

     (< v (:val t))  {:val (:val t),
                      :L (treeconj (:L t) v),
                      :R (:R t)
                      }

    :else            {:val (:val t),
                      :L (:L t),
                      :R (treeconj (:R t) v)
                      }
  )
)

(defn treeseq [t]
  (when t
    (concat (treeseq (:L t))  [(:val t)] (treeseq (:R t)) )))

(def tree1 (treeconj nil 5))

(def tree1 (treeconj tree1 3))

(def tree1 (treeconj tree1 2))

(treeseq tree1)

(def tree2 (treeconj tree1 7))

(treeseq tree2)

(identical? (:L tree1) (:L tree2))


; laziness p. 114

(defn and-chain [x y z]
  (and x y z (do (println "Made it!") :all-truthy)))

(and-chain {} 42 true)

(and-chain true false true)

(+ 1 43)

(defn rec-step [[x & xs]]
  (if x
    [x (rec-step xs)]
    []))

; (steps [1 2 3 4])

(rec-step [1 2 3 4])

(def very-lazy (-> (iterate #(do (print \.) (inc %)) 1)
                   rest rest rest))


(def less-lazy (-> (iterate #(do (print \.) (inc %)) 1)
                   next next next))

(println (first very-lazy))
; in output: .4

(println (first less-lazy))
; in output: 4

(defn lz-rec-step [s]
  (lazy-seq
   (if (seq s)
     [(first s) (lz-rec-step (rest s))]
     [])))

(lz-rec-step [1 2 3 4])

(class (lz-rec-step [1 2 3 4]))

(dorun (map #(println "hi" %) ["mum" "dad" "sister"]))
; in output:
; hi mum
; hi dad
; hi siste

(defn simple-range [i limit]
  (lazy-seq
   (when (< i limit)
     (cons i (simple-range (inc i) limit)))))


; very long run
;(iterate (fn [n] (/ n 2)) 1)


(defn triangle [n]
  (/ (* n (+ n 1)) 2))

(triangle 10)

(def tri-nums (map triangle (iterate inc 1)))

(take 10 tri-nums)

(take 10 (filter even? tri-nums))

(/ 5)

(take 10 (map / tri-nums))

(double (reduce + (take 1000 (map / tri-nums))))

(take 2 (drop-while #(< % 10000) tri-nums))


; delay and force p. 119

(defn deger-expensive [cheap expensive]
  (if-let [good-enough (force cheap)]
    good-enough
    (force expensive)))



;(defer expensive (delay :cheap)
;                 (delay (do (Thread/sleep 5000) :expensive)))

;- must return :cheap

;(defer expensive (delay false)
;                 (delay (do (Thread/sleep 5000) :expensive)))

;- must return :expensive

; delay? - check for delayed computation


(if :truthy-thing
  (let [res :truthy-thing] res ))

;the same as

(if-let [res :truthy-thing] res)

(defn inf-triangles [n]
  {:head (triangle n)
   :tail (delay (inf-triangles (inc n)))})


(defn head [l] (:head l))

(defn tail [l] (force (:tail l)))

(def tri-nums (inf-triangles 1))

(head tri-nums)

(head (tail tri-nums))

(head (tail(tail tri-nums)))


; I DON'T understand how it works
(defn taker [n l]
  (loop [t n, src l, ret []]
    (if (zero? t)
      ret
      (recur (dec t) (tail src) (conj ret (head src))))))

(defn nthr [l n]
  (if (zero? n)
    (head l)
    (recur (tail l) (dec n))))

(taker 10 tri-nums)

(nthr tri-nums 99)

; lazy quicksort p.121

;(ns joy.q)

(defn nom [n] (take n (repeatedly #(rand-int n))))

; TODO understand how it works

(defn sort-parts
  "Lazy, tail-recursive, incremental quicksort. Works against
   and creates partitions based on the pivot, defined as 'work'."
  [work]
  (lazy-seq
   (loop [[part & parts] work]
     (if-let [[pivot & xs] (seq part)]
       (let [smaller? #(< % pivot)]
         (recur (list*
                 (filter smaller? xs)
                 pivot
                 (remove smaller? xs)
                 parts)))
       (when-let [[x & parts] parts]
         (cons x (sort-parts parts)))))))

(defn qsort [xs]
  (sort-parts (list xs)))

(qsort [2 1 4 3])

(nom 20)

(qsort (nom 20))
