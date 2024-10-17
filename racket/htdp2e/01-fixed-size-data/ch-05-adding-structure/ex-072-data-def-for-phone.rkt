;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-072-data-def-for-phone) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct phone [area number])
; A Phone is a structure:
;    (make-phone Number String)
; interpretation (make-phone area number)
; area the area code
; number the phone-number

(make-phone 617 "373-2462")

;; Next formulate a data definition for phone numbers using this structure
;; type definition:

(define-struct phone# [area switch num])
; A Phone# is a structure:
;   (make-phone# Number Number Number)
; interpretation: (make-phone# area switch number)
; area is the area code [000, 999]
; switch is phone switch exhange [000, 999]
; num is number in the neighborhood [0000, 9999]

(make-phone# 617 373 2432)