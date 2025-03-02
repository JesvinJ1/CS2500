;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |10:28 notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define X 1)
(define Y 3)

(define Z (local [(define X 10)
                  (define Y 20)]
            (local [(define X 30)]
              (+ X Y))))
(+ X Z)

;; Design recipe for local / list abstractions

;; Design a function add-3-to-all

;; add-3-to-all : [ListOf Number] -> [ListOf Number]
;; Adds 3 to every number in the list
(check-expect (add-3-to-all '()) '())
(check-expect (add-3-to-all (list 1 2 3)) (list 4 5 6))
(check-expect (add-3-to-all (list -5.5 0)) (list -2.5 3))

(define (add-3-to-all l)
  (local [;; add-3 : Number -> Number
          ;; adds 3 to the input
          (define (add-3 n)
            (+ 3 n))]
    ;; DELETE THSI IN FINAL CODE
    ;; (X Y) [X -> Y] [List-of X] -> [List-of Y]
    ;; X is Number
    ;; Y is Number
    ;; [Number -> Number] [List-of Number] -> [List-of Number]
    ;; END DELETE
    (map add-3 l))
    ;; ADVANCED VERSION:
  #;(map (lambda (n) (+ n 3)) l))

;; Four uses for local:

;; 1. Hiding helper functions
;; Example: add-3 above

;; 2. Using context
;; Example:
;; Design a function usd-> eur that converts a list of amount in
;; USD into a list of amount in EUR, it should take the current exchange rate.

;; 1 USD -> 0.92 EUR

;; usd->eur : [ListOf Number] Number -> [ListOf Number]
;; converts lists of amounts in USD to EUR using conversion rate
(check-expect (usd-eur (list 1 2 3) 1) (list 1 2 3))
(check-expect (usd-eur (list 1 10) 0.92) (list 0.92 9.2))
(define (usd-eur l rate)
  (local [;; convert : Number -> Number
          ;; convert USD amount to EUR amount
          (define (convert usd)
            (* usd rate))]
    ;; map: (X Y) [X ->  Y] [List-of X] -> [List-of Y]
    ;; X is Number
    ;; Y is Number
    (map convert l)))

;; 3. Clarify code

;; slope: Posn Posn -> Number
;; computes slope between two positions in cartesian plane
;(check-expect (slope (make-posn 0 0) (make-posn 1 2)) 2)
;(check-expect (slope (make-posn 1 1) (make-posn 2 1)) 0)
#;(define (slope p1 p2)
  (/ (- (posn-y p2) (posn-y p1))S
     (- (posn-x p2) (posn-x p1))))

;; 4. Efficiency

