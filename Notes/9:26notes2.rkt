;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9:26notes2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

(define-struct crash [x v])
;; A Creash is a (make-crash x v)
;; - x is the position of the crash in pixels from the left
;; - v is the velocity of the crash in pixels moving right
(define CRASH-0 (make-crash 100 5))
(define CRASH-1 (make-crash 300 -5))
(define CRASH-2 (make-crash 400 0))
(define (crash-temp c)
(... (crash-x c)
       ... (crash-v c)
       ...))
(define-struct twoboats [x1 vx1 x2 vx2])
;; A TwoBoats is a (make-twoboats Number Number Number Number)
;; Interpretation: two boats racing towards each other:
;; - x1: is the x-position of the first boat in pixels from the left
;; - vx1: the x-velocity of the first boat in pixels/tick (sailing to right)
;; - x2: is the x-position of the second boat in pixels from the left
;; - vx2: the x-velocity of the second boat in pixels/tick (sailing to left)
(define TWOBOATS-0 (make-twoboats 50 0 750 0))
(define TWOBOATS-1 (make-twoboats 100 6 500 5))

(define (twoboats-temp tb)
  (... (twoboats-x1 tb)
       ... (twoboats-vx1 tb)
       ... (twoboats-x2 tb)
       ... (twoboats-vx2 tb)
       ...))

;; A CollisionSIM (CS) is one of:
;; - TwoBoats
;; - Crash
;; Interpretation: a two boat simuilation that is either moving or crashed
(define CS-0 CRASH-0)
(define CS-1 TWOBOATS-1)
  
(define (cs-temp cs)
  (cond [(crash? cs) (... (crash-temp cs) ...)]
        [(twoboats? cs) (... (twoboats-temp cs) ...)]))

;; collision : CS -> CS
;; simulate the boat collision
(define (collision init-cs)
  (big-bang init-cs
    [to-draw draw-cs]
    [on-tick move-twoboats]))

(define BOAT-1 (rectangle 10 5 "solid" "blue"))
(define BOAT-2 (rectangle 10 5 "solid" "red"))
(define CRASH (rectangle 20 10 "solid" "purple"))
(define Y-BOAT 150)
(define BACKGROUND (empty-scene 800 300))

;; draw-cs : CS -> Image
;; Purpose Statement: renders either moving boats or a crash
(check-expect (draw-cs CS-1
              (place-image BOAT-1
                           100
                           Y-BOAT
                           (place-image BOAT-2
                                        500
                                        Y-BOAT
                                        BACKGROUND))))
(check-expect (draw-cs CS-0)
              (place-image CRASH
                           100
                           Y-BOAT
                           BACKGROUND))
(define (cs-temp cs)
  (cond [(crash? cs) (draw-crash cs)]
        [(twoboats? cs) (draw-twoboats cs)]))

;; draw-crash : Crash -> Image
;; renders a crashed pair of boats
(check-expect (draw-crash CRASH-0)
              (place-image CRASH
                           100
                           Y-BOAT
                           BACKGROUND))
(define (draw-crash c)
  (place-image CRASH
               100
               Y-BOAT
               BACKGROUND))

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

;; move-cs : CS -> CS
;; moves the two boats or crash
(check-expect (move-cs CS-0)
              (make-crash 105 5))
(check-expect (move-cs CS-1)
              (make-twoboats 106 7 495 6))
;; Task: write definition of move-cs
(define (move-cs c)
  (cond [(crash? cs) (move-crash cs)]
        [(twoboats? cs) (move-twoboats cs)]))

;; move-crash : Crash -> Crash
(check-expect (move-cs CRASH-0)
              (make-crash 105 5))
(define (move-crash c))
   
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