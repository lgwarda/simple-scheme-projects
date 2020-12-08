;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-256) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; [X] [X -> Number] [NEList-of X] -> X 
; finds the (first) item in lx that maximizes f
; if (argmax f (list x-1 ... x-n)) == x-i, 
; then (>= (f x-i) (f x-1)), (>= (f x-i) (f x-2)), ...
(define (argmax2 f lx) 0)

; Use it on concrete examples in ISL.
; Can you articulate an analogous purpose statement
; for argmin?

(argmax + '(1 2 3 4 5))    ;5
(argmax - '(1 2 3 4 5))    ;1
(argmax abs '(1 2 3 4 5))  ;5
(argmax / '(1 2 3 4 5))    ;1

; [X] [X -> Number] [NEList-of X] -> X 
; finds the (first) item in lx that minimizes f
; if (argmax f (list x-1 ... x-n)) == x-i, 
; then (<= (f x-i) (f x-1)), (>= (f x-i) (f x-2)), ...
(define (argmin2 f lx) 0)
(argmin + '(1 2 3 4 5))    ;1 
(argmin - '(1 2 3 4 5))    ;5
(argmin abs '(1 2 3 4 5))  ;1
(argmin / '(1 2 3 4 5))    ;5


