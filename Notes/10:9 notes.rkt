;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |10:9 notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Abstraction Recipe:

;; 1. Circle differences of two functions that seem similar
;; 2. Copy one function, giving it a new name, renaming recursive calls
;; 3. Add argument(s) replacing part that was different
;; 4. Rewrite existing functions to use new function

;; hello-everyone : LoS -> LoS
;; adds "Hello " before every string
;; Tests elided
#;(define (hello-everyone l)
  (greet-everyone "Hello " "" l)
  #;(cond [(empty? l) l]
        [(cons? l) (cons (string-append "Hello " (first l))
                         (hello-everyone (rest l)))]))

;; goodbye-everyone : LoS -> LoS
;; produces "Goodbye NAME! See you soon" for every NAME in list
(define (goodbye-everyone l)
  (greet-everyone "Goodbye " "! See you soon" l)
  #;(cond [(empty? l) l]
        [(cons? l) (cons (string-append "Goodbye " (first l) "! See you soon")
                         (goodbye-everyone (rest l)))]))


;; greet-everyone : String String LoS -> LoS
(define (greet-everyone before after l)
  (cond [(empty? l) l]
        [(cons? l) (cons (string-append before (first l) after)
                         (greet-everyone before after (rest l)))]))

;; (replicate-all n los) applies (replicate n s) to every string s in los. (define (replicate-all n los)
(define (replicate-all n los)
  (cond
    [(empty? los)
     '()]
    [(cons? los)
     (cons (replicate n (first los)) (replicate-all n (rest los)))]))

(check-expect (replicate-all 2 '()) '())
(check-expect (replicate-all 1 (cons "hi" '())) (cons "hi" '()))
(check-expect (replicate-all 3 (cons "hi" '())) (cons "hihihi" '()))

;; hello-everyone : LOS -> LOS (define (hello-everyone los)
(define (hello-everyone los)
  (cond
    [(empty? los)
     '()]
    [(cons? los)
     (cons (string-append "Hello " (first los)) (hello-everyone (rest los)))]))

(check-expect (hello-everyone '()) '())
(check-expect (hello-everyone (cons "Alice" (cons "Bob" '())))
              (cons "Hello Alice" (cons "Hello Bob" '())))


;; Will not run in BSL:
#;(define (do-something-everyone operation n los)
  (cond
    [(empty? los)
     '()]
    [(cons? los)
     (cons (operation n (first los)) (hello-everyone (rest los)))]))
