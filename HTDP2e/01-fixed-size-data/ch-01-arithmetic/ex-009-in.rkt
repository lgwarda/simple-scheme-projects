;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-009-in) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
(define in "hello world")

(string-length in)

(if (number? in)
    (if (<= in 0)
        in
        (- in 1))
    (if (image? in)
        (* (image-width in) (image-height in))
        (if (string? in)
            (string-length in)
            (if (and #t in)
                10
                20))))