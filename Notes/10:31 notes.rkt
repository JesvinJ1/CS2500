;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |10:31 notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; do-add-thing : [Number -> Number] Number -> Number
; applies first argument to second argument
(check-expect (do-number-thing add1 10) 11)
(check-expect (do-number-thing (lambda (x) (+ 3 x)) 1) 4)

(define (do-number-thing operation n)
  (operation n))

; make-adder : Number -> [Number -> Number]
; given a number, returns a function that adds that number to its input
;(check-expect (make-adder 1) add1)
;(check-expect (make-adder 3) (lambda (x) (+ 3 x)))

(define (make-adder n)
  (lambda (x) (+ x n))
  #;(local [; add-n : Number -> Number
            ; adds n to the input
            (define (add-n x)
              (+ x n))]
      add-n))

(define add2 (make-adder 2))
(define add3 (make-adder 3))

(check-expect (add3 0) ((lambda (x) (+ x 3)) 0))

; Trees! (or in this case, River networks)

(define-struct merge [width left right])
(define-struct stream [flow-rate])
;; A River is one of:
;; - (make-merge Number
;; Interpretation: a network of streams flowing into larger and larger rivers

(define R0 (make-stream 1))
(define R1 (make-merge 10 R0 R0))
(define R2 (make-merge 20 R1 R0))
(define R3 (make-merge 30 R2 R2))

(define (river-temp r)
  (cond [(merge? r) (... (merge-width r)
                         ... (river-temp (merge-left r))
                         ... (river-temp (merge-right r)))]
        [(stream? r) (... (stream-flow-rate r) ...)]))

;; total-volume : River -> Number
(define (total-volume r)
  (cond [(merge? r) (+ (total-volume (merge-left r))
                       (total-volume (merge-right r)))]
        [(stream? r) (stream-flow-rate r)]))

; num-merges : River -> Number
; return number of merges in river
(define (num-merges r)
  (cond [(merge? r) (+ 1
                       (num-merges (merge-left r))
                       (num-merges (merge-right r)))]
        [(stream? r) 0]))