;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-190-prefxies-and-suffixes) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; Lo1s is one of:
; - '()
; - (cons 1String Lo1s)
; interpretation a list of 1Strings

; Loap is one of:
; - '()
; - (cons Lo1s Loap)
; interpretation a list of all prefixes, each is a list of 1Strings

; Loas is one of:
; - '()
; - (cons Lo1s Loas)
; interpretation a list of all suffixes, each is a list of 1Strings


(define LO1S0 '())
(define LO1S1 (list "a"))
(define LO1S2 (list "a" "b"))
(define LO1S3 (list "a" "b" "c"))
(define LO1S4 (list "a" "b" "c" "d"))


(define LOAP0 '())
(define LOAP1 (list LO1S4 LO1S3 LO1S2 LO1S1))

(define LOAS (list LO1S1 LO1S2 LO1S3 LO1S4))


; Lo1s -> Loap
; produce lists of all preffixes
(check-expect (prefixes '()) '())
(check-expect (prefixes (list "a")) (list (list "a")))
(check-expect (prefixes (list "a" "b")) (list (list "a" "b") (list "a")))
(check-expect (prefixes LO1S4) LOAP1)
(define (prefixes l)
  (cond
    [(empty? l) '()]
    [else
     (cons l (prefixes (remove-lst-entery l)))]))

; Lo1S -> Lo1s
; remove the last entery from the given list
(check-expect (remove-lst-entery (list 1)) '())
(check-expect (remove-lst-entery (list 1 2 3)) (list 1 2))

(define (remove-lst-entery l)
  (cond
    [(empty? (rest l)) '()]
    [else (cons (first l)
                (remove-lst-entery (rest l)))]))


; Lo1s -> Loas
; produce lists of all suffixes
(check-expect (suffixes (list "a" "b" "c" "d"))
              (list
               (list "a" "b" "c" "d")
               (list "b" "c" "d")
               (list "c" "d")
               (list "d")))
(define (suffixes l)
  (cond [(empty? l) '()]
        [else
         (cons l (suffixes (rest l)))]))