;; ch. 9.3.1 records p. 189
;; binary tree
(defrecord TreeNode [val l r])
;; creates a new Java class with a constructor than takes value for each of the fields listed

(def node1 (TreeNode. 5 nil nil))
node1
;; auto generated func:
(map->TreeNode {:val 6, :l nil, :r nil})
(into node1 {:val 2})

(into {} node1)
(bean node1)
(type TreeNode)

;; incut import BEGIN

;; Loading a namespace via :require or :use won’t be enough to import defrecord
;; and deftype classes.
;; (ns my-cool-ns
;;  (:import joy.udp.TreeNode))

;; END import incut

(defn xconj
  "add to tree"
  [t v]
  (cond
   (nil? t)       (TreeNode. v nil nil)
   (< v (:val t)) (TreeNode. (:val t) (xconj (:l t) v) (:r t))
   :else          (TreeNode. (:val t) (:l t) (xconj (:r t) v))))

(defn xseq
  "convert trees to seqs"
  [t]
  (when t
    (concat (xseq (:l t)) [(:val t)] (xseq (:r t)))))

(def sample-tree (reduce xconj nil [3 5 2 4 6]))
sample-tree


(dissoc {:a 5 :z 4 } :a)

;; ch. 9.3.2 Protocols

;; like java interfaces
(defprotocol FIXO
  (fixo-push [fixo value])
  (fixo-pop [fixo])
  (fixo-peek [fixo]))

(bean FIXO)
(type FIXO)

(extend-type TreeNode
  FIXO
  (fixo-push [node value]
      (xconj node value)))

(xseq (fixo-push sample-tree 5/2))

(extend-ty
 [:browser.url-bar "esc" :browser.focus-content]
 [:browser.url-bar "enter" pe clojure.lang.IPersistentVector
  FIXO
  (fixo-push [vector value]
      (conj vector value))

(fixo-push [2 3 4 5 6] 5/2)


(use 'clojure.string)

(defprotocol StringOps
  (rev [s])
  (upp [s])
)

(extend-type String
  StringOps
  (rev [s] (clojure.string/reverse s)))

(rev "Works")

(extend-type String
  StringOps
  (upp [s] (clojure.string/upper-case s)))

(upp "Works")

;; (rev "Works?") ;;causes error;; (rev ..) definition lost

;; p.194 mixins
(def rev-mixin {:rev clojure.string/reverse})
(def upp-mixin {:upp (fn [this] (.toUpperCase this))})
(def fully-mixed (merge upp-mixin rev-mixin))
(extend String StringOps fully-mixed)

(-> "Works" upp rev)

