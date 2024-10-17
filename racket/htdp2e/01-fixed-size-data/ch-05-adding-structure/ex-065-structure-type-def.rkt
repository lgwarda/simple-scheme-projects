;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-065-structure-type-def) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct movie [title producer year])

; constructor: make-movie

; selectors: movie-title, movie-producer, movie-year

; predicate: movie?

(define-struct person [name hair eyes phone])

; constructor: make-person

; selectors: person-name, person-hair, person-eyes, person-phone

; predicate: person?

(define-struct pet [name number])

; constructor: make-pet

; seclectors: pet-name, pet-number

; predicate: pet?

(define-struct CD [artist title price])

; constructor: make-CD

; seclectors: CD-artist, CD-title, CD-price

; predicate: CD?

(define-struct sweater [material size producer])

; constructor: make-sweater

; selectors: sweater-material, sweater-size, sweater-producer

; predicate: sweater?