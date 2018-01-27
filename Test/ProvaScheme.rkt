#lang racket

(let ((x 1))
     (let ((y 1))
  (display (cons x y))
       (newline)))

(let ((x 1)
      (y 1))
  (display (cons x y))
  (newline))   

(let ((x 1))
  (let ((x 2))
      (display x)(newline))
  (display x)
  (newline))

(let ((x 2) (y 3))
  (let* ((x 7)             ;;let* binds sequentially from left to right and the region of a binding is that part of the let* expression to the right of the bindings
         (z (+ x y)))
    (* z x)))

(let ((x 2) (y 3))
  (let ((x 7)
         (z (+ x y)))
    (* z x)))