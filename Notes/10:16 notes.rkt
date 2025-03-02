;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |10:16 notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; add-10 : Number -> Number
; adds 10 to input
(check-expect (add-10 0) 10)
(check-expect (add-10 -20) -10)
(define (add-10 n)
  (+ 10 n))

; add-10-all : ListOfNumbers -> ListOfNumbers
; adds 10 to each number
(check-expect (add-10-all (list)) (list))
(check-expect (add-10-all (list 1 2 3)) (list 11 12 13))
(define (add-10-all l)
  (do-to-all add-10 l)
  #;(cond [(empty? l) '()]
        [(cons? l) (cons (add-10 (first l))
                         (add-10-all (rest l)))]))

; mul-100 : Number -> Number
; multiplies input by 100
(check-expect (mul-100 0) 0)
(check-expect (mul-100 2) 200)
(define (mul-100 n)
  (* n 100))

; mul-100-all : ListOfNumbers -> ListOfNumbers
; multiplies 100 by each number
(check-expect (mul-100-all (list)) (list))
(check-expect (mul-100-all (list 1 2 3)) (list 100 200 300))
(define (mul-100-all l)
  (do-to-all mul-100 l)
  #;(cond [(empty? l) '()]
        [(cons? l) (cons (mul-100 (first l))
                         (mul-100-all (rest l)))]))

;; [Number -> Number] [ListOf Number] -> [ListOf Number]

;; [String -> String] [ListOf String] -> [ListOf String]

; do-to-all : (X Y) [X -> Y] [ListOf X] -> [ListOf Y]
; does operation to all
(define (do-to-all operation l)
  (cond [(empty? l) '()]
        [(cons? l) (cons (operation (first l))
                         (do-to-all operation (rest l)))]))


;; hello : String -> String
;; adds "Hello " before the input
(check-expect (hello "Class") "Hello Class")
(define (hello s)
  (string-append "Hello " s))

;; hello-everyone : LoS -> LoS
;; adds "Hello " before every string
(check-expect (hello-everyone (list "Alice" "Bob")) (list "Hello Alice"
                                                          "Hello Bob"))
(define (hello-everyone l)
  (do-to-all hello l)
  #;(cond [(empty? l) l]
        [(cons? l) (cons (hello (first l))
                         (hello-everyone (rest l)))]))

;; goodbye : String -> String
;; produces "Goodbye NAME! See you soon" for NAME input
(check-expect (goodbye "Fundies") "Goodbye Fundies! See you soon")
(define (goodbye s)
  (string-append "Goodbye " s "! See you soon"))

;; goodbye-everyone : LoS -> LoS
;; produces "Goodbye NAME! See you soon" for every NAME in list
(check-expect (goodbye-everyone (list "Alice" "Bob"))
              (list "Goodbye Alice! See you soon"
                    "Goodbye Bob! See you soon"))
(define (goodbye-everyone l)
  (do-to-all goodbye l)
  #;(cond [(empty? l) l]
        [(cons? l) (cons (goodbye (first l))
                         (goodbye-everyone (rest l)))]))


;; But what is [ListOf X]

;; A ListofNumbers (LoN) is one of:
;; - '()
;; - (cons Number LoN)
;; Interpetation: a list of numbers
(define L0 '())
(define L1 (cons 10 L0))
(define L2 (cons -3 L1))
(define L3 (cons 0 L1))
(define (lon-temp lon)
  (cond [(empty? lon) ...]
        [(cons? lon) (... (first lon) ... (lon-temp (rest lon)) ...) ]))

;; A ListOfStrings (LoS) is one of:
;; - '()
;; - (cons String LoS)
;; Interpetation: a list of strings
(define SN0 '())
(define SN1 (cons "John" SN0))
(define SN2 (cons "Jane" SN1))
(define (sn-temp sn)
  (cond [(empty? sn) ...]
        [(cons? sn) (... (first sn) ... (sn-temp (rest sn)) ...) ]))

;; Can unify/abstract to single list definition:

;; A [ListOf X] is one of:
;; - '()
;; - (cons X [ListOf X])
;; Interpetation: a list of elements of type X
(define LX0 '())
(define LX1 (list 1 2 3))
(define LX2 (list "hello" "there"))
(define (list-temp l)
  (cond [(empty? l) ...]
        [(cons? l) (... (x-temp (first l))
                        ... (list-temp (rest l)) ...) ]))


;; This is fine: [ListOf [ListOf X]]

;; The above is _not_ the same as this:

;; A BadList is one of:
;; - '()
;; - (cons Any BadList)
(define BL1 (list 1 "string" #t))
