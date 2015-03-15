#!/usr/bin/sbcl --script
;; (loop
;;      (let ((a (read)))
;;        (when (= a 42) (return))
;;        (princ (format nil "~D~%" a))))

(loop for l = (read-line)		
      for n = (parse-integer l)
      until (= n 42) do (format t "~D~%" n))

;; (do
;;   ((x (read-line) (read-line)))
;;   ((string= x "42"))
;;   (format t "~a~&" x)
;; )


