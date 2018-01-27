#lang racket

(define (producer ag1 ag2)
  (let loop ((i 1))
    (if (< i 10)
        (begin
          ((if (odd? i) ag1 ag2) i)   ;; arg1 1, ag2 2, arg1 3, arg2 4 ... arg1 9
          (loop (+ i 1)))
        (cons                         ;; (arg2 'end) : (arg1 'end)
         (ag2 'end)
         (ag1 'end)))))


;; ’(20 9 7 5 3 1) 20 = 2 + 4 + 6 + 8

(define c2
  (let  ((acc 0))
    (lambda (i)
    (if (equal? i 'end)
        acc
        (set! acc (+ acc i))))))

(define c1
  (let ((acc '()))
    (lambda (i)
    (if (equal? i 'end)
        acc
        (set! acc (cons acc i))))))

(define-syntax multiple-apply
  (syntax-rules (to)
    (( _ (f1) to body)
     (apply f1 body))
    (( _ (f1 f2 ...) to body1 body2 ...)
     (cons (apply f1 body1) (multiple-apply (f2 ...) to body2 ...)))))