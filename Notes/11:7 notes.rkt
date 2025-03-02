;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |11:7 notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; mul-list : [ListOf Number] -> Number
;; multiples all the numbers in list, if empty returns 1
;; Tests:
(check-expect (mul-list '()) 1)
(check-expect (mul-list (list 1 2 3)) 6)
(check-expect (mul-list (list 0 1 2 3)) 0)
(define EX-L (cons 0 (build-list 10000 identity)))
;; Code:
(define (mul-list l)
  (cond [(empty? l) 1]
        [(cons? l) (if (zero? (first l))
                       0
                       (* (first l)
                          (mul-list (rest l))))]))

;; mul-greater-1000 : [ListOf Number] -> Boolean
;; is the product of all numbers in list greater than 1000
;; Tests:
(check-expect (mul-greater-1000 '()) #f)
(check-expect (mul-greater-1000 (list 1 2 3)) #f)
(define EX-L1 (build-list 100 (lambda (n) 2)))
(check-expect (mul-greater-1000 EX-L1) #t)
;; Code:
(define (mul-greater-1000 l0)
  (local [; mul-greater-1000/acc : Number [ListOf Number] -> Boolean
          ; given product thus far and remaining numbers to multiply,
          ; is product of all numbers greater than 1000
          (define (mul-greater-1000/acc prod l)
            (if (> prod 1000)
                #t
                (cond
                  [(empty? l) #f]
                  [(cons? l) (mul-greater-1000/acc (* (first l) prod)
                                                   (rest l))])))]
    (mul-greater-1000/acc 1 l0)))

;; cummulative-distance : [ListOf Number] -> [ListOf Number]
;; output a running sum up to each number
;; Tests:
(check-expect (cumulative-distance '()) '())
(check-expect (cumulative-distance (list 1 2 3)) (list 1 3 6))
(check-expect (cumulative-distance (list 10 2 20)) (list 10 12 32))
;; Code:
(define (cumulative-distance l0)
  (local [; cumulative-distance/acc : Number [ListOf Number] -> [ListOf Number]
          ; ACCUMULATOR: sum of numbers already seen
          (define (cumulative-distance/acc sum l)
            (cond [(empty? l) l]
                  [(cons? l) (cons (+ sum (first l))
                                   (cumulative-distance/acc (+ sum (first l))
                                                            (rest l)))]))]
    (cumulative-distance/acc 0 l0)))

;; ACCUMULATOR:
;; 1. What is it?
;; 2. What is the inital value?
;; 3. How does it change on recursive calls?
;; 4. How do you use it to solve problem