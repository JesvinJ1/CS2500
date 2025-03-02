;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9:12notes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; design a function speeding? that accepts a speed
;; of a car in mp4 and returns whether or not it is
;; speeding (over 70 mph)

;; A Speed is a non negative number
;; Interpretation: a speed in miles per hour
(define S0 0)
(define S15 15)
(define S87.2 87.2)
(define S130 130)

(define (speed-temp s)
  (... s ...))

;; speeeding? : Speed -> Boolean
;; determines whether the speed is greater than 70
(check-expect (speeding? S0) #f)
(check-expect (speeding? S15) #f)
(check-expect (speeding? S87.2) #t)
(check-expect (speeding? S130) #t)
(define (speeding? s)
  (>= s 70))

;; ------------

;; A MACounty is one of:
;; - "Suffolk"
;; - "Middlesex"
;; - "Essex"
;; Interpretation: Some of the counties of the commonwealth of massachussets
;; Examples:
(define SUFFOLK "Suffolk")
(define MIDDLESEX "Middlesex")
(define ESSEX "Essex")
;; Template:
(define (MACounty-temp c)
  (cond [(string=? c SUFFOLK)...]
        [(string=? c MIDDLESEX)...]
        [(string=? c ESSEX)...]))

;; ---------

;; is a particular county highly-educated?
;; threshold of doctorate degrees above 5%
;; Suffolk: 6.9%
;; Middlesex: 9.2%
;; Essex: 4.1%
;; Design the predicate highly-educated? that takes a MACounty
;; and returns whether percent of doctorates is above 5%

;; Signature: highly-educated? : MACounty -> Boolean
;; Purpose Statement: The function determines if a county's percent of doctorates is above 5%
;; Tests:
(check-expect (highly-educated? SUFFOLK) #t)
(check-expect (highly-educated? MIDDLESEX) #t)
(check-expect (highly-educated? ESSEX) #f)
;; Code:
(define (highly-educated? c)
  (cond [(string=? c SUFFOLK) #t]
        [(string=? c MIDDLESEX) #t]
        [(string=? c ESSEX) #f]))

;; Vocab: big-bang
;; Grammar:
;; (big-bang initial-state
;;   [to-draw function-that-draws-the-state]
;;   [event-type handler-that-you-write]
;;   ....)
;; Semtantics; big-bang launches an interactive program
;; it starts with the initial state
;; and draws the state with function-that-draws-the-state
;; the event handlers react to things in the world and update
;; the state. After each update, the world is re-drawn

(define SKY-WIDTH 300)
(define SKY-HEIGHT 200)

(define RADIUS 25)

(define SUN (circle RADIUS "solid" "yellow"))
(define MOON (circle RADIUS "solid" "gray"))
(define SKY (rectangle SKY-WIDTH SKY-HEIGHT "solid" "light blue"))

(define (draw-eclipse x-moon)
 (place-image
  MOON
  x-moon
  (/ SKY-HEIGHT 2)
  (place-image SUN
               (/ SKY-WIDTH 2)
               (/ SKY-HEIGHT 2)
               SKY)))

;; eclipse-tic : Natural -> Natural
(define (eclipse-tick x-moon)
  (+ x-moon 1))

;; eclipse-key : Natural KeyEvent -> Natural
(define (eclipse-key x-moon key)
  0)

(big-bang 0
     [to-draw draw-eclipse]
     [on-tick eclipse-tick]
     [on-key eclipse-key])