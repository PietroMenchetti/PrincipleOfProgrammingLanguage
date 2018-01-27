#lang racket

(define (vecstrings V strls)
  (let ((top (- (vector-length V) 1)))
    (for-each (lambda (s)
                (let ((sl (string-length s)))
                  (when (<= sl top)
                    (vector-set! V sl
                                 (let ((old (vector-ref V sl)))
                                   (cond
                                     ((string? old) (list s old))
                                     ((list? old) (cons s old))
                                     (else s)))))))
              strls)
    V))

(define (make-vecstring v)
  (let ((top (- (vector-length v) 1)))
  (lambda(x)
    (if (eq? x 'return)
        v
        (begin
        (let ((sl (string-length x)))
                  (when (<= sl top)
                    (vector-set! v sl
                                 (let ((old (vector-ref v sl)))
                                   (cond
                                     ((string? old) (list x old))
                                     ((list? old) (cons x old))
                                     (else x)))))))))))

(list 1 2)

(cons 1 '(2))
                  
            