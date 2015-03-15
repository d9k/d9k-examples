; http://www.4clojure.com/problem/6

(list :a :b :c)

(type (list :a :b :c))

(type '(:a :b :c))

(vec '(:a :b :c))

(type (vec '(:a :b :c)))

(vector :a :b :c)

(vector '(:a :b :c))

; удивительно, но это так. наверное, сравнение идёт по значениям

(= [:a :b :c] (list :a :b :c) (vec '(:a :b :c)) (vector :a :b :c))

; Vectors: conj
; http://www.4clojure.com/problem/7

(conj '(2 3 4) 1)

(conj '(3 4) 2 1)

(conj [1 2 3] 4)

(conj [1 2] 3 4)

; Intro to Sets
; http://www.4clojure.com/problem/8

(set '(:a :a :b :c :c :c :c :d :d))

(clojure.set/union #{:a :b :c} #{:b :c :d})

; Sets: conj
; http://www.4clojure.com/problem/9

(conj #{1 4 3} 2)

; Intro to Maps
; http://www.4clojure.com/problem/10

(= {:a 10, :b 20, :c 30} (hash-map :a 10, :b 20, :c 30))

({:a 10, :b 20, :c 30} :b)

(:b {:a 10, :b 20, :c 30})

; Maps: conj
; http://www.4clojure.com/problem/11

(conj {:a 1} [:b 2] [:c 3])

; Intro to Sequences
; http://www.4clojure.com/problem/12
