;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9:25notes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


(define-struct twoboats [x1 vx1 x2 vx2])
;; A TwoBoats is a (make-twoboats Number Number Number Number)
;; Interpretation: two boats racing towards each other:
;; - x1: is the x-position of the first boat in pixels from the left
;; - vx1: the x-velocity of the first boat in pixels/tick (sailing to right)
;; - x2: is the x-position of the second boat in pixels from the left
;; - vx2: the x-velocity of the second boat in pixels/tick (sailing to left)
(define TWOBOATS-1 (make-twoboats 100 10 500 20))

(define (twoboats-temp tb)
  (... (twoboats-x1 tb) ... (twoboats-vx1 tb)
       ... (twoboats-x2 tb) ... (twoboats-vx2 tb) ...))

;; collision : TwoBoats -> TwoBoats
;; simulate the boat collision
(define (collision tb)
  (big-bang tb
    [to-draw draw-twoboats]
    [on-tick move-twoboats]))


(define BOAT-1 (rectangle 10 5 "solid" "blue"))
(define BOAT-2 (rectangle 10 5 "solid" "red"))
(define Y-BOAT 150)
(define BACKGROUND (empty-scene 800 300))

;; draw-twoboats : TwoBoats -> Image
;; draws the two boats at the given x positions
(check-expect (draw-twoboats TWOBOATS-1)
              (place-image BOAT-1
                           100
                           Y-BOAT
                           (place-image BOAT-2
                                        500
                                        Y-BOAT
                                        BACKGROUND)))
(define (draw-twoboats tb)
  (place-image BOAT-1
               (twoboats-x1 tb) 
               Y-BOAT
               (place-image BOAT-2
                            (twoboats-x2 tb)
                            Y-BOAT
                            BACKGROUND)))

(define ACCELERATION 0.1)
;; move-twoboats : TwoBoats -> TwoBoats
;; move & accelerate the boats according to velocity & acceleration
(check-expect (move-twoboats TWOBOATS-1)
              (make-twoboats 110 10.1 480 20.1))
(define (move-twoboats tb)
  (make-twoboats (+ (twoboats-x1 tb) (twoboats-vx1 tb))
                 (+ (twoboats-vx1 tb) ACCELERATION)
                 (- (twoboats-x2 tb) (twoboats-vx2 tb))
                 (+ (twoboats-vx2 tb) ACCELERATION)))


;; A NUIDorFalse is one of:
;; - #false
;; - Natural Number
;; Interpretation: a student's NUID or #false if it is not known

(define NF #false)
(define N1 17)
(define N2 19388)

;; nuidorfalse : NUIDorFalse -> ?
(define (nuidorfalse-temp nf)
  (cond [(boolean? nf) ... nf ...]
        [(number? nf) ... nf ...]))

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
(define MP-t #true)

(define (mp-temp mp)
  (cond [(string? mp) ... mp ...]
        [(number? mp) ... mp ...]
        [(boolean? mp) ... mp ...]))

;; moon-run : MP -> MP
;; Purpose Statement: animates a moon moving across the sky with key input
(define (moon-run mp)
  (big-bang mp
    [to-draw draw-moon]
    [on-key key-moon]
    [on-tick tick-moon]))

;; draw-moon : MP -> Image

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
(check-expect (move-moon MP-1) 2)
(check-expect (move-moon MP-T) MP-T)
(define (move-moon mp)
   (cond [(string? mp) mp]
        [(number? mp) mp (+1 mp)]
        [(boolean? mp) mp]))

              