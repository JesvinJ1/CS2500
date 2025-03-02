;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9:16notes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; Two types of programs:
;; - short-lived pprograms that compute some value:
;;   e.g., speeding? from lecture, lemonade-stand-n from HW
;;
;; - long-living programs, users can view and/or interact.
;;   e.g. eclipse or sunsets (animate ...)

;; To get _interaction_, we need big-bang:

;; To get that, need two things:

;; - world state: data that _changes_ as the program runs

;; - event handlers: functions that respond to both user interaction
;;   interaction (key presses, mouse movement), passage of time

;; Vocab: big-bang

;; Grammar:
;; (big-bang initial-world-state
;;   [to-draw your-draw-function]
;;   [on-tick your-tick-function]
;;   [on-key your-key-function]
;;   [stop-when predicate-to-determine-if-program-should-stop

;; Data Design:

(define GREEN (circle 50 "solid" "green"))
(define YELLOW (circle 50 "solid" "yellow"))
(define RED (circle 50 "solid" "red"))

;; A TrafficLightAlt is one of:
;; - 0
;; - 1
;; - 2
;; where 0 represents green, 1 represents yellow, and 2 represents red

;; A TrafficLight is one of:
;; - "green"
;; - "yellow"
;; - "red"

;; Interpretation: A traffic light will display one of the three colors
;; Examples: 
(define TL-GREEN "green")
(define TL-YELLOW "yellow")
(define TL-RED "red")
;; Template:
(define (trafficlight-temp tl)
  (cond [(string=? tl TL-GREEN)...]
        [(string=? tl TL-YELLOW)...]
        [(string=? tl TL-RED)...]))

;; We need: draw-tl, tick-tl

;; Signature: 
;; draw-tl : TrafficLight -> Image
;; Purpose Statement:
;; draws the trafficlight as a picture
;; Tests:
(check-expect (draw-tl TL-GREEN) GREEN)
(check-expect (draw-tl TL-YELLOW) YELLOW)
(check-expect (draw-tl TL-RED) RED)
;; Code:
(define (tick-tl tl)
  (cond [(string=? TL-GREEN GREEN)...]
        [(string=? TL-YELLOW YELLOW)...]
        [(string=? TL-RED RED)...]))

;; Signature:
;; tick-tl : TrafficLight -> TrafficLight
;; Purpose Statement:
;; cycle from green -> yellow -> red -> green
;; Tests:
(check-expect (tick-tl TL-GREEN) TL-YELLOW)
(check-expect (tick-tl TL-YELLOW) TL-RED)
(check-expect (tick-tl TL-RED) TL-GREEN)
;; Code:
(define (tick-tl tl)
  (cond [(string=? TL-GREEN TL-YELLOW)...]
        [(string=? TL-YELLOW TL-RED)...]
        [(string=? TL-RED TL-GREEN)...]))

; tl-simulation : TrafficLight -> TrafficLight
(define (tl-simulation initial-tl)
  (big-bang initial-tl
    [to-draw draw-tl]
    [on-tick tick-tl 1]))
