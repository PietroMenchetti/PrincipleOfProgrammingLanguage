#lang racket

(define (testcc x) 
  (call/cc
   (lambda (return)
     (oi x return))) ;; the continuation doesn't get evaluated!!!!
  (newline)
  2)

(define (oi x y)
  (display x)
  (display y))