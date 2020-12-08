;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-037-fn-design-str-rest) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; 1. We use non-epmty string; character is a one length string

; 2. Signature, purpose, stub
; Signature: consume one String and produce a String
; String -> String
; Purpose statement:
; produce a string like the given one, but without the first character
; Stub:
; (define (string-rest str) "")

; 3. Some functional examples:
; given: "hello world", expect: "ello world"
; given: "str", expect: "tr"

; 4. Template:
#; 
(define (string-rest str)
  (... str...))

; 5. Code:
(define (string-rest str)
  (substring str 1))

; 6. Tests:
(substring "hello world" 1)
(substring "str" 1)