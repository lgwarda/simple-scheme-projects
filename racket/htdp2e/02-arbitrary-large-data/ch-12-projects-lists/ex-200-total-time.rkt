;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-200-total-time) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; Dates:
(define DT1A (create-date 2017 10 18 15 57 40))
(define DT1P (create-date 2018 11 28 20 12 10))
(define DT2A (create-date 2018 11 28 20 23 22))
(define DT2P (create-date 2018 11 28 20 25 10))
(define DT3P (create-date 2018 11 28 20 32 30))

;Tracks:
(define T1 (create-track "Jesus Alone"
                         "Nick Cave & The Bad Seeds"
                         "Skeleton Tree"
                         300000
                         1
                         DT1A
                         20
                         DT1P))
(define T2 (create-track "Jubilee Street"
                         "Nick Cave & The Bad Seeds"
                         "Live in Copenhagen"
                         420000
                         1
                         DT1A
                         1
                         DT1P))
(define T3 (create-track "Distant Sky"
                         "Nick Cave & The Bad Seeds"
                         "Live in Copenhagen"
                         360000
                         1
                         DT1A
                         1
                         DT3P))
;LTracks
(define LT0 '())
(define LT1 (list T1))
(define LT2 (list T1 T2 T3))

; total-time: LTracks -> N
; produces total aomunt of play time in milliseconds
(check-expect (total-time '()) 0)
(check-expect (total-time LT1) 300000)
(check-expect (total-time LT2) (+ 300000  420000  360000))
(define (total-time lt)
  (cond [(empty? lt) 0]
        [else
         (+ (track-time (first lt))
            (total-time (rest lt)))]))

; modify the following to use your chosen name 
;(define ITUNES-LOCATION "itunes.xml")
 
; LTracks
;(define itunes-tracks
;  (read-itunes-as-tracks ITUNES-LOCATION))

;(total-time itunes-tracks)

;604,900,000 milliseconds, that's a little more than a week