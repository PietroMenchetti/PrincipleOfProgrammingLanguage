#lang racket

(define (left f i L)    ;; f is a function with 2 parameters
  (if(null? L)
     i
     (left (f i (car L))
           (cdr L))))

(define (right f i L)
  (if(null? L)
     i
     (f (car L) (right f i (cdr L )))))