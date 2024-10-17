;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-135-contains-flatt?-stepper) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (contains-flatt? alon)
  (cond
    [(empty? alon) #false]
    [(string=? (first alon) "Flatt") #true]
    [else (contains-flatt? (rest alon))]))


(contains-flatt? (cons "Flatt" (cons "C" '())))
;==
(cond
  [(empty? (cons "Flatt" (cons "C" '()))) #false]
  [(string=? (first (cons "Flatt" (cons "C" '()))) "Flatt") #true]
  [else
   (contains-flatt? (rest (cons "Flatt" (cons "C" '()))))])
; ==
(cond
  [#false #false]
  [(string=? (first (cons "Flatt" (cons "C" '()))) "Flatt") #true]
  [else
   (contains-flatt? (rest (cons "Flatt" (cons "C" '()))))])
; ==
(cond
  [(string=? (first (cons "Flatt" (cons "C" '()))) "Flatt") #true]
  [else
   (contains-flatt? (rest (cons "Flatt" (cons "C" '()))))])
; ==
(cond
  [(string=? "Flatt" "Flatt") #true]
  [else
   (contains-flatt? (rest (cons "Flatt" (cons "C" '()))))])
; ==
(cond
  [#true #true]
  [else
   (contains-flatt? (rest (cons "Flatt" (cons "C" '()))))])
; ==
#true

(contains-flatt?
 (cons "A" (cons "Flatt" (cons "C" '()))))
; ==
(cond
  [(empty?  (cons "A" (cons "Flatt" (cons "C" '())))) #false]
  [(string=? (first  (cons "A" (cons "Flatt" (cons "C" '())))) "Flatt") #true]
  [else (contains-flatt? (rest  (cons "A" (cons "Flatt" (cons "C" '())))))])
; ==
(cond
  [#false #false]
  [(string=? (first  (cons "A" (cons "Flatt" (cons "C" '())))) "Flatt") #true]
  [else (contains-flatt? (rest  (cons "A" (cons "Flatt" (cons "C" '())))))])
; ==
(cond
  [(string=? (first  (cons "A" (cons "Flatt" (cons "C" '())))) "Flatt") #true]
  [else (contains-flatt? (rest  (cons "A" (cons "Flatt" (cons "C" '())))))])
; ==
(cond
  [(string=? "C" "Flatt") #true]
  [else (contains-flatt? (rest  (cons "A" (cons "Flatt" (cons "C" '())))))])
; ==
(cond
  [#false #true]
  [else (contains-flatt? (rest  (cons "A" (cons "Flatt" (cons "C" '())))))])
; ==
(cond
  [else (contains-flatt? (rest  (cons "A" (cons "Flatt" (cons "C" '())))))])
; ==
(cond
  [else (contains-flatt? (cons "Flatt" (cons "C" '())))])
; ==
(cond
  [(empty? (cons "Flatt" (cons "C" '()))) #false]
  [(string=? (first (cons "Flatt" (cons "C" '()))) "Flatt") #true]
  [else (contains-flatt? (rest  (cons "Flatt" (cons "C" '()))))])
; ==
(cond
  [(empty? (cons "Flatt" (cons "C" '()))) #false]
  [(string=? (first (cons "Flatt" (cons "C" '()))) "Flatt") #true]
  [else (contains-flatt? (rest  (cons "Flatt" (cons "C" '()))))])
; ==
(cond
  [#false #false]
  [(string=? (first (cons "Flatt" (cons "C" '()))) "Flatt") #true]
  [else
   (contains-flatt? (rest (cons "Flatt" (cons "C" '()))))])
; ==
(cond
  [(string=? (first (cons "Flatt" (cons "C" '()))) "Flatt") #true]
  [else
   (contains-flatt? (rest (cons "Flatt" (cons "C" '()))))])
; ==
(cond
  [(string=? "Flatt" "Flatt") #true]
  [else
   (contains-flatt? (rest (cons "Flatt" (cons "C" '()))))])
; ==
(cond
  [#true #true]
  [else
   (contains-flatt? (rest (cons "Flatt" (cons "C" '()))))])
; ==
#true


; if "Flatt" is replaced with "B", return #false 

