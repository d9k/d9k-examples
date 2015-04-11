(require 'cljs.closure)

(cljs.closure/build "src"
    {:main 'hello-world.core
     :output-to "out/main.js"
     :optimizations :advanced})

(System/exit 0) ;;Google Closure Compiler creates a thread pool that isn't shutdown
