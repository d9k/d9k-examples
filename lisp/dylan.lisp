(defun compose (&rest fns)
  (destructing-bind (fn1 . rest)(reverse fns)
  #'(lambda (&rest args)
      (reduce #'(lambda (v f)(funcall f v))
        rest
        :initial-value (apply fn1 args)
      )
    )
  )
)
