#lang racket

(struct Dnode
  ((prev #:mutable) (next #:mutable) (content #:mutable)))

(define (create-DList n fill)
  (let* ((head (Dnode 'Nil 'Nil fill))
        (son head))
  (let loop ((x 0))
    (if (< x n)
        (begin
          (set-Dnode-next!  son (Dnode son 'Nil fill))
          (set son (Dnode-next son))
          (loop (+ x 1)))
        head))))

(define (car-Dlist d)
  (if (Dnode? d)
      (Dnode-content d)
      'err))

(define (cdr-Dlist d)
  (if (Dnode? d)
      (begin
        (let ((l (car-Dlist d)))
          (let loop (( i (Dnode-next d)))
            (if (not (eq? i 'Nil))
                (begin
                  (display (car-Dlist i))
                  (loop (Dnode-next i)))
                l))))
  'err))

              
    