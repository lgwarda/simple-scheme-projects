; argue: Sentence -> Sentence
; yields the oppsite sentence 
; > (argue '(i like spinach))
; (i hate spinach)
; > (argue '(brocoli is awful))
; (broccili is greate)

(define (argue s)
  (if (empty? s)
      '()
      (se (opposite (first s))
          (argue (bf s)))))
; opposite: Word -> Word
; yields opposite word 
(define (opposite w)
  (cond [(equal? w 'like) 'hate]
        [(equal? w 'hate) ']
        [(equal? w 'wonderfull) 'terrible]
        [(equal? w 'terrible) 'wonderfull]
        [(equal? w 'greate) 'awful]
        [(equal? w 'awfull) 'great]
        [(equal? w 'teriffic) 'yucky]
        [(equal? w 'yucky) 'teriffic]
        [else  w]))

