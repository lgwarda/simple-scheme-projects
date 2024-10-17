;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname ex-204-select-albums) (read-case-sensitive #t) (teachpacks ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "batch-io.rkt" "teachpack" "2htdp") (lib "itunes.rkt" "teachpack" "2htdp")) #f)))
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
(define LT2 (list T2 T3 T4))

; Functions:

; select-albums: LTrack -> List-of-ltracks
; produce a list of track, one per album
(check-expect (select-albums '()) '())
(check-expect (select-albums LT1) (list (list T1)))
(check-expect (select-albums LT2) (list (list T2 T3 T4)))

(define (select-albums lt)
  (select-albums-from (select-album-titles/unique lt) lt))

; select-albums-from: Los LTracks -> List-of-ltracks
; produce a list of list of tracks, one per unique title
(define (select-albums-from los ltr)
  (cond [(empty? los) '()]
        [else (cons (select-album (first los) ltr)
                    (select-albums-from (rest los) ltr))]))

; select-album: String LTrack -> LTrack
; produce the list of tracks from the given album
(define (select-album s lt)
  (cond [(empty? lt) '()]
        [else (if (string=? s (track-album (first lt)))
                  (cons (first lt) (select-album s (rest lt)))
                  (select-album s (rest lt)))]))

; select-all-album-titles: LTrack -> List-of-srings
; produce the list of all album titles as a los
(define (select-all-album-titles lt)
  (cond [(empty? lt) '()]
        [else
         (cons (track-album (first lt))
               (select-all-album-titles (rest lt)))]))

; create-set: List-of-strings -> List-of-string
; produce a list of strings without repeated enteries
(define (create-set los)
  (cond [(empty? los) '()]
        [else
         (cons (first los)
               (create-set (remove-str (first los)(rest los))))]))

; remove: String List-of-strings  -> List-of-strings
; removes the given string from the given list of strings
(define (remove-str s los)
  (cond [(empty? los) '()]
        [else
         (if (string=? s (first los))
             (remove-str s (rest los))
             (cons (first los) (remove-str s (rest los))))]))

; select-album-titles/unique: LTrack -> List-of-strings
; produces a list of unique album titles as a los
(define (select-album-titles/unique lt)
  (create-set (select-all-album-titles lt)))


