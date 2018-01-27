#lang racket

(struct sentinel(
    (next #:mutable)))

(struct cnode(
   (next #:mutable)
   (data #:mutable)
   ))

(define (Clist c1)
  (let ((s (empty-clist)))
  (begin
  (set-cnode-next! c1 s)
  (set-sentinel-next! s c1)
  c1)))

(define (empty-clist)
  (sentinel null))

(define (ConsSentinelHead c1 c2)
  (begin
    (if (sentinel? c1)
        (set-sentinel-next! c1 c2)
        (ConsSentinelHead (cnode-next c1) c2))))

(define (ConsHeadSentinel c1 c2)
  (begin
    (if (sentinel? c2)
        (set-sentinel-next! c2 c1)
        (ConsHeadSentinel c1 (cnode-next c2)))))

(define (ConsClists c1 c2)
  (ConsSentinelHead c1 c2)
  (ConsHeadSentinel c1 c2))

(define (cmap f c)
  (when (not (sentinel? c))
      (begin
      (set-cnode-data! c (f (cnode-data c)))
      (cmap f (cnode-next c)))))

(define (cshow c)
  (if (sentinel? c)
      'end
      (begin
        (displayln (cnode-data c))
        (cshow (cnode-next c)))))
      