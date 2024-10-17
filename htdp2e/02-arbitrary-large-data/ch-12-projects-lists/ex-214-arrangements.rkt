;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-214-arrangements) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; On OS X: 
(define LOCATION "/usr/share/dict/words")
(define DICTIONARY-AS-LIST (read-lines LOCATION))

; String -> List-of-strings
; finds all words that the letters of some given word spell
(check-member-of (alternative-words "cat")
                 (list "act" "cat")
                 (list "cat" "act"))
 
(define (alternative-words s)
  (in-dictionary
   (words->strings (arrangements (string->word s)))))

; Word -> List-of-words
; create all rearrangaments of the letters in w
(define (arrangements w)
  (cond
    [(empty? w) (list '())]
    [else
     (insert-everywhere/in-all-words
      (first w)
      (arrangements (rest w)))]))

; String -> Word
; converts s to the chosen word representation
(define (string->word s)
  (explode s))

; Word -> String
; converts w to a string
(define (word->string w)
  (implode w))

; List-of-words -> List-of-strings
; turns all Words in low into Strings 
(define (words->strings low)
  (cond [(empty? low) '()]
        [else
         (cons (word->string (first low)) 
               (words->strings (rest low)))]))

; List-of-strings -> List-of-strings
; extracts from the given s only words that are in dictionary
(define (in-dictionary s)
  (cond
    [(empty? s) '()]
    [else (if (member? (first s) DICTIONARY-AS-LIST)
              (cons (first s) (in-dictionary (rest s)))
              (in-dictionary (rest s)))]))

; insert-everywhere/in-all-words: 1String Low -> Low
; produces a low with the first argument inserted at the beginning,
; between all letters, and at the end of all words of the given list.
(define (insert-everywhere/in-all-words 1s low)
  (cond [(empty? low) '()]
        [else
         (append (insert-letter '() 1s (first low))
                 (insert-everywhere/in-all-words 1s (rest low)))]))

; insert-everywhere: 1String Word Word  -> Low
; inserts a letter (1String) into a list of words
(define (insert-letter w1 ltr w2)
  (cond [(empty? w2) (list (append w1 (list ltr)))]
        [else
         (append (list (append w1 (list ltr) w2))
                 (insert-letter (append w1 (list (first w2)))
                                ltr
                                (rest w2)))]))

