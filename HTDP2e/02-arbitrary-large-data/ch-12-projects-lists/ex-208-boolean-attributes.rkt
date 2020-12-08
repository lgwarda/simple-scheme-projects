;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-208-boolean-attributes) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; the 2htdp/itunes library documentation, part 2: 
; modify the following to use your chosen name
(define ITUNES-LOCATION "itunes.xml") 

; An LLists is one of:
; – '()
; – (cons LAssoc LLists)
 

; An LAssoc is one of: 
; – '()
; – (cons Association LAssoc)

; An Association is a list of two items: 
;   (cons String (cons BSDN '()))

; A BSDN is one of: 
; – Boolean
; – Number
; – String
; – Date

(define LL3
  (list
   (list
    (list "Album" "Sandbox")
    (list "Artist" "Guided By Voices")
    (list "Name" "Lips Of Steel")
    (list "Total Time" 82800))
   (list
    (list "Album" "Sandbox")
    (list "Artist" "Guided By Voices")
    (list "Name" "A Visit To The Creep Doctor")
    (list "Total Time" 82800))
   (list
    (list "Album" "Sandbox")
    (list "Artist" "Guided By Voices")
    (list "Name" "Adverse Wind")
    (list "Total Time" 174000))))

(define LLB
  (list
   (list "Album" #f)
   (list "Artist" #t)
   (list "Album" "Sandbox")
   (list "Artist" "Guided By Voices")
   (list "Total Time" #f)))


; Functions:

; boolean-attributes: LLists -> List-of-strings
; produces the los that are associated with a Boolean attribute
(check-expect (boolean-attributes '()) '())
(check-expect (boolean-attributes LL3) '())
(check-expect (boolean-attributes LLB) (list "Album" "Artist" "Total Time"))

(define (boolean-attributes llts)
  (create-set (assoc-with-boolean llts)))

; create-set: List-of-strings -> List-of-string
; produce a list of strings without repeated enteries
(define (create-set los)
  (cond [(empty? los) '()]
        [else
         (cons (first los)
               (create-set (remove-str (first los)(rest los))))]))

; remove-str: String List-of-strings  -> List-of-strings
; cuts out the given s from the given los
(check-expect (remove-str "a" '()) '())
(check-expect (remove-str "1" (list "1" "2" "3")) (list "2" "3"))

(define (remove-str s los)
  (cond [(empty? los) '()]
        [else
         (if (string=? s (first los))
             (remove-str s (rest los))
             (cons (first los) (remove-str s (rest los))))]))

; assoc-with-boolean: LAssoc -> List-of-strings
; produces the list
(define (assoc-with-boolean  lassoc)
  (cond [(empty? lassoc) '()]
        [else
         (if (boolean? (second (first lassoc)))
             (cons (first (first lassoc))
                   (assoc-with-boolean (rest lassoc)))
             (assoc-with-boolean (rest lassoc)))]))