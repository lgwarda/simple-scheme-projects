;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-212-data-definitions-for-low) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; A Word is one of:
; – '() or
; – (cons 1String Word)
; interpretation a Word is a list of 1Strings (letters)

; A List-of-words (Low) is one of:
; - '()
; - (cons Word Low)
; interpretation a Low is a list of Words

(define W0 '())
(define W1 (list "a" "a")) ;rough cindery lava
(define W2 (list "a" "d")) ;an advertisement

(define LOW0 (list W0))
(define LOW1 (list W1 W1))
(define LOW2 (list W1 W2 (list "d" "a"))) ;one's fhther  

; Word -> List-of-words
; create all rearrangaments of the letters in w
(check-expect (arrangements LOW0) (list '()))
(check-expect (arrangements LOW1) (list W1 W1))
(check-expect (arrangements LOW2)
              (list (list "a" "a") (list "a" "a") (list "a" "d") (list "d" "a")))
(check-expect (arrangements (list "d" "e" "r"))
              (list (list "d" "e" "r") (list "d" "r" "e") (list "e" "d" "r")
                    (list "r" "d" "e") (list "e" "r" "d") (list "r" "e" "d")))

(define (arrangements w)
  (cond
    [(empty? w) (list '())]
    [else
     (insert-everywhere/in-all-words
      (first w) (arrangements (rest w)))]))

; insert-everywhere/in-all-words: 1String Low -> Low
; produces a low with the first argument inserted at the beginning,
; between all letters, and at the end of all words of the given list.
; !!!
(define (insert-everywhere/in-all-words 1s w)
  w)