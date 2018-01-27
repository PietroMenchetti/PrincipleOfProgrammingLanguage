#lang racket

(define (make-matrix r c fill)
  (make-vector c (make-vector r fill)))

(define (matrix-set! m r c data)
  (vector-set!(vector-ref m r) c data))

(define (matrix-ref m r c)
  (vector-ref (vector-ref m r) c))