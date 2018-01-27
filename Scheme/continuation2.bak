#lang racket

(define (testcc)
  (call/cc
   (lambda (x)
     (x)))
  (display "i")           ;; the once called the continuation all what comes is called
  (display "o"))

(define (testcc1)
  (let ((y 0))
    (display (call/cc
              (lambda (x)  
                (x 2))))         ;; the continuation returns 2 to the display then all what comes is called
             (display "cont")
             (display "i")
             (display "o")))