;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-036-fn-design-img-area) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; 1. We use numbers in pixels to represent an area of the image

; 2. Signature, purpose, stub:
; Signature: consume one Image and produce a Number
; Image -> Number
; Purpose statement:
; produce the number of pixels in a given image, area is width x height
; Stub:
; (define (image-area img) empty-image)

; 3. Some functional examples:
; given: (rectangle 10 20 "solid" "blue"),
;         10 for width,
;         20 for height,
; expect: 200 

; 4. Template:
#;
(define (image-area img)
  (* (... img) (... img)))

; 5. Code:
(define (image-area img)
  (* (image-width img)
     (image-height img)))

; 6. Tests:
(image-area (rectangle 10 20 "solid" "blue"))
