;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-240) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct layer [stuff])

; An LStr is one of: 
; – String
; – (make-layer LStr)
(define LSTR0 "expample #1")
(define LSTR1  (make-layer  "expample #2"))
(define LSTR2 (make-layer LSTR0))

; An LNum is one of: 
; – Number
; – (make-layer LNum)
(define LNUM0 9)
(define LNUM1 (make-layer 8))
(define LNUM2 (make-layer LNUM0))

; A LItm is one of:
; - ITEM
; - (make-layer LItm)
(define LI0 "hello")
(define LI1 (make-layer 12))
(define LI2 (make-layer LI0))