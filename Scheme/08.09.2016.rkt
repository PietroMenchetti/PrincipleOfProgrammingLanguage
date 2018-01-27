#lang racket


(define (genFig n)
  (let loop ((x 0)
             (rst '()))
    (if (eq? x n)
        (reverse rst)
        (begin
          (set! rst (cons (put1 x n) rst))
          (loop (+ x 1) rst)))))



(define (put1 at dim)
  (let loop ((x 0)
             (acc '()))
    (if (eq? x dim)
        acc
        (begin
          (if (eq? x at)
              (begin
              (set! acc (append acc '(1)))
              (loop (+ x 1) acc))
              (begin
              (set! acc (append acc '(0)))
              (loop (+ x 1) acc)))))))
      