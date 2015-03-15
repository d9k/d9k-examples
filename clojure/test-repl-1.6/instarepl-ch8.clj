(-> 25 Math/sqrt int list)

(eval '(list 1 2))

(eval (list (symbol "+") 1 2))

(defn contextual-eval [ctx expr]
  (eval
   `(let [~@(mapcat (fn [[k v]] [k `'~v] ctx))]
      ~expr)))

