;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-083-render-editor) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Constans:

(define WIDTH 200)
(define HEIGHT 20)

(define MTS (empty-scene WIDTH HEIGHT))

(define CURSOR (rectangle 1 20 "solid" "red"))

(define TEXT-SIZE 16)
(define TEXT-COLOR "black")

; Data definition:

(define-struct editor [pre post])
; An Editor is a structure:
;   (make-editor String String)
; interpretation (make-editor s t) describes an editor
; whose visible text is (string-append s t) with 
; the cursor displayed between s and t

(define E0 (make-editor "" ""))
(define E1 (make-editor "" "helloworld"))
(define E2 (make-editor "hello" "world"))
(define E3 (make-editor "hel" "lo world"))


; Function:

; render: Editor -> Image
; place the given text and the cursor on MTS
(check-expect (render E0)
              (overlay/align "left" "center"
                             (beside (text "" 16 "")
                                     CURSOR
                                     (text "" 16 ""))
                             MTS))
(check-expect (render (make-editor "" "helloworld"))
              (overlay/align "left" "center"
                             (beside (text "" 16 "balck")
                                     CURSOR
                                     (text "helloworld" 16 "black"))
                             MTS))
(check-expect (render E2)
              (overlay/align "left" "center"
                             (beside (text "hello" 16 "black")
                                     CURSOR
                                     (text "world" 16 "black"))
                             MTS))


(define (render ed)
  (overlay/align "left" "center"
                 (beside (text (editor-pre ed) TEXT-SIZE TEXT-COLOR)
                         CURSOR
                         (text (editor-post ed) TEXT-SIZE TEXT-COLOR))
  MTS))
           

