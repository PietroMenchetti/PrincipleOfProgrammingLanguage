#lang racket

(define (minimum l)
  (let((x (car l))
       (xs (cdr l)))
    (if(null? xs)
       x
       (if (< x (car xs)) (minimum (cons x (cdr xs)))(minimum (cons (car xs)(cdr xs)))))))

(define (var-min x . xs)
  (if (null? xs)
      x
      (if (< x (car xs)) (apply var-min (cons x (cdr xs))) (apply var-min (cons (car xs)(cdr xs))))))

(define (min-loop v)
  (let ((max (- (vector-length v) 1))
        (min (vector-ref v 0)))
  (let loop ((x 0))
    (if (> x max)
        min
        (if (< (vector-ref v x) min)(begin
                                 (set! min (vector-ref v x))
                                     (loop(+ x 1)))
            (loop(+ x 1)))))))

(define (rec-fact n)
  (define (rec n acc)
    (if (= n 0)
        acc
        (rec (- n 1) (* acc n))))
  (rec n 1))

(struct location(
                 name
                 (position #:mutable)
                 ))
(define (showL l)
  (location-name l))

(define home(location "home" 22))

(define (make-addern n)
  (lambda (x)(+ x n)))

(define (vector-itr v)
  (let ((curr 0)
    (top (vector-length v)))
    (lambda ()(if (= curr top)
                  '<fine>
                  (let ((v (vector-ref v curr)))
                    (set! curr (+ curr 1))
                    v)))))

(filter (lambda (x)(= (modulo x 2) 0)) '(1 2 2 3 1 2 6 4))

(define (test f x)(f x))  ;; definisco una funzione che prende in input una funzione

;; example of implementation of foldl foldr

(define (foldl f l i)
  (if (null? l)
      i
      (foldl f (cdr l) (f i (car l)))))

(define (foldr f l i)
  (if (null? l)
      i
      (f (foldr f (cdr l) i)(car l))))


(define-syntax while
  (syntax-rules () ;
    ((_ condition body ...)
     (let loop ()
       (when condition
         (begin
           body ...
           (loop)))))))

(define (a x)
  (let ((curr 0))
    (while (< curr 10)
           (set! x (+ x 1))
           (set! curr (+ curr 1)))
    x))