;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-197-most-frequant) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")) #f)))
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

; Dictionery -> LeterCount
; produces the most frequent LetterCount in the given Dictionery
(define (most-frequent in-dict)
  (occur-most-often (count-by-letter in-dict)))

; Llc -> LetterCount
; produce LC for the letter that occurs most often as the first one in the given Llc
(check-expect (occur-most-often (list
                                  (make-lc "e" 5)))
              (make-lc "e" 5))
(check-expect (occur-most-often (list
                                 (make-lc "a" 1)
                                 (make-lc "b" 3)
                                 (make-lc "c" 1)
                                 (make-lc "d" 1)))
              (make-lc "b" 3))
(define (occur-most-often l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (if (>= (lc-count (first l))
                  (lc-count (first (rest l))))
              (occur-most-often (cons (first l) (rest (rest l))))
              (occur-most-often (rest l)))]))
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


;(occur-most-often (count-by-letter AS-LIST)) 
;(make-lc "s" 22759)
