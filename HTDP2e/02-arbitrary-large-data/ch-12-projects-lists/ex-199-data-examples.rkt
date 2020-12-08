;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-199-data-examples) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; Data definitions:
; the 2htdp/itunes library documentation, part 1: 
 
; An LTracks is one of:
; – '()
; – (cons Track LTracks)
 
;(define-struct track
;  [name artist album time track# added play# played])
; A Track is a structure:
;   (make-track String String String N N Date N Date)
; interpretation An instance records in order: the track's 
; title, its producing artist, to which album it belongs, 
; its playing time in milliseconds, its position within the 
; album, the date it was added, how often it has been 
; played, and the date when it was last played
 
;(define-struct date [year month day hour minute second])
; A Date is a structure:
;   (make-date N N N N N N)
; interpretation An instance records six pieces of information:
; the date's year, month (between 1 and 12 inclusive), 
; day (between 1 and 31), hour (between 0 
; and 23), minute (between 0 and 59), and 
; second (also between 0 and 59).

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
