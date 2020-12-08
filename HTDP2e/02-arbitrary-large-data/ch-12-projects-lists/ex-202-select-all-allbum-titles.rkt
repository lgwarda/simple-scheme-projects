;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-201-select-all-allbum-titles) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
; modify the following to use your chosen name
(define ITUNES-LOCATION "itunes.xml")
 
; LTracks
;(define itunes-tracks
;  (read-itunes-as-tracks ITUNES-LOCATION))

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

; Functions:

; select-all-album-titles: LTrack -> List-of-srings
; produce the list of all album titles as a los
(check-expect (select-all-album-titles LT0) '())
(check-expect (select-all-album-titles LT1) (list "Skeleton Tree"))
(check-expect (select-all-album-titles LT2)
              (list "Skeleton Tree" "Live in Copenhagen" "Live in Copenhagen"))
(define (select-all-album-titles lt)
  (cond [(empty? lt) '()]
        [else
         (cons (track-album (first lt))
               (select-all-album-titles (rest lt)))]))

; create-set: List-of-strings -> List-of-string
; produce a list of strings without repeated enteries
(check-expect (create-set '()) '())
(check-expect (create-set (list "1")) (list "1"))
(check-expect (create-set (list "1" "2" "3")) (list "1" "2" "3"))
(check-expect (create-set (list "3" "2" "1")) (list "3" "2" "1"))
(check-expect (create-set (list "1" "2" "1" "3")) (list "1" "2" "3"))

(define (create-set los)
  (cond [(empty? los) '()]
        [else
         (cons (first los)
               (create-set (remove-str (first los)(rest los))))]))
; remove-str: String List-of-strings  -> List-of-strings
; cuts out the given s from the given los
(check-expect (remove-str "a" '()) '())
(check-expect (remove-str "1" (list "1" "2" "3")) (list "2" "3"))

(define (remove-str s los)
  (cond [(empty? los) '()]
        [else
         (if (string=? s (first los))
             (remove-str s (rest los))
             (cons (first los) (remove-str s (rest los))))]))

; select-album-titles/unique: LTrack -> List-of-strings
; produces a list of unique album titles as a los
(check-expect (select-album-titles/unique LT2)
              (list
               "Skeleton Tree"
               "Live in Copenhagen"))

(define (select-album-titles/unique lt)
  (create-set (select-all-album-titles lt)))

;(select-album-titles/unique
; (read-itunes-as-tracks ITUNES-LOCATION))





