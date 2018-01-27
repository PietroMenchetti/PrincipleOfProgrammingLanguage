#lang racket

(define (multiple-apply fun n x)
  (let loop ((cont 1)
             (acc (fun x)))
    (if (< cont n)
        (loop (+ cont 1) (fun acc))
        acc)))


(define (position-of-max l)
  (let loop ((pos 0)
             (max (car l))
             (i 1)
             (li l))
    (if (< i (length l))
        (begin
          (when (> (car (cdr li)) max)
              (begin
                (set! max (car (cdr li)))
                (set! pos i)))
          (loop pos max (+ i 1) (cdr li)))
        pos)))

(define (norm x)
  (cond ((string? x) (string-length x))
        (else x)))

(define (norm-list l)
   (let loop ((Max 0)
             (i 0)
             (li l))
    (if (< i (length l))
        (begin
          (when (> (norm (car li)) Max)
            (set! Max (car li)))
          (loop Max (+ i 1) (cdr li)))
        Max)))

(define (max-of-the L)
  (apply max                    ;; apply ritorna il max nella lista ritornata
         (map norm-list L)))    ;; map restituisce una lista 
    
        
        