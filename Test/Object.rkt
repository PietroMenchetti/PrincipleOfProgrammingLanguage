#lang racket

(define (make-ob)
  (let (( var 0))

    (define (my-add x)
      (set! var (+ x var)))
    (define (display-var)
      (display var))
    (lambda ( message . args )
           (apply (case message
                    ((my-add) my-add)
                    ((display-var) display-var))
                    args))))