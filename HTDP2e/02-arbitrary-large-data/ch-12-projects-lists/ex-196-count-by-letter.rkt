;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-196-count-by-letter) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
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

(define-struct lc [letter count])
; a Letter-Count is a structure:
;  (make-lc Letter Number)
; interp. and represents how often a word starts with a letter

; a Lol (short for List-of-Letter-Counts) is one of:
; - '()
; - (cons Letter-Count Lol)

; a Lod (short for List-of-Dictionaries) is one of:
; - '()
; - (cons Dictionary Lod)

(define D0 '())
(define D1 (list "alacrity" "browse" "beer" "bee" "count" "design"))
(define D2 (list "browse" "beer" "bee" "count" "design"))
(define LC1 (make-lc "z" 723))

; Dictionery -> Lol
; produces a list of list of letter count
(define (count-by-letter dic)
  (occur-as-fst LETTERS dic))

; Letter Dicionery -> LetterCounts
; determine how many the given ltr occur as first in the dictionery
(check-expect (occur-as-fst '() '()) '())
(check-expect (occur-as-fst '() D1) '())
(check-expect (occur-as-fst (list "a" "b" "c" "d") D1)
              (list
               (make-lc "a" 1)
               (make-lc "b" 3)
               (make-lc "c" 1)
               (make-lc "d" 1)))

(define (occur-as-fst ltrs dic)
  (cond
    [(empty? ltrs) '()]
    [else (cons (make-lc (first ltrs)
                         (start-with# (first ltrs) dic))
                (occur-as-fst (rest ltrs) dic))]))

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

; (count-by-letter AS-LIST)
;(list
; (make-lc "a" 14537)
; (make-lc "b" 9675)
; (make-lc "c" 17406)
; (make-lc "d" 9946)
; (make-lc "e" 7818)
; (make-lc "f" 6382)
; (make-lc "g" 5843)
; (make-lc "h" 7889)
; (make-lc "i" 8303)
; (make-lc "j" 1158)
; (make-lc "k" 1735)
; (make-lc "l" 5211)
; (make-lc "m" 10709)
; (make-lc "n" 6098)
; (make-lc "o" 7219)
; (make-lc "p" 22171)
; (make-lc "q" 1075)
; (make-lc "r" 8955)
; (make-lc "s" 22759)
; (make-lc "t" 11389)
; (make-lc "u" 16179)
; (make-lc "v" 3079)
; (make-lc "w" 3607)
; (make-lc "x" 293)
; (make-lc "y" 532)
; (make-lc "z" 719))

