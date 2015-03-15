(ns fs-repl.core)

(defn foo
  "I don't do a whole lot."
  [x]
  (println x "Hello, World!"))

(defn -main [& args]

  )

(defn -main-no-run [& args]
  (println "asdf")
  (foo 4))

(-main-no-run)
