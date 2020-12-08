;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-019-string-insert) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; string-insert: String Number -> String
; insert "_" at the ith position od string
(check-expect (string-insert "" 0) "_")
(check-expect (string-insert "hello" 5) "hello_")
(check-expect (string-insert "helloworld" 5) "hello_world")

(define (string-insert str i)
  (string-append (substring str 0 i) "_" (substring str i)))