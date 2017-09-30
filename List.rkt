#lang racket

(define (foo x)(+ x 1))

((lambda (x)(+ x 1) )2)        ;;gives the result without call it (lambda functions don't have to be called)

(define (x  y) y)              ;;the result is the parameter(just one variable) passed

(define (z . y) y)             ;;the result is the parameter passed(any number of variables)

(cons 1 '(2))                  ;;i think cons has just one parameter so to link a pair ,2 must not be evaluated

(cons 1 2)

(car '(1 2))

(cdr '(1 2 3 4 5))

(define (call l)      ;; ma una versione senza una lista finita ma con un numero di variabili aribitrarie????
  (let ((x (car l))
        (y (cdr l)))
    (display x)
    (if(not(null? y))
       (call y)
       'end)))
       
(define (show v)
  (let ((max (vector-length v)))
   (let while ((x 0))
    (when (< x max)
      (display (vector-ref v x))
      (newline)
      (while (+ x 1))))))

( define ( vector-for-each body vect )
   (let (( max (- ( vector-length vect ) 1)))
     (let loop (( i 0))
       ( body ( vector-ref vect i )) ; vect [i] in C
       ( when ( < i max )
( loop (+ i 1))))))


