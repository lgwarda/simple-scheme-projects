;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-195-start-with#) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
; On OS X: 
(define LOCATION "/usr/share/dict/words")
; On LINUX: /usr/share/dict/words or /var/lib/dict/words
; On WINDOWS: borrow the word file from your Linux friend
 
; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

; A Letter is one of the following 1Strings: 
; – "a"
; – ... 
; – "z"
; or, equivalently, a member? of this list: 
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

(define D0 '())
(define D1 (list "alacrity" "browse" "count" "design"))
(define D2 (list "lexical" "sort" "orthogonality" "word" "xero"))


; Letter Dictionery -> Natural
; counts how many words begin with the given letter in the given dictionery
(check-expect (start-with# "a" '()) 0)
(check-expect (start-with# "a" D1) 1)
(check-expect (start-with# "a" D2) 0)
(check-expect (start-with# "s" (list "browse" "search" "sort" "word")) 2)
(check-expect (start-with# "b" (list "serch" "browse" "bee" "be" "word" "yellow" "xero")) 3)

(define (start-with# ltr dic)
  (cond [(empty? dic) 0]
        [else
         (+
         (if (string=? ltr (first (explode (first dic))))
          1 0)
          (start-with# ltr (rest dic)))]))

;(start-with# "e" AS-LIST) ;7817
;(start-with# "z" AS-LIST) ;719
