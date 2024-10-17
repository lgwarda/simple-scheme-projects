;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-079-data-def-eg) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; A Color is one of:
; — "white"
; — "yellow"
; — "orange"
; — "green"
; — "red"
; — "blue"
; — "black" 

(define RED "red")
(define GREEN "green")
(define BLUE "blue")

; H is a Number between 0 and 100.
; interpretation represents a happiness value 

(define H0 0)
(define H1 36)
(define H2 100)

(define-struct person [fstname lstname male?])
; A Person is a structure:
;   (make-person String String Boolean)
; interp. fstname is a person first name
;         lstname is a person last name
;         male? if the person is male return #t othrwise #f

#|
Field names that look like a predicate is a good idea.
They willl be tested with predicates, and the names are
good for documentation
|#

(define P1 (make-person "Ada" "Lovelece" #f))
(define P2 (make-person "Matthias" "Felleisen" #t))

(define-struct dog [owner name age happiness])
; A Dog is a structure:
;   (make-dog Person String PositiveInteger H)
; interp. owner is a person w/ first and last name and info about gender
;         name is the dog name
;         age is the dog age
;         happines is the level of dog hapiness[0, 100]

(define D0 (make-dog P1 "Snoop" 2 45))
(define D1 (make-dog
            (make-person "Eric" "Deeds" #t) "Roco" 2 45))

; A Weapon is one of:
; — #false
; — Posn
; interpretation #false means the missile hasn't
; been fired yet; a Posn means it is in flight

(define W0 #f) 
(define W1 (make-posn 33 65)) 