#lang racket

(define (puzzle)
  (call/cc (lambda (x)
             (call/cc (lambda (y)
                        (y)))
             (display "asd")
  (display "ciao"))))