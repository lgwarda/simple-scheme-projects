;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-020-string-delete) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; string-deete: String Number -> String
; delete the ith position from string
(check-expect (string-delete "helloworld" 5) "helloorld")
; since index is out of range string-delete cant deal with empty str

(define (string-delete str i )
  (string-append (substring str 0 i)
                 (substring str (+ i 1) (string-length str))))