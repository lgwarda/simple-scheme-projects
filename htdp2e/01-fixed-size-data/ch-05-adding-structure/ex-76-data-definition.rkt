;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-76-data-definition) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct movie [title producer year])
; A Movie is a structure:
;  (make-movie String String Number)
; interpretation:
; - title is the name of the movie
; - producer is the name of the producer
; - year is the year the movie was made 

(define-struct person [name hair eyes phone])
; A Person is a structure:
;  (make-person String String String String)
; interpretation:
; - name means preson name
; - hair means person hair color
; - eyes means person eyes color
; - phone meanes preson phone

(define-struct pet [name number])
; A Pet is a structure:
;  (make-pet String Natural)
; interpretation:
; - name is the pet name
; - number is the pet id #

(define-struct CD [artist title price])
; A CD is a structure:
;  (make-cd String String Number)
; interpretattion:
; - artist is the name of the artist
; - title is the name of the record
; - price is the price of the Cd in U$D

(define-struct sweater [material size producer])
; A Sweater is a structure:
;  (make-sweater String String String)
; interpretation: a sweater has a material, a size, and a manufacturer