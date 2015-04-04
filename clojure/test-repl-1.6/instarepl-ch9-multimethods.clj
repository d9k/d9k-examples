;; p.185
(load-file "./instarepl-ch9-prototype.clj")
(ns joy.udp)

(defmulti compiler :os)
(defmethod compiler ::unix [m] (get m :c-compiler))
(defmethod compiler ::osx [m] (get m :c-compiler))

(def clone (partial beget {}))
(def unix {:os ::unix, :c-compiler "cc", :home "/home", :dev "/dev"})
(def osx (-> (clone unix)
             (put :os ::osx)
             (put :c-compiler "gcc")
             (put :home "/Users")))
(compiler unix)
(compiler osx)

(defmulti home :os)
