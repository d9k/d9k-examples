;; p.185
(load-file "./instarepl-ch9-prototype.clj")

;; TODO fix namespace
(ns joy.mmethods
  (:refer-clojure :exclude [get]))
(use '[joy.udp :only [beget, put, get]])

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
(defmethod home ::unix [m] (get m :home))
(home unix)
;; (home osx) ;;Exception is ok
(derive ::osx ::unix)
(home osx)
(parents ::osx)
(ancestors ::osx)
(descendants ::unix)
(isa? ::osx ::unix)
(isa? ::osx ::osx)
(isa? ::unix ::osx)
(derive ::osx ::bsd)
(defmethod home ::bsd [m] "/home")

;; (home osx) ;; Multiple methods error is ok
(parents ::osx)
(descendants ::unix)
(descendants ::bsd)
(prefer-method home ::unix ::bsd)

(home osx)

(remove-method home ::bsd)
(home osx)

(derive (make-hierarchy) ::osx ::unix)

;; juxt incut BEGIN
    (def each-math (juxt + * - /))
    (each-math 15 3)
    ((juxt :a :b) {:a 1, :b 2, :c 3, :d 4})
    ((juxt first count) "Clojure Rocks")

    ((juxt + * min max) 3 4 6)
;; END incut juxt

(defmulti compile-cmd (juxt :os compiler))

((juxt :os compiler) unix)
((juxt :os compiler) osx)

(compile-cmd unix)


(defmethod compile-cmd [::osx "gcc"] [m]
  (str "/usr/bin/" (get m :c-compiler)))

(defmethod compile-cmd :default [m]
  (str "Unsure where to locate " (get m :c-compiler)))

(compile-cmd osx)

(compile-cmd unix)

(type unix)


