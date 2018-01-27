#lang racket

(define (ftree treef tree)
  (cond
    ((null? treef) tree)
    ((list? treef) (cons (ftree (car treef)(car tree))
                         (ftree (cdr treef)(cdr tree))))
    (else ; should be atoms
     (treef tree))))

  