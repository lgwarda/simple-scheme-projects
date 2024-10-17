;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-207-total-time-list) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
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
(define LA1
  (list
   (list "Album" "Sandbox")
   (list "Artist" "Guided By Voices")
   (list "Name" "Adverse Wind")
   (list "Total Time" 174000)))

; Functions:

; String -> LLists
; creates a list of lists representation for all tracks in 
; file-name, which must be an XML export from iTunes 


; LLists
;(define list-tracks
;  (read-itunes-as-lists ITUNES-LOCATION))

; total-time/list: LLists -> Number
; produces the total amount of play time in milliseconds
(check-expect (total-time/list '()) 0)
(check-expect (total-time/list LL3) (+ 82800 82800  174000))

(define (total-time/list llst)
  (cond [(empty? llst) 0]
        [else
         (+ (second (find-association "Total Time" (first llst) 0))
            (total-time/list (rest llst)))]))

; find-association: String LAssoc Any -> Association
; producses the first item either is equal to key or default
(check-expect (find-association "Adverse Wind" LA1 0) 0)
(check-expect (find-association "Total Time" LA1 0) (list "Total Time" 174000))

(define (find-association key lassoc default)
  (cond [(empty? lassoc) default]
        [else
         (if (string=? (first (first lassoc)) key)
             (cons key (rest (first lassoc)))
             (find-association key(rest lassoc) default))]))
