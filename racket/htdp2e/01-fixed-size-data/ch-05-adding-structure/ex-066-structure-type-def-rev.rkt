;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-066-structure-type-def-rev) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct movie [title producer year])

(make-movie "The Drop" "Big Screen Productions" 2014)

(define-struct person [name hair eyes phone])

(make-person "Luke" "Blond" "Green"  "444-7771")

(define-struct pet [name number])

(make-pet "Tania" 091415002)

(define-struct CD [artist title price])

(make-CD "Dusty Springfield" "Dusty In Menphies" 19.99)

(define-struct sweater [material size producer])

(make-sweater "Cashmere" "M" "JCrew")
