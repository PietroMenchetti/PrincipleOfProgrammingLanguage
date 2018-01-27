#lang racket

(define (make-matrix r c fill)
  (let ((mat (make-vector c (make-vector c fill))))
  (let loop ((x 1))
    (if (< x r)
        (begin
          (vector-set!  mat x (make-vector c fill))
          (loop (+ x 1)))
        mat))))

(define (matrix-ref m r c)
  (vector-ref (vector-ref m r) c))

(define (matrix-set! m r c fill)
  (vector-set! (vector-ref m r) c fill))

          