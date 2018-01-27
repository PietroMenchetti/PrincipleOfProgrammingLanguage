#lang racket

(define-syntax chat
  (syntax-rules ()
    ((_ o1 o2 var m1)
    (-> o1 m1 var))
    ((_ o1 o2 var m1 m2 ...)
     (let ((v (-> ob1 m1 var)))
       (chat o2 o1 v m2 ...)))))