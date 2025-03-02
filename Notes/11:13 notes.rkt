;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |11:13 notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define L (cons 1 (cons 2 (cons 3 '()))))

(define (list-temp l)
  (cond [(empty? l) ...]
        [(cons? l) (... (first l)
                        ... (list-temp l)
                        ...)]))

;; GENERATIVE RECURSION

;; 1. Can you solve the problem structurally?

;; 2. Is the structural solution bad?
;;    - the code could be hard to read
;;    - the code could be very slow

;; Generative Recusion Function Design Recipe

;; 1. Signature -- same
;; 2. Purpose -- Same
;; 3. Tests -- you should write more
;; 4. Code --
;;    (define (solve-problem inp)
;;     (cond [(trivial? inp) ...]
;;           ...
;;           [(non-trivial? inp)
;;              (combine
;;                (solve-problem (transform1 inp))
;;                ...
;;                (solve-problem (transformN inp))

;; Problem: sort a list of numbers

;; 2500sort/s : [ListOf Number] -> [ListOfNumber]
;; returns the input list in ascending order
(check-expect (2500sort/s '()) '())
(check-expect (2500sort/s (list 1 2 5 4)) (list 1 2 4 5))
(check-expect (2500sort/s (list 3 2 1)) (list 1 2 3))

(define (2500sort/s l)
  (local [;; insert : Number [ListOf Number] -> [ListOf Number]
          ;; given a number and a sorted list of numbers,
          ;; places number in sorted list at correct place to
          ;; maintain order
          (define (insert n lon)
            (cond [(empty? lon) (list n)]
                  [(cons? lon) (if (<= n (first lon))
                                   (cons n lon)
                                   (cons (first lon)
                                         (insert n (rest lon))))]))]
    (cond [(empty? l) l]
          [(cons? l) (insert (first l)
                             (2500sort/s (rest l)))])))

;; SMALLER-NUMBERS x BIGGER-NUMBERS
(check-expect (2500sort/g '()) '())
(check-expect (2500sort/g (list 1 2 5 4)) (list 1 2 4 5))
(check-expect (2500sort/g (list 3 2 1)) (list 1 2 3))

(define (2500sort/g l)
  (cond [(empty? l) '()]
        [(cons? l)
         (local [(define PIVOT (first l))
                 (define SMALLER (filter (lambda (x) (< x PIVOT)) l))
                 (define BIGGER (filter (lambda (x) (> x PIVOT)) l))]
           (append (2500sort/g SMALLER)
                   (list PIVOT)
                   (2500sort/g BIGGER)))]))

