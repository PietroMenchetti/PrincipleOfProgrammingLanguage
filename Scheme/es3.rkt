#lang racket

(define-syntax when
  (syntax-rules ()
    ((when condition head . body) ;; ... matches the same pattern of the last arg, (.) a variable number of parameters 
     (if condition (begin head . body) #f)))) ;; putting head i force when to have at least one instr for the body

(define (answer? x)
  (= x 42))

(when (answer? 42)
  (newline)
  (display "Not answer"))

;; condition = answer? 42
;; body = (newline) (display ..)

(define-syntax mtoa
  (syntax-rules ()
    ((mtoa fun arg)(if))))

(newline)
( 1 . < . 2)

(define-syntax repeat
  (syntax-rules (until)
    ((_ body ... until cond)      ;;repeate the body pattern 
     (let loop()
       (begin
         body ...
         (unless cond                ;;unless has no else
           (loop)))))))
(let ((x 5))
  (repeat
   (display x)
   (newline)
   (set! x (- x 1 ))
   until (zero? x)))

(define-syntax ouror
  (syntax-rules ()
    ((_) #f)
    ((_ e1 e2 ...)
     (cond (e1 #t)
           (else (ouror e2 ...))))))

(define *queue* '())

(define (empty-queue?)
  (null? *queue*))

(define (enqueue x)
  (set! *queue* (append *queue* (list x))))

(define (dequeue)
  (let ((x (car *queue*)))
  (set! *queue* (cdr *queue*))
    x))

(define (fork proc)
  (call/cc
   (lambda (x)
     (enqueue x)
     (proc))))

(define (yield)
  (call/cc
   (lambda(x)
     (enqueue x)
     ((dequeue)))))

(define (cexit x)
  (if (empty-queue?)
      (exit)
      (begin
        (displayln x)
        ((dequeue)))))

(define (do-stuff str max)
  (let loop ((n 0))
    (display str)
    (display n)
    (newline)
    (yield)
    (if (< n max)
        (loop (+ n 1))
        (cexit "do-stuff"))))

(define (main)
  (begin
  (fork (do-stuff "this is A" 3))
  (fork (do-stuff "this is B " 4))
  (display "END")
  (cexit "Main")))