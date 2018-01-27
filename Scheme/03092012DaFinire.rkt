#lang racket

(define (numnodes l)
  (define (numnodes-rec l cont)
   ; (null? l)
    ;    cont
        (if (list? (car l))
            (numnodes-rec (car l) cont)
            (begin
            (set! cont (+ cont 1))
            (if(null? (car (car l)))
                      cont
            (numnodes-rec (cdr l) cont)))))
    (numnodes-rec l 0))

(define (co l)
  (if (not (list? l)) 1
      (+ 1 (apply + (map co (cdr l))))))

(apply + '(1 2 3 )) ;;restituisce un numero che è la somma di tutti i numeri della lista

(map (lambda(x) (+ x 1)) '(1 2 3 )) ;;restituisce una lista !

        