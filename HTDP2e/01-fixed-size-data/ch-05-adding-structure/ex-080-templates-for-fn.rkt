;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-080-templates-for-fn) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define-struct movie [title director year])

; Movie -> !!!
(define (fn-for-movie m)
  (... (... (movie-title m))
       (... (movie-directir m))
       (... (movie-year m))))

(define-struct pet [name number])

; Pet -> !!!
(define (fn-for-pet p)
  (... (... (pet-name p))
       (... (pet-number p))))

(define-struct CD [artist title price])

; CD -> !!!
(define (fn-for-CD c)
  (... (... (CD-artist c))
       (... (CD-title c))
       (... (CD-year c))))

(define-struct sweater [material size color])

; Sweater -> !!!
(define (fn-for-sweater s)
  (... (... (sweater-material s))
       (... (sweater-size s))
       (... (sweater-color s))))