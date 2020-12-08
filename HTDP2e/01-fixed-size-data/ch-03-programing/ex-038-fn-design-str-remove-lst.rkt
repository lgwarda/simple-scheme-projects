;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-038-fn-design-str-remove-lst) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; 1. We use non-epmty string; character is a one length string

; 2. Signature, purpose, stub
; Signature: consume one String and produce a String
; String -> String
; Purpose statement:
; produce a string like the given, but without last character
; Stub:
; (define (string-remove-last str) "")

; 3. Some functional examples:
; given: "hello world", expect: "hello worl"
; given: "str", expect: "st"

; 4. Template:
#; 
(define (string-rest str)
  (... str...))

; 5. Code:
(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))

; 6. Tests:
(string-remove-last "hello world") 
(string-remove-last "str") 
 


