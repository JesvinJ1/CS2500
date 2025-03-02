;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9:26notes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; A MoonPosition (MP) is one of:
;; - "waiting"
;; - Number
;; - #true
;; Interpretation:
;; "waiting" means we are waiting for a key to be pressed
;; a number means the moon is moving, and is at the given x coordinate
;; #true means the moon has crossed the sky

(define MP-W "waiting")
(define MP-1 1)
(define MP-T #true)

(define (mp-temp mp)
  (cond [(string? mp) (... mp ...)]
        [(number? mp) (... mp ...)]
        [(boolean? mp) (... mp ...)]))

;; moon-run : MP -> MP
;; Purpose Statement: animates a moon moving across the sky with key input
#;(define (moon-run mp)
  (big-bang mp
    [to-draw draw-moon]
    [on-key key-moon]
    [on-tick tick-moon]))

(define WIDTH 800)
(define HEIGHT 300)
(define SKY (rectangle WIDTH 300 "solid" "sky blue"))
(define MOON (circle 30 "solid" "gray"))

;; draw-moon : MP -> Image
;; draws the moon at the correct position
(check-expect (draw-moon MP-W)
              (place-image MOON
                           0
                           (/ HEIGHT 2)
                           SKY))           
(check-expect (draw-moon 100)
              (place-image MOON
                           100
                           (/ HEIGHT 2)
                           SKY))
(check-expect (draw-moon MP-T)
              (overlay (text "Done!" 36 "black")
                       SKY))
(define (draw-moon mp)
   (cond [(string? mp) (place-image MOON
                           0
                           (/ HEIGHT 2)
                           SKY)]
        [(number? mp) (place-image MOON
                                   mp
                                   (/ HEIGHT 2)
                                   SKY)]
        [(boolean? mp) (place-image MOON
                                    mp
                                    (/ HEIGHT 2)
                                    SKY)]))

;; key-moon : MP KeyEvent -> MP
;; Purpose Statement: starts a "waiting" MP moving on the left side of the screen
(check-expect (key-moon MP-W "e") MP-1)
(check-expect (key-moon MP-1 "w") MP-1)
(check-expect (key-moon MP-T "w") MP-T)
(define (key-moon mp ke)
    (cond [(string? mp) MP-1]
        [(number? mp) mp]
        [(boolean? mp) mp]))

;; move-moon : MP -> MP
;; moves a moving moon across the screen
(check-expect (move-moon MP-W) MP-W)
(check-expect (move-moon MP-1) 6)
(check-expect (move-moon MP-T) MP-T)
(check-expect (move-moon 800) MP-T)
(define (move-moon mp)
   (cond [(string? mp) mp]
        [(number? mp) (if (< mp WIDTH)
                       (+ 5 mp)
                       MP-T)]
        [(boolean? mp) mp]))