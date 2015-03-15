; http://www.niclas-meier.de/2012/04/first-hundred-days-of-clojure/

(for [i (range 1 100) :let [f (format "%03d" i)] :when (odd? i)] f)
