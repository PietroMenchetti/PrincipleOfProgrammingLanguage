#lang racket

(struct leaf
  ((content #:mutable)))

(struct branch leaf
  (left right))

(define (tmap! f btree)
  (if(leaf? btree)
     (set-leaf-content! btree (f (leaf-content btree)))
     (begin
       (tmap! f (branch-left btree))
       (tmap! f (branch-right btree)))))

(define (fringe btree)
  (define (rec-fringe btree fringe)
    (if (leaf? btree)
        (cons (leaf-content btree) fringe)
        (cons (rec-fringe (branch-left btree)  fringe) (rec-fringe (branch-right btree) fringe))))
  (rec-fringe btree '()))
          

(define (reverse! btree)
  (define (rec-reverse! btree f)
      (if (null? f)
          btree
          (begin
            (if (leaf? btree)
                (begin
                  (set-leaf-content! btree (car f))
                  (cdr f))
              (rec-reverse! (branch-right btree )(rec-reverse! (branch-left btree) f))))))
  (rec-reverse! btree (fringe btree)))
          