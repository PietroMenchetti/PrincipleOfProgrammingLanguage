#lang racket

(define (iter-vector vec)
  (let ((curr 0)
        (top (vector-length vec)))
    (lambda ()
      (if (= curr top)
          '<end>
          (let ((v (vector-ref vec curr)))
            (set! curr (+ curr 1))
            v)))))

(define (list-itr list)
  (let ((curr 0)
        (len (length list))
        (x list))
    (lambda ()
      (if (= curr len)
          '<end>
          (let ((v (car x)))
            (set! curr (+ curr 1))
            (set! x (cdr x))
            v)))))

(define (iter-for block data itr)
  (let ((iterandum (itr data)))
    (let loop ((x (iterandum)))
      (if (not (eq? x '<end>))
          (begin
            (block x)
            (loop (iterandum)))
          'end!))))
          

               
(define (iter-dispatcher data)
  (cond ((vector? data) iter-vector)
        ((list? data) list-itr)
        (else  "Unknown type" )))
  
(define-syntax for
  (syntax-rules (in)
      ((_ var in data expr ...)
       (iter-for( lambda(var)expr ...)
                data (iter-dispatcher data)))))