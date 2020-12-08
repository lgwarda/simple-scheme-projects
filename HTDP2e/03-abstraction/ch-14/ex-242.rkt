;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname ex-242) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; A [Maybe X] is one of: 
; – #false 
; – X

; A [Maybe String] is one of: 
; – #false 
; – String
; interpretation: two item, either #f or string


; A [Maybe [List-of String]] is one of: 
; – #false 
; – [List-of String]
; interpretation: two item, either #f or list of string

; A [List-of [Maybe String]] is one of: 
; – #false 
; – [List-of [Maybe String]
; interpretation: a list composed of two items either strings or #f


; String [List-of String] -> [Maybe [List-of String]]
; returns the remainder of los starting with s 
; #false otherwise 
(check-expect (occurs "a" (list "b" "a" "d" "e"))
              (list "d" "e"))
(check-expect (occurs "a" (list "b" "c" "d")) #f)

(define (occurs s los)
  (cond [(empty? los) #f]
        [(string=? (first los) s) (rest los)]
        [else (occurs s (rest los))]))
