;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ex-087-editor-3) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")) #f)))
; Constans:

(define WIDTH 200)
(define HEIGHT 20)

(define MTS (empty-scene WIDTH HEIGHT))

(define CURSOR (rectangle 1 20 "solid" "red"))

(define TEXT-SIZE 16)
(define TEXT-COLOR "black")

; Data definition:

(define-struct editor [str idx])
; An Editor is a structure:
;   (make-editor String Number)
; interp. str is text with the cursor displayed at index i

(define E0 (make-editor "" 0))                                       ; [|            ]       
(define E1 (make-editor "heloworld" 5))                              ; [hello|world  ]  
(define E2 (make-editor "hello world"(string-length "hello world"))) ; [hello world| ]


; Functions:

; render: Editor -> Image
; place the given text and the cursor on MTS
(check-expect (render (make-editor "" 0))
              (overlay/align "left" "center"
                             (beside (text "" 16 "balck")
                                     CURSOR
                                     (text ""  16 "balck"))
                             MTS))

(check-expect (render (make-editor "hello world" 0))
              (overlay/align "left" "center"
                             (beside (text "" 16 "balck")
                                     CURSOR
                                     (text "hello world" 16 "balck"))
                             MTS))

(check-expect (render (make-editor "hello world" 5))
              (overlay/align "left" "center"
                             (beside (text "hello" 16 "balck")
                                     CURSOR
                                     (text " world" 16 "balck"))
                             MTS))

(check-expect (render E2)
              (overlay/align "left" "center"
                             (beside (text "hello world" 16 "balck")
                                     CURSOR
                                     (text ""  16 "balck"))
                             MTS))

(define (render ed)
  (overlay/align "left" "center"
                 (beside (text (editor-pre ed) TEXT-SIZE TEXT-COLOR)
                         CURSOR
                         (text (editor-post ed) TEXT-SIZE TEXT-COLOR))
                 MTS))
; Editor -> String
; produce  pre str determined by idx position
(check-expect (editor-pre (make-editor "hello" 0)) "")
(check-expect (editor-pre (make-editor "hello"
                                       (string-length "hello"))) "hello")
(check-expect (editor-pre (make-editor "hello world" 5)) "hello")

(define (editor-pre ed)
  (substring (editor-str ed) 0 (editor-idx ed)))

; Editor -> String
; produce  post str determined by idx position
(check-expect (editor-post (make-editor "hello" 0)) "hello")
(check-expect (editor-post (make-editor "hello"
                                        (string-length "hello"))) "")
(check-expect (editor-post (make-editor "hello!" 5)) "!")

(define (editor-post ed)
  (substring (editor-str ed) (editor-idx ed) (string-length (editor-str ed))))

; edit: Editor KeyEvent -> Editor
; add or delete a char and move the cursor form one and the other side
(check-expect (edit (make-editor "hello" 3) "left")
              (make-editor "hello" 2))
(check-expect (edit (make-editor "hello" 4) "right")
              (make-editor "hello" 5))
(check-expect (edit (make-editor "hello" 5) "!")
              (make-editor "hello!" 6))

(check-expect (edit (make-editor "hello!" 6) "\b")
              (make-editor "hello" 5))

(check-expect (edit (make-editor "hello!" 6) "\r")
              (make-editor "hello!" 6))

(check-expect (edit (make-editor "hello!" 6) "\t")
              (make-editor "hello!" 6))
(check-expect (edit (make-editor "hello!" 6) "up")
              (make-editor "hello!" 6))


(define (edit ed ke)
  (cond[(key=? ke "left") (cursor-l ed)]
       [(key=? ke "right") (cursor-r ed)]
       [(key=? ke "\b") (delete-l ed)]
       [(key=? ke "\r") ed]
       [(key=? ke "\t") ed]
       [(equal? (string-length ke) 1)
        (add-char-limit ed ke)]
       [else ed]))
      

; cursor-l : Editor -> Editor
; move the cursor left 
(check-expect (cursor-l (make-editor "hello" 3)) (make-editor "hello" 2))
(check-expect (cursor-l (make-editor "hello" 0)) (make-editor "hello" 0))

(define (cursor-l ed)
  (cond [(zero? (editor-idx ed)) ed]
        [else
         (make-editor (editor-str ed) (- (editor-idx ed) 1))]))

; string-last: String -> String
; produce the last character from the given str
(check-expect (string-last "hello") "o")

(define (string-last str)
  (substring str (- (string-length str) 1)))


; cursor-r : Editor -> Editor
; move the cursor right
(check-expect (cursor-r (make-editor "hello" 0)) (make-editor "hello" 1))
(check-expect (cursor-r (make-editor "hello" (string-length "hello")))
              (make-editor "hello" (string-length "hello")))

(define (cursor-r ed)
  (cond [(= (editor-idx ed) (string-length (editor-str ed))) ed]
        [else
         (make-editor (editor-str ed) (+ (editor-idx ed) 1))]))

; string-first: String -> 1-String
; produce the first character from the given str
(check-expect (string-first "hello") "h")

(define (string-first str)
  (substring str 0 1))

; string-rest: String -> String
; produce the given a str without the 1st character from the non empty str
(check-expect (string-rest "hello") "ello")

(define (string-rest s)
  (substring s 1 (string-length s)))

; delete-l: Editor -> Editor
; delete character to the left
(check-expect (delete-l (make-editor "hello" 3)) (make-editor "helo" 2))
(check-expect (delete-l (make-editor "hello" 0)) (make-editor "hello" 0))

(define (delete-l ed)
  (cond [(zero? (editor-idx ed))  ed]
        [else
         (make-editor (string-append (string-remove-last (editor-pre ed))
                                     (editor-post ed))
                      (sub1 (editor-idx ed)))]))

; string-remove-last: String -> String
; remove the last char from the given non empty string
(check-expect (string-remove-last "hello!") "hello")

(define (string-remove-last str)
  (substring str 0 (sub1 (string-length str))))

; add-char: Editor 1Srting -> Editor
; add 1String to the right of the Cursor
(check-expect (add-char (make-editor "hello" 3) "d")
              (make-editor "heldlo" 4))

(define (add-char ed char)
  (make-editor (string-append (editor-pre ed) char (editor-post ed))
               (add1 (editor-idx ed))))

; add-char-limit: Editor 1String -> Editor
; add 1Srting to Editor until reach very right edge

(define (add-char-limit ed char)
  (cond [(> (image-width (render (add-char ed char))) WIDTH) ed]
        [else (add-char ed char)]))
           


; run: Editor -> Editor
; start with: (run (make-editor "Hello Cham!" 0))
(define (run ed)
  (big-bang ed                 
    (to-draw   render)   
    (on-key    edit)))   

(run (make-editor "Hello Cham!" 0))