;; @see http://clojuredocs.org/clojure.core/partial#example-542692cdc026201cdc326ceb

(def to-english (partial clojure.pprint/cl-format nil "~@(~@[~R~]~^ ~A.~)"))
(to-english 1234)
(to-english -5)
