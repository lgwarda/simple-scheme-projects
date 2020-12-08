;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-155-rd-inner) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
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



; inner: RD -> String
; produce color of the innermost doll
(check-expect (inner RDY) "yellow")
(check-expect (inner RD1) "red")
(check-expect (inner RD2) "red")

(define (inner an-rd)
  (cond
    [(string? an-rd) an-rd]
    [else (inner (layer-doll an-rd))]))

(inner RD2)