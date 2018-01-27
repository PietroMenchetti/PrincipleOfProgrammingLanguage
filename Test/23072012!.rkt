#lang racket

(define-syntax ->
  (syntax-rules ()
    ((_ object msg arg ...)
     ((hash-ref object 'msg) object arg ...))))

(define-syntax chat
  (syntax-rules ()
    ((_ ob1 ob2 start msg)
     (-> ob1 msg start))
    ((_ ob1 ob2 start m1 m2 ...)
     (let ((v (-> ob1 msg start)))
       (chat ob2 ob1 v m2 ...)))))

(define v (lambda () 1))