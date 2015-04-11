(require 'cljs.closure)

(cljs.closure/build "src"
    {:main 'hello-world.core
     :output-to "main.js"
     :target :nodejs})
