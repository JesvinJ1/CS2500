;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 10:6notes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; add-10 : Number -> Number
;; adds 10 to input
;; Tests:
(check-expect (add-10 0) 10)
(check-expect (add-10 -20) -10)
;; Code:
(define (add-10 n)
  (+ 10 n))

;; add-10-all : ListOfNumbers -> ListOfNumbers
;; adds 10 to each number
;; Tests:
(check-expect (add-10-all (list)) (list))
(check-expect (add-10-all (list 1 2 3)) (list 11 12 13))
;; Code:
(define (add-10-all l)
  (cond [(empty? l) '()]
        [(cons? l) (cons (+ 10 (first l))
                   (add-10-all (rest l)))]))

;; mul-100 : Number -> Number
;; multiples input by 100
;; Tests:
(check-expect (mul-100 0) 0)
(check-expect (mul-100 2) 200)
;; Code:
(define (mul-100 n)
  (* n 100))

;; mul-100-all : ListOfNumbers -> ListOfNumbers
;; multiplies 100 by each number
;; Tests:
(check-expect (mul-100-all (list)) (list))
(check-expect (mul-100-all (list 1 2 3)) (list 100 200 300))
;; Code:
(define (mul-100-all l)
  (do-to-all mul-100 l))
  #;(cond [(empty? l) '()]
        [(cons? l) (cons (* 100 (first l))
                   (mul-100-all (rest l)))])

;; do-to-all : [Number -> Number] ListOfNumbers -> ListOfNumbers
;; does operation to all
;; Tests:
;(check-expect (do-to-all (list)) (list))
;(check-expect (do-to-all (list 1 2 3)) (list 100 200 300))
;; Code:
(define (do-to-all operation l)
  (cond [(empty? l) '()]
        [(cons? l) (cons (operation (first l))
                   (do-to-all operation (rest l)))]))

