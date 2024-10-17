;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-187-sort-by-score) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
; a progrma that sorts lists of gamelayers by score

; Data definitions:

(define-struct gp [name score])
; A GamePlayer is a structure: 
;    (make-gp String Number)
; interpretation (make-gp p s) represents player p who 
; scored a maximum of s points

(define G0 (make-gp "PLR" 23))
(define G1 (make-gp "YER" 59))

; GamePlayer -> ...
(define (process-gp g)
  (... (gp-name g)
       (gp-score g)))

; A Logp (List-of-game-player) is one of:
; - '()
; - (cons GamePlayer Logp)
; interrpretation a list of geme players

(define LOGP0 '())
(define LOGP1 (list G1))
(define LOGP2 (list G0 G1))

; Logp -> ....
(define (process-logp l)
  (cond [(empty? l) ...]
        [else
         (... (first l)
              (process-logp (rest l)))]))

; Functions:


; Logp -> Logp 
; rearranges list of gp in descending order
(check-expect (sort-by-score '()) '())
(check-expect (sort-by-score (list G0 G1)) (list G1 G0))
(check-expect (sort-by-score (list (make-gp "GBH" 55) (make-gp "GBK" 66) (make-gp "JFK" 20)))
              (list (make-gp "GBK" 66) (make-gp "GBH" 55) (make-gp "JFK" 20)))

(define (sort-by-score l)
  (cond [(empty? l) '()]
        [else
         (insert (first l)
                 (sort-by-score  (rest l)))]))

; GamePlayer Logp -> Logp
; inserts (gp-score g) into the sorted list of game players
(check-expect (insert G0 '()) (list G0))
(check-expect (insert G0 LOGP1) (list G1 G0))
(check-expect (insert G0 (list (make-gp "GBK" 66) (make-gp "GBH" 55) (make-gp "JFK" 20)))
              (list (make-gp "GBK" 66) (make-gp "GBH" 55) G0 (make-gp "JFK" 20)))



(define (insert p l)
  (cond [(empty? l) (cons p '())]
        [else
         (if (> (gp-score p) (gp-score (first l)))
             (cons p l)
             (cons (first l) (insert p (rest l))))]))
