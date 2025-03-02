;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |10:10 notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; add-ten-all : ListofNumbers -> ListofNumbers
;; adds 10 to each number in input
(check-expect (add-ten-all (cons 10 (cons 0 (cons 3 '()))))
              (cons 20 (cons 10 (cons 13 '()))))
(define (add-ten-all l)
  (add-to-all 10 l)
  #;(cond [(empty? l) '()]
        [(cons? l) (cons (+ 10 (first l))
                         (add-ten-all (rest l)))]))

;; add-hundred-all : ListofNumbers -> ListofNumbers
;; adss 100 to each number in input
(check-expect (add-hundred-all (cons 10 (cons 0 (cons 3'()))))
              (cons 110 (cons 100 (cons 103 '()))))
(define (add-hundred-all l)
  (add-to-all 100 l)
  #;(cond [(empty? l) '()]
        [(cons? l) (cons (+ 100 (first l))
                         (add-hundred-all (rest l)))]))

;; add-to-all : Number ListofNumbers -> ListofNumbers
;; adds the given number to each number in the list
(check-expect (add-to-all 10 (cons 10 (cons 0 (cons 3 '()))))
              (cons 20 (cons 10 (cons 13 '()))))

(check-expect (add-to-all 100 (cons 10 (cons 0 (cons 3'()))))
              (cons 110 (cons 100 (cons 103 '()))))
(define (add-to-all num l)
  (cond [(empty? l) '()]
        [(cons? l) (cons (+ num (first l))
                         (add-to-all num (rest l)))]))

;; sub-ten-all : ListofNumbers -> ListofNumbers
;; subtract 10 to each number in input
(check-expect (sub-ten-all (cons 10 (cons 0 (cons 3 '()))))
              (cons 0 (cons -10 (cons -7 '()))))

(define (sub-ten-all l)
  (add-to-all -10 l)
  #;(cond [(empty? l) '()]
        [(cons? l) (cons (- (first l) 10)
                         (sub-ten-all (rest l)))]))

;; mul-ten-all : ListofNumbers -> ListofNumbers
;; multiply each number in input by 10
(check-expect (mul-ten-all (cons 10 (cons 0 (cons 3 '()))))
              (cons 100 (cons 0 (cons 30 '()))))
(define (mul-ten-all l)
  (do-ten-all * l)
  #;(cond [(empty? l) '()]
        [(cons? l) (cons (* 10 (first l))
                         (mul-ten-all (rest l)))]))

;; do-ten-all : [Number Number -> Number] ListofNumbers -> ListofNumbers
(define (do-ten-all operator l)
  (cond [(empty? l) '()]
        [(cons? l) (cons (operator 10 (first l))
                         (do-ten-all operator (rest l)))]))