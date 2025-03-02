;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9:23notes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; Design a function invite? that determines if inviting a group of
;; five friends to an event will be "successful". An event is successful
;; if at least three of the friends can attend. Each friend has a name
;; and whether they are free or not.


(define-struct friend [name free?])
;; A Friend is a (make-friend String Boolean)
;; Interpretation: a friend who may attend a gathering, where:
;; - name is their name
;; - free? is whether they are free at the desired time
(define F1 (make-friend "Alice" #t))
(define F2 (make-friend "Bob" #f))
(define F3 (make-friend "Carol" #f))
(define F4 (make-friend "Diana" #t))
(define F5 (make-friend "Eve" #t))
(define F6 (make-friend "Frank" #f))
(define (friend-temp f)
  (... (friend-name f) ... (friend-free? f) ...))

(define-struct gathering [f1 f2 f3 f4 f5])
;; A Gathering is (make-gathering Friend Friend Friend Friend Friend)
;; Interpretation: a group of five friends invited to an event
(define G1 (make-gathering F1 F2 F3 F4 F5))
(define G2 (make-gathering F1 F2 F3 F4 F6))
(define (gathering-temp g)
  (... (friend-temp (gathering-f1 g))
   ... (friend-temp (gathering-f2 g))
   ... (friend-temp (gathering-f3 g))
   ... (friend-temp (gathering-f4 g))
   ... (friend-temp (gathering-f5 g))
   ...))


;; availability : Friend -> [0,1]
;; returns 0 if not free?, 1 if free?
(check-expect (availability F1) 1)
(check-expect (availability F2) 0)
(check-expect (availability F3) 0)
(define (availability f)
  (if (friend-free? f)
      1
      0)) 


;; invite? : Gathering -> Boolean
;; determines whether 3/5 or more friends are free?
(check-expect (invite? G1) #t)
(check-expect (invite? G2) #f)
(define (invite? g)
  (>= (+ (availability (gathering-f1 g))
         (availability (gathering-f2 g))
         (availability (gathering-f3 g))
         (availability (gathering-f4 g))
         (availability (gathering-f5 g)))
      3))

(require 2htdp/image)
(require 2htdp/universe)

;; Design a world simulation of two boats accelerating towards each
;; other and colliding

;; What do we need in the world state:
;; - x position of first boat
;; - x velocity of first boat
;; - x position of second boat
;; - x velocity of second boat


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
