;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-154-rd-colors) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
(define-struct layer [color doll])

; An RD (short for Russian doll) is one of: 
; – String 
; – (make-layer String RD)
(define RDY "yellow")
(define RD1 (make-layer "green" "red"))
(define RD2 (make-layer RDY (make-layer "green" "red")))

; process-rd: RD -> ...
#;
(define (process-rd an-rd)
  (cond
    [(string? an-rd) ...]
    [(layer? an-rd)
     (... (layer-color an-rd) ...
          ... (process-rd (layer-doll an-rd)) ...)]))




; depth: RD -> Number
; how many dolls are part of an-rd
(check-expect (depth "red") 1)
(check-expect (depth (make-layer "green" "red")) 2)
(check-expect (depth (make-layer "yellow" (make-layer "green" "red"))) 3)

(define (depth an-rd)
  (cond
    [(string? an-rd) 1]
    [else (+ (depth (layer-doll an-rd)) 1)]))

; colors: RD -> String
; produce a srting of colors, separated by a comma and space
(check-expect (colors RDY) "yellow")
(check-expect (colors RD1) "green, red")
(check-expect (colors RD2) "yellow, green, red")

(define (colors an-rd)
  (cond
    [(string? an-rd) an-rd]
    [else
     (string-append (layer-color an-rd) ", "
                    (colors (layer-doll an-rd)))]))
