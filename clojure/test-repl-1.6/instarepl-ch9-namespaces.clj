(in-ns 'joy.ns)
(def authors ["Chouser"])

joy.ns/authors

(in-ns 'joy.ns)
(clojure.core/refer 'joy.ns)
joy.ns/authors

(in-ns 'joy.ns)
(def authors ["Chouser", "Fogus"])

(in-ns 'your.ns)
joy.ns/authors

(ns chimp)
(reduce + [1 2 (Integer. 3)])

(in-ns 'gibbon)
;;(reduce + [1 2 (Integer. 3)]) ;;Must be Exception

(clojure.core/refer 'clojure.core)

(reduce + [1 2 (Integer. 3)])

(def b (create-ns 'bonobo))
b

((ns-map b) 'String)

(intern b 'x 9)
bonobo/x

(intern b 'reduce clojure.core/reduce)

(intern b '+ clojure.core/+)

(bonobo/reduce bonobo/+ [1 2 3 4 5])

*ns*
(in-ns 'bonobo)
(reduce + [1 2 3 4 5])

(in-ns 'user)

(get (ns-map 'bonobo) 'reduce)
(ns-unmap 'bonobo 'reduce)
(get (ns-map 'bonobo) 'reduce)

(remove-ns 'bonobo)
(ns-interns 'gibbon)
;;(ns-map 'gibbon)
(map #(ns-unmap 'gibbon %)(keys (ns-interns 'gibbon)))
(ns-interns 'gibbon)
(remove-ns 'gibbon)
;;(ns-interns 'gibbon) ;;exception is planned

(all-ns)

(ns hider.ns)

(defn ^{:private true} answer [] 42)

(ns seeker.ns
  (:refer hider.ns))

(answer)


