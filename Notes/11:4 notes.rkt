;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |11:4 notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct branch [left right])
(define-struct leaf [])
(define-struct fruit [size ripe?])
;; A FruitTree is one of:
;; - (make-branch FruitTree FruitTree)
;; - (make-leaf)
;; - (make-fruit Number Boolean)
;; Interpretation: a fruit tree with leaves & fruit
(define FT0 (make-leaf))
(define FT1 (make-fruit 1 #t))
(define FT2 (make-branch FT0 FT0))
(define FT3 (make-branch FT0 FT1))
(define FT4 (make-branch (make-fruit 2 #f)
                         FT3))

(define (ft-temp ft)
  (cond [(branch? ft) (... (ft-temp (branch-left ft))
                           (ft-temp (branch-right ft)))]
        [(leaf? ft) ...]
        [(fruit? ft) (... (fruit-size ft)
                          ... (fruit-ripe ft)...)]))

;; ripen-fruit : FruitTree -> FruitTree
;; makes all fruit ripe
(check-expect (ripen-fruit FT0) FT0)
(check-expect (ripen-fruit FT1) FT1)
(check-expect (ripen-fruit FT4)
              (make-branch (make-fruit 2 #t)
                           FT3))

(define (ripen-fruit ft)
  (cond [(branch? ft)
         (make-branch (ripen-fruit (branch-left ft))
                      (ripen-fruit (branch-right ft)))]
        [(leaf? ft) ft]
        [(fruit? ft) (make-fruit (fruit-size ft) #t)]))

;; count-leaves : FruitTree -> Number
;; returns count of total leaves in tree
;; Tests:
(check-expect (count-leaves FT0) 1)
(check-expect (count-leaves FT1) 0)
(check-expect (count-leaves FT2) 2)
;; Code:
(define (count-leaves ft)
  (cond [(branch? ft)
         (+ (count-leaves (branch-left ft))
            (count-leaves (branch-right ft)))]
        [(leaf? ft) 1]
        [(fruit? ft) 0]))



;; Multiple Complex Inputs

;; lookup : String [ListOf String] [ListOf Number] -> [Maybe Number]
;; find number that matches string if it exists, return #f if no match
;; or there aren't enough numbers
;; Tests:
(check-expect (lookup "b" (list "a" "b" "c") (list 1 2 3)) 2)
(check-expect (lookup "b" (list "a" "b" "c") (list 1)) #f)
(check-expect (lookup "z" (list "a" "b" "c") (list 1 2 3)) #f)
;; Code:
(define (lookup s los lon)
  (cond [(and (empty? los) (empty? lon)) #f]
        [(and (empty? los) (cons? lon)) #f]
        [(and (cons? los) (empty? lon)) #f]
        [(and (cons? los) (cons? lon))
         (if (string=? s (first los))
             (first lon)
             (lookup s (rest los) (rest lon)))]))

;; list-append : (X) [ListOf X] [ListOf X] -> [ListOf X]
;; produces a list with all elements of first list, followed
;; by all elements of second list
;; Tests:
(check-expect (list-append (list) (list 1 2 3)) (list 1 2 3))
(check-expect (list-append (list 1 2 3) (list 4 5 6)) (list 1 2 3 4 5 6))
(check-expect (list-append (list 1 2 3) (list)) (list 1 2 3))
;; Code:
(define (list-append l1 l2)
  ;; sequential traversal
  (cond [(and (empty? l1) (empty? l2)) '()]
        [(and (empty? l1) (cons? l2)) l2]
        [(and (cons? l1) (empty? l2)) l1]
        [(and (cons? l1) (cons? l2))
         (cons (first l1)
               (list-append (rest l1) l2))]))


(define-struct pair [fst snd])
;; all-pairs : [ListOf Number] [ListOf Number] -> [ListOf [Pair Number]]
;; produces all combinations of first list with second list
(check-expect (all-pairs (list 1 2 3) (list 4 5 6))
              (list (make-pair 1 4) (make-pair 1 5) (make-pair 1 6)
                    (make-pair 2 4) (make-pair 2 5) (make-pair 2 6)
                    (make-pair 3 4) (make-pair 3 5) (make-pair 3 6)))
;; Code:
(define (all-pairs l1 l2)
   (map (lambda (n1)
          (map (lambda (n2)
                 (make-pair n1 n2)) l2) l1)))
