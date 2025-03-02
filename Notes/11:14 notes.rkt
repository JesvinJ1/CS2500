;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |11:14 notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; GENERATIVE RECURSION 2

;; Design a function "chunkify" that takes a list and a postive
;; interger and returns a list of lists, where each of the innter lists
;; has the specified size (expect possibly the last one)

;; chunkify : (X) [ListOf X] PosInt -> [ListOf [ListOf X]]
;; splits the input list into sublists each of the given length,
;; except possibly the last one
;; Tests:
(check-expect (chunkify '() 10) '())
(check-expect (chunkify (list 1 2) 10) (list (list 1 2)))
(check-expect (chunkify (list 1 2 3 4 5) 2) (list (list 1 2)
                                                  (list 3 4)
                                                  (list 5)))
(check-expect (chunkify (list 1 2 3 4 5 6 7 8 9 10) 2)
              (list (list 1 2)
                    (list 3 4)
                    (list 5 6)
                    (list 7 8)
                    (list 9 10)))
(check-expect (chunkify (list 1 2 3) 1) (list (list 1)
                                              (list 2)
                                              (list 3)))
;; Code:
(define (chunkify l n)
  (cond [(empty? l) '()]
        [(cons? l)
         (cons (take-n n l)
               (chunkify (drop-n n l)))]))

               
;; take-n : (X) PosInt [ListOf X] -> [ListOf X]
;; returns first n elements of the list, assuming there are n
;; Tests:
(check-expect (take-n 1 (list 1 2 3)) (list 1))
(check-expect (take-n 4 (list 1 2 3)) (list 1 2 3))
(check-expect (take-n 1 '()) '())
;; Code:
(define (take-n n l)
  (cond [(empty? l) '()]
        [(cons? l) (if (= n 1)
                       (list (first l))
                       (cons (first l)
                             (take-n (sub1 n) (rest l))))]))

;; rewrite take-n to take a Natural (can be 0) instead of a PostInt

;; drop-n : (X) PosInt [ListOf X] -> [ListOf X]
;; return the rest of the list after removing the first n elements,
;; or empty if there are not n elements
;; Tests:
(check-expect (drop-n 1 (list 1 2 3)) (list 2 3))
(check-expect (drop-n 4 (list 1 2 3)) '())
(check-expect (drop-n 1 '()) '())
;; Code:
