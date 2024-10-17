;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-104-vehicals) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp")) #f)))
; An Automobile is (make-automobile Number String Number)
(define-struct automobile [seats plate consumption])
; interpretation look at Vehical


; A Van is (make-van Number String Number)
(define-struct van [seats plate consumption])
; interpretation look at Vehical

; A Bus is (make-bus Number String Number)
(define-struct bus [seats plate consumption])
; interpretation look at Vehical

; A SUV is (make-SUV Number String Number)
(define-struct SUV [seats plate consumption])
; interpretation look at Vehical

; A Vehical is (make-vehical Automobil Van Bus SUV)
(define-struct vehical [automobile van bus SUV])
; and represents a fleet of vehicals automobils, vans, buses and SUVs w/
; - seats means # of passangers to carry up,
; - plate mens licence plates #
; - consumption means fule consumption (mile pre gallon)

(define AUT1 (make-automobile 4 "SOX-FAN1" 26 ))
(define VAN1 (make-van 8 "SOX-FAN2" 30))
(define BUS1 (make-bus 12 "SOX-FAN3" 38))
(define SUV1 (make-SUV 5 "SOX-FAN4" 25 ))

(define VF1 (make-vehical AUT1 VAN1 BUS1 SUV1))

; vehical-temp: Vehical -> ...
(define (vehical-temp vl)
  (... (automobile-temp (automobile-seats vl)
                        (automobile-plate vl)
                        (automobile-consumption vl) ...)
       (van-temp (van-seats vl)
                 (van-palte vl)
                 (van-consumption vl) ...)
       (bus-temp (bus-seats vl)
                 (bus-palte vl)
                 (bus-consumption vl) ...)
       (SUV-temp (SUV-seats vl)
                 (SUV-plate vl)
                 (SUV-consumption vl) ...)))
