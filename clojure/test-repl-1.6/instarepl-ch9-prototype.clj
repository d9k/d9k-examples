;; p.184 Joy of Clojure

(ns joy.udp
  (:refer-clojure :exclude [get]))

(defn beget [obj proto] (assoc obj ::prototype proto))

;; beget - порождать
(beget {:sub 0} {:super 1})

(def put assoc)

(defn get [m k]
  (when m
    (if-let [[_ v] (find m k)]
      v
      (recur (::prototype m) k))))

(def a (beget {:sub 0} {:super 1}))

a


(beget {:sub 0} {:super 1})

(get (beget {:sub 0} {:super 1})
    :super)

;; Usage

(def cat {:likes-dogs true, :ocd-bathing true})
(def morris (beget {:likes-9lives true} cat))
morris
(def post-traumatic-morris (beget {:likes-dogs nil} morris))
post-traumatic-morris

(get cat :likes-dogs)
(get morris :likes-dogs)
(get post-traumatic-morris :likes-dogs)





