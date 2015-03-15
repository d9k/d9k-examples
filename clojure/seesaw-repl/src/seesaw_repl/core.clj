(ns seesaw-repl.core)
(use 'clojure.repl)
(use 'seesaw.core)
(import [javax.swing UIManager])


(defn -main [& args]

  ;(UIManager/setLookAndFeel "com.sun.java.swing.plaf.gtk.GTKLookAndFeel")
  (def f (frame :title "Get to know Seesaw"))
  (-> f pack! show!)
  (defn display [content]
    (config! :content content
             content)
    )
  (def b (button :text "Click Me"))
  (def lb (listbox :model (-> 'seesaw.core ns-publics keys sort)))
  (display (scrollable lb))
  
)
  