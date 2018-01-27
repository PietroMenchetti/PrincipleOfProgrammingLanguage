#lang racket

(define-syntax curried
  (syntax-rules ()
    ((_ (x) body ...)
     (lambda(x)
       body ...))
    ((_ (x x1 ...) body ...)
     (lambda (x)
       (curried (x1 ...) body ...)))))