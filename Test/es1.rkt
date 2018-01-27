#lang racket

;;Riccardo Tommasini repo

(define (foo x)(+ x 1))

(define (hello-world)(display " Hello Wolrd! ")) ; inline comment

(define (factorial n )
  (if(= n 0)
     1
     (* n (factorial (- n 1)))))

(= 0 2)  ;; only for number

(eq? 0 1) ;; chechs the pointer in memory

;; write a function that reverses a pair

;;(filter <predicate> l) return a sublist of l

(define (rev-pair p)
  (let ((x (car p))
        (y (cdr p)))
  (cons y x)))

(define (pal s)
  (let* ((l (string->list s))
         (reverse (reverse l)))
    (equal? l reverse)))

;; write a function that returns the sum of squares of a list

(define (fun l)
  (if (null? l)
  0
  (+ (*(car l) (car l))(fun (cdr l)))))

(define (sos l)
  (define (rec-sos l acc)
    (if (null? l)
      acc
      (rec-sos (cdr l) (+ acc (*(car l)(car l))))))
  (rec-sos l 0))
        

;; Range function that provided lo and hi  provides the range 

;; Tail recursive
(define (range lo hi)
  (define (rec lo hi acc)
  (if (>= lo hi)
      acc
      (rec (+ lo 1) hi (cons lo acc))))
  (rec lo hi '()))

(define (range-let lo hi)
  (let loop ((l lo)
             (acc '()))
    (if (>= lo hi)
        acc
        (loop (+ l 1) (append acc (list l))))))

;; Define a function that flattens lists
;; e.g '(1 2) -> '(1 2)
;;     '(1 '(1) 2) -> '(1 1 2)

;;quicksort
(define (qs x . xs)
    (if (null? xs)
        x
        (let* ((pivot x)
               (smaller (filter (lambda (x) (< x pivot)) xs))
               (bigger (filter (lambda (x) (> x pivot)) xs)))
          (cons (apply qs smaller) (list x) (apply qs bigger)))))

;; function that packs elements
(define (pack l)
  (define (rec l sub acc)
    (cond ((null? l) (cons sub acc))
          ((null? sub)(rec (cdr l) (cons (car l) sub) acc))
          ((equal? (car l) (car sub))(rec (cdr l) (cons (car l) sub) acc))
          (else (rec (cdr l)(list (car l))(cons sub acc)))))
  (rec l '() '()))
      
    