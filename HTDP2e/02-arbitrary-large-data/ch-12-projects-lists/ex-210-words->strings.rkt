;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-210-words->strings) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)
(define W0 '())
(define W1 (list "r" "a" "t"))
(define W2 (list "c" "a" "t"))

; A List-of-words is one of:
; - '()
; - (cons Word List-of-words)
; - interpretation a Low is a list of a list of 1Strings
(define LOW1 (list W2 W1))

; Functions:

; String -> Word
; converts s to the chosen word representation
(check-expect (string->word "") '())
(check-expect (string->word "cat") (list "c" "a" "t"))
(define (string->word s)
  (explode s))
 
; Word -> String
; converts w to a string
(check-expect (word->string '()) "")
(check-expect (word->string (list "c" "a" "t")) "cat")
(define (word->string w)
  (implode w))

; List-of-words -> List-of-strings
; convert a list of words into a list of strings
(check-expect (words->strings '())'())
(check-expect (words->strings (list (list "c" "a" "t")))
              (list "cat"))
(check-expect (words->strings (list (list "c" "a" "t") (list "r" "a" "t")))
              (list "cat" "rat"))

(define (words->strings low)
  (cond [(empty? low) '()]
        [else
         (cons (word->string (first low)) 
               (words->strings (rest low)))]))