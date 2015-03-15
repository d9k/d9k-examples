#!/usr/bin/env lein-exec
(println "1 + 2 =" (+ 1 2))
(println (if (not-empty *command-line-args*) "I run from command line" "I run from REPL"))