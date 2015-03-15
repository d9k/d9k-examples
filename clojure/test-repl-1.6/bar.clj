#!/usr/bin/env lein-exec

(require 'leiningen.exec)

;; Add a dependency to the classpath on the fly
(leiningen.exec/deps '[[enlive/enlive "1.1.4"]])

(require '[net.cgrand.enlive-html :as html])

;; Grab and print the title element from the Google front page using Enlive
;; (println (html/select (html/html-resource (java.net.URL. "http://google.com")) [:title]))

(def url "http://yandex.ru")

(println (html/select (html/html-resource (java.net.URL. url)) [:title]))

(time (Thread/sleep 16000))