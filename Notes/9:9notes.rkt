;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9:9notes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define SKY-WIDTH 300)
(define SKY-HEIGHT 200)

(define RADIUS 25)

(define SUN (circle RADIUS "solid" "yellow"))
(define MOON (circle RADIUS "solid" "gray"))
(define SKY (rectangle SKY-WIDTH SKY-HEIGHT "solid" "light blue"))

(define DARKSKY
  (rectangle SKY-WIDTH
             SKY-HEIGHT
             "solid"
             "black"))

(define X-SUN (/ SKY-WIDTH 2))

(define (draw-eclipse x-moon)
 (place-image
  MOON
  x-moon
  (/ SKY-HEIGHT 2)
  (place-image SUN
               X-SUN
               (/ SKY-HEIGHT 2)
               (if (< (abs(- x-moon X-SUN)) 10)
               DARKSKY
               SKY))))

(animate draw-eclipse)

#true
#false

#t
#f


;; Vocab: check-expect
;; Grammar: (check-expect some-expression expected-value)
;; Semtantics: DrRacket will automatically run some-expression
;; and report an error if it does not produce expected-value


(check-expect (gonna-get-a-prize? 10) #false)
(check-expect (gonna-get-a-prize? 49) #false)
(check-expect (gonna-get-a-prize? 65) #true)
(check-expect (gonna-get-a-prize? 50) #true)


(define (gonna-get-a-prize? num-tickets)
  (<= 50 num-tickets))

;; Vocab: cond, else
;; Grammar:
;; (cond [test-1 answer-1]
;;       [test-2 answer-2]
;;       ...
;;       [test-n/else answer-n])
;; Semtantics: cond evalutes to the _first_
;; answer whose test evalutes to #true

(check-expect (sign 5) "positive")
(check-expect (sign -5) "negative")
(check-expect (sign 0) "zero")

(define (sign n)
  (cond [(< n 0) "negative"]
        [(> n 0) "positive"]
        [(= n 0) "zero"]))
      

(check-expect (temp->clothing -10) "snow suit")
(check-expect (temp->clothing 25) "coat")
(check-expect (temp->clothing 65) "sweater")
(check-expect (temp->clothing 80) "t-shirt")

(define (temp->clothing temp)
  (cond [(<= temp 0) "snow suit"]
        [(<= temp 50) "coat"]
        [(<= temp 70) "sweater"]
        [else "t-shirt"]))
            
(temp->clothing 30)


