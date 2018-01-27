#lang racket



(define (numnodes data)
  (if (not (list? data))
      1
      (+ 1 (apply + (map numnodes (cdr data))))))


(define (itr-numnodes data)
  (let loop ((len (length data))
             (counter 0)
             (x data))
    (if (null? x)
        counter
        (begin
          (if (list? x)
              (loop len (+ 1 counter) (cdr data))
              (+ 1 (itr-numnodes (cdr data)))
              )))))
              

 

