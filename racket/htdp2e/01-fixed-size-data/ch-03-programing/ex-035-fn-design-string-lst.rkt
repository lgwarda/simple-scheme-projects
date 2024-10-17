;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-035-fn-design-string-lst) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))





; 1. We use non-epmty string; character is a one length string

; 2. Signature, purpose, stub.
; Signature: consume one String and produce a String:
; String -> String
; Purpose statement:
; produce the last charachter from non-empty string
; Stub:
; (define (string-first str) "")

; 3. Some functional examples:
; given: "hello world" , expect: "d"
; given: "str" , expect: "r"

; 4. Template:
#; 
(define (string-rest str)
  (... str...))

; 5. Code:
(define (string-last s)
  (substring s (- (string-length s) 1)))

; 6. Tests:
(string-last  "hello world")
(string-last "str")