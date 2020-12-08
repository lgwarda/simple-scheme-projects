;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-211-in-dictionary) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; On OS X: 
(define LOCATION "/usr/share/dict/words")
(define DICTIONARY-AS-LIST (read-lines LOCATION))

; List-of-strings -> Boolean
(define (all-words-from-rat? w)
  (and
   (member? "rat" w) (member? "art" w) (member? "rat" w)))
 
; String -> List-of-strings
; finds all words that the letters of some given word spell
(define (alternative-words s)
  (in-dictionary
   (words->strings (arrangements (string->word s)))))
 
; List-of-words -> List-of-strings
; turns all Words in low into Strings 
(define (words->strings low)
  (cond [(empty? low) '()]
        [else
         (cons (word->string (first low)) 
               (words->strings (rest low)))]))


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
 
; List-of-strings -> List-of-strings
; picks out all those Strings that occur in the dictionary
(check-expect (in-dictionary '()) '())
(check-expect (in-dictionary (list "cat" "cta" "tca" "tac" "act" "atc"))
              (list "cat" "act"))

(define (in-dictionary los)
  (cond
    [(empty? los)'()]
    [else
     (if (member? (first los) DICTIONARY-AS-LIST)
         (cons (first los) (in-dictionary (rest los)))
         (in-dictionary (rest los)))]))

;(index "in-dictionary")

; Word -> List-of-words
; finds all rearrangements of word
(define (arrangements word)
  (list word))



