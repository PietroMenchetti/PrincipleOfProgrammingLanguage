#lang racket

(define (print+sub x y)
  (display x)
  (display " ")
  (display y)
  (display " -> ")
  (- x y))

(define (puzzle)
  (call/cc (lambda (exit)                                   ;; saves the continuation == nothing
             (define (local e)
               (call/cc                                     ;;saves the continuation == local 6 exit 2
                (lambda (local-exit)
                  (exit (print+sub e                        ;;calls the continuation of the first one 
                                   (call/cc                 ;; saves the continuation == (local 6) (exit 2)
                                    (lambda (new-exit)
                                      (set! exit new-exit)  ;; saves the new continuation in exit
                                      (local-exit #f))))))));; calls the continuation of the second and returns #f
             (local 6)
             (exit 2))))

(define x (puzzle))

;; (local 6)
;; (exit  2)


;;(local-exit #f) jumps to (local 6)(exit 2)

;; (local 6) calls the call/cc wich now is just (exit 2)

;(define (local e)
;               (call/cc                                     ;;saves the continuation == local 6 exit 2
;                (lambda (local-exit)
;                  (exit (print+sub e                        ;;calls the continuation of the first one 
;                                   (call/cc                 ;; saves the continuation == (local 6) (exit 2)
;                                    (lambda (new-exit)
;                                      (set! exit new-exit)  ;; saves the new continuation in exit
;                                      (local-exit #f)))))))

;; now we have (exit (print+sub 6 ())

;;(local-exit #f) jumps to the new continuation : (exit 2)

;; but exit is set to new-exit

;; therefore the continuation jumps to (exit (print+sub 6 2)) returning 2