;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname pl-forms) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A pluralize is a program that 

; A singular noun ending in s, x, z, ch, sh makes the plural by adding-es
(define RULE2 (list "s" "x" "z" "h"))

; String -> String
; produce the prular form of the give string
(define (pluralize wd)
  
  (cond [(same? wd) wd]
        [(string=? (lst2 wd) "is") (string-append (cut-lst2 wd) "es")]
        [(and (string=? (lst2 wd) "us") (< 3 (string-length wd))) (string-append (cut-lst2 wd) "i")]
        [(ends? (lst wd))(string-append wd "es")]
        [(string=? (lst wd) "f")  (string-append (cut-lst wd) "ves")]
        [(string=? (lst2 wd) "fe") (string-append (cut-lst2 wd) "ves")]
        [(string=? (lst wd) "o" ) (string-append wd "es")]
        [(string=? (lst2 wd) "on") (string-append (cut-lst2 wd) "a")]
        [(and (string=? (lst wd) "y") (vowel? (lst (cut-lst wd))))
         (string-append wd "s")]
       
        [(string=? (lst wd) "y") (string-append (cut-lst wd) "ies")]
        [else (string-append wd "s")]))


; add ‐s to the end
(check-expect (pluralize "book") "books")
(check-expect (pluralize "cat") "cats")
(check-expect (pluralize "house") "houses")
; ends in ‐s, -ss, -sh, -ch, -x, or -z, add ‐es
(check-expect (pluralize "bus") "buses")
(check-expect (pluralize "marsh") "marshes")
(check-expect (pluralize "truss") "trusses")
(check-expect (pluralize "tax") "taxes")
(check-expect (pluralize "lunch") "lunches")
(check-expect (pluralize "blitz") "blitzes")

; ending in -s or -z, require that you double the -s or -z prior to adding the -es
; given: fez, produce: fezzes
; given: gas, produce: gasses

; ends with ‐f or ‐fe, the f is often changed to ‐ve before adding the -s
; exeptation (list "roofs" "belifes" "chefs" "chiefs")
(check-expect (pluralize "wife") "wives")
(check-expect (pluralize "wolf") "wolves")


; ends in ‐y and the letter before the -y is a consonant, change the ending to ‐ies to 
(check-expect (pluralize "fly") "flies")
(check-expect (pluralize "city") "cities")
(check-expect (pluralize "puppy") "puppies")

; ends in -y and the letter before the -y is a vowel, simply add an -s 
(check-expect (pluralize "boy") "boys")
(check-expect (pluralize "ray") "rays")

; ends in ‐o, add ‐es
(check-expect (pluralize "patato") "patatoes")
(check-expect (pluralize "tomato") "tomatoes")
; Exceptions: !!!
; photo –> photos
; piano –> pianos
; halo –> halos

; ends in ‐us, frequently add ‐i
(check-expect (pluralize "cactus") "cacti")
(check-expect (pluralize "focus") "foci")

; ends in ‐is, add -es
(check-expect (pluralize "analysis") "analyses")
(check-expect (pluralize "elipsis") "elipses")

; ends in ‐on, the plural ending is ‐a
(check-expect (pluralize "phenomenon") "phenomena")
(check-expect (pluralize "criterion") "criteria")

; don’t change at all when they’re pluralized
(check-expect (pluralize "sheep") "sheep")
(check-expect (pluralize "series") "series")
(check-expect (pluralize "species") "species")
(check-expect (pluralize "deer") "deer")
(check-expect (pluralize "fish") "fish")

(define (same? wd)
 (member? wd (list "sheep" "series" "species" "deer" "fish")))

; String -> String
; extracts the last character from the given str
(check-expect (lst "fly") "y")
(define (lst s)
  (substring s (- (string-length s) 1)))
(check-expect (lst "fly") "y")

; String -> String
; extracts the last two character from the given str
(define (lst2 s)
  (substring s (- (string-length s) 2)))

; String -> String
; produce the last character from the giiven str
(check-expect (cut-lst "fly")"fl")
(check-expect (cut-lst "pneumonoultramicroscopicsilicovolcanoconiosis")
              "pneumonoultramicroscopicsilicovolcanoconiosi")
(define (cut-lst s)
  (substring s 0 (- (string-length s) 1)))

; String -> String
; produce the last character from the giiven str
(check-expect (cut-lst2 "fly") "f")
(define (cut-lst2 s)
  (substring s 0 (- (string-length s) 2)))

; String ListOfString -> Boolean
; produce #t if letter match the given list
; helper function for the folloeing rule:
; if the singular noun ends in ‑s, -ss, -sh, -ch, -x, or -z,
;  then add ‑es to the end to make it plural.
(define (vowel? letter)
  (member? letter (list "a" "e" "i" "o" "u")))

; String ListOfString -> Boolean
; produce #t if letter match the given list
(define (ends? letter)
  (member? letter RULE2))

; String ListOfString -> Boolean
; produce #t if letter match the given list
(define (ends.r2? letter)
  (member? letter (list "s" "z")))

