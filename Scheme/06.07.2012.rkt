#lang racket

(define (iter-list l)
  (let ((list l))
    (lambda()
        (if (null? list)
            'end
            (begin
              (let ((c (car list)))
              (set! list (cdr list))
              c))))))


(define (iter-vector vec)
  (let ((curr 0))
    (lambda()
      (if (>= curr (vector-length vec))
          'end
          (begin
            (let ((e (vector-ref vec curr)))
            (set! curr (+ curr 1))
            e))))))

(define (iter-for block data iter)
  (let ((iterandum (iter data)))
    (let loop ((x (iterandum)))
      (when (not (eq? x '<<end>>))
          (begin
            (block x)
            (loop (iterandum)))))))

(define (iter-dispatch data)
  (cond ((vector? data) iter-vector)
        ((list? data) iter-list)
        (else (error #f "Unknown type" data))))

(define-syntax for
  (syntax-rules (in)
   ((_ var in data expr ...)
  (iter-for (lambda (var) expr ...)
           data (iter-dispatch data)))))
         
         
