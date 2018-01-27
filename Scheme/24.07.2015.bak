#lang racket

(define (urmax list)
  (define (rec-urmax list max)
    (let ((x (car list))
          (xs (cdr list)))
      (if (null? xs)
          max
          (begin
            (if (>= (car (reverse x)) max)
                (rec-urmax (cdr list) (car (reverse x)))
                (rec-urmax (cdr list) max))))))
  (rec-urmax list 0))

(define (urmax2 list)
  (apply max (map car (map reverse list))))
                  
             