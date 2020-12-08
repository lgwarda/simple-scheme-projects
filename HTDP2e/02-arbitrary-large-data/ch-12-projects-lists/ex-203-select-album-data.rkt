;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-203-select-album-data) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; Dates:
(define DT1A (create-date 2017 10 18 15 57 40))
(define DT1P (create-date 2018 11 28 20 12 10))
(define DT2A (create-date 2018 11 28 20 23 22))
(define DT2P (create-date 2018 11 28 20 25 10))
(define DT3P (create-date 2018 11 28 20 32 30))
(define DT4A (create-date 2018 11 28 20 30 10))
(define DT4P (create-date 2018 11 28 20 35 40))

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
                         2
                         DT1A
                         1
                         DT3P))
(define T4 (create-track "From Her to Etrnity"
                         "Nick Cave & The Bad Seeds"
                         "Live in Copenhagen"
                         540000
                         3
                         DT4A
                         1
                         DT4P))


;LTracks
(define LT0 '())
(define LT1 (list T1))
(define LT2 (list T1 T2 T3 T4))

; Functions:

; select-album-date: String Data LTrack -> LTrack
; produces a list of tracks belong to the given album and playd after the given date
(check-expect (select-album-date "Skeleton Tree" DT1P '()) '())
(check-expect (select-album-date "Skeleton Tree" DT1P LT1) '())
(check-expect (select-album-date "Live in Copenhagen" DT2P LT2)
              (list T3 T4))

(define (select-album-date s d lt)
  (cond [(empty? lt) '()]
        [else
         (if (and (string=? s (track-album (first lt)))
                  (date<? d (track-played (first lt))))
             (cons (first lt)(select-album-date s d (rest lt)))
             (select-album-date s d (rest lt)))]))
 
; date<?: Date Date -> boolean
; produce #true, if d1 < d2
(check-expect (date<? (create-date 2017 11 28 20 12 10)
                      (create-date 2018 11 28 20 12 10)) #t)
(check-expect (date<? (create-date 2018 10 28 20 12 10)
                      (create-date 2017 11 28 20 12 10)) #t)
(check-expect (date<? (create-date 2017 10 28 20 12 10)
                      (create-date 2018 11 28 20 12 10)) #t)
(check-expect (date<? (create-date 2018 12 20 20 12 10)
                      (create-date 2018 11 28 20 12 10)) #t)
(check-expect (date<? (create-date 2018 11 28 10 12 10)
                      (create-date 2018 11 28 20 12 10)) #t)
(check-expect (date<? (create-date 2018 11 28 20 12  7)
                      (create-date 2018 11 28 20 12 10)) #t)
(check-expect (date<? (create-date 2018 11 28 20 12 10)
                      (create-date 2018 11 28 20 12 10)) #f)

(define (date<? d1 d2)
  (cond [(< (date-year d1) (date-year d2)) #t]
        [(< (date-month d1) (date-month d2)) #t]
        [(< (date-day d1) (date-day d2)) #t]
        [(< (date-hour d1) (date-hour d2)) #t]
        [(< (date-minute d1) (date-minute d2)) #t]
        [(< (date-second d1) (date-second d2)) #t]
        [else #f]))