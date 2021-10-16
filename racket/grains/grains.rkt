#lang racket

(provide square total)

(define (square n)
    (square-internal (- n 1)))

;; Use 0-indexes for squares internally
(define (square-internal n)
    (expt 2 n))

(define (total)
    (sum (squares 64)))

(define (squares n)
    (build-list n square-internal))

(define (sum lst) 
    (apply + lst))

