#lang racket

(define (parent tree node-index)
  (car (vector-ref tree node-index)))

(define (node-name tree node-index)
  (cdr (vector-ref tree node-index)))

(define (find-root tree node-index)
  (let ((p (parent tree node-index)))
    (if p
        (find-root tree p)
        node-index)))

(define (parent-set! tree node-index new-root)
  (vector-set! tree node-index
             (cons new-root
      (node-name tree node-index))))

(define (union! tree node1 node2)
  (unless (eqv? (parent tree node1) (parent tree node2))
      (let ((p1 (find-root tree node1))
            (p2 (find-root tree node2)))
        (parent-set! tree p2 p1))))