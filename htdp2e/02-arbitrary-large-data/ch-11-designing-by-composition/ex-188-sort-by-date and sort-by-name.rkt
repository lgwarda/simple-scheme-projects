;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |ex-188-sort-by-date and sort-by-name|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
(define-struct email [from date message])
; An Email Message is a structure: 
;   (make-email String Number String)
; interpretation (make-email f d m) represents text m 
; sent by f, d seconds after the beginning of time

(define EM1 (make-email "Mark" 160000 "Hi, Mark..."))
(define EM2 (make-email "Luke" 260000 "Hi, Luke..."))
(define EM3 (make-email "Matt" 360000 "Hi, Matt..."))
(define EM4 (make-email "John" 460000 "Hi, John..."))

; EmailMassage -> ...
(define (process-email e)
  (... (email-from e)
       (email-date e)
       (email-massage e)))

; A Loem (List-of-emails) is one of:
; - '()
; - (cons EmailMassage Loe)
; interpretation a list of email massages

(define L0 '())
(define L1 (list EM1 EM2 EM3 EM4))
; Loem -> ...
(define (process-loem l)
  (cond [(empty? l) ...]
        [else
         (... (first l)
              (process-loem (rest l)))]))

; Loem -> Loem
; produce a loem sorted by date in ascending order
(check-expect (sort-by-date '()) '())
(check-expect (sort-by-date (list EM1 EM2)) (list EM1 EM2))
(check-expect (sort-by-date (list EM2 EM1)) (list EM1 EM2))
(check-expect (sort-by-date (list EM2 EM1 EM3)) (list EM1 EM2 EM3))

(define (sort-by-date l)
  (cond [(empty? l) '()]
        [else
         (insert-date (first l)
                      (sort-by-date (rest l)))]))

; EmailMassage Loem -> Loem
; inserts email into the sorted list of emails
(check-expect (insert-date EM1 '()) (list EM1))
(check-expect (insert-date EM2 (list EM1)) (list EM1 EM2))
(check-expect (insert-date EM1 (list EM2)) (list EM1 EM2))
(check-expect (insert-date EM2 (list EM1 EM3)) (list EM1 EM2 EM3))

(define (insert-date e l)
  (cond [(empty? l) (cons e l)]
        [else
         (if (date<? e (first l))
             (cons e l)
             (cons (first l) (insert-date e (rest l))))]))

; EmailMassage EmailMassage -> Boolean
; produce #true if email's date is most recent, em1 < em2
(check-expect (date<? EM2 EM1) #f)
(check-expect (date<? EM1 EM2) #t)


(define (date<? e1 e2)
  (< (email-date e1)
     (email-date e2)))

; Loem -> Loem
; produce a loem sorted by name in alphabetical order
(check-expect (sort-by-name '()) '())
(check-expect (sort-by-name L1) (list EM4 EM2 EM1 EM3))
(define (sort-by-name l)
  (cond [(empty? l) '()]
        [else
         (insert-name (first l)
                      (sort-by-name (rest l)))]))

; EmailMassage Loem -> Loem
; insert email into alphabeticaly sorted list of emials
(check-expect (insert-name EM4 '()) (list EM4))
(check-expect (insert-name EM1 (list EM3)) (list EM1 EM3))
(check-expect (insert-name EM3 (list EM1)) (list EM1 EM3))
(check-expect (insert-name EM1 (list EM2 EM3)) (list EM2 EM1 EM3))


(define (insert-name e l)
  (cond [(empty? l) (cons e'())]
        [else
         (if (name<? e (first l))
             (cons e l)
              (cons (first l) (insert-name e (rest l))))]))

; EmailMassage  EmailMassage  -> Boolean
; if names are ordered in a lexicographically strictly increasing, produce #t
(check-expect (name<? EM4 EM2) #t)
(check-expect (name<? EM2 EM4) #f)

(define (name<? e1 e2)
  (string<? (email-from e1) (email-from e2)))