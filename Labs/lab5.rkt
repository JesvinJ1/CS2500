;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lab5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)
;; In this lab, you'll build a world program that:
;;
;; 1. When it launches, shows the message "Waiting..."
;; 2. When you click, displays two red triangles at the edge of the window,
;;    both pointing towards the pointer. The window should be an `(empty-scene DIM DIM)`
;;    where `DIM` is the constant defined below.
;; 3. If you move the mouse out of the window, display "Out of Bounds" until the next click (which restarts the game).

(define DIM 400)


;; Use the following world state for your program:

;; A MouseGame is one of:
;; - "waiting"
;; - Posn
;; - "out-of-bounds"
;; Interpretation: different possible states of a mouse game.
(define MGW "waiting")
(define MGP (make-posn 100 100))
(define MGO "out-of-bounds")

(define (mousegame-temp mg)
  (cond [(and (string? mg) (string=? mg "waiting")) ...]
        [(posn? mg) (... (posn-temp mg) ...)]
        [(and (string? mg) (string=? mg "out-of-bounds")) ...]))

;; We are also providing the following helper function to aid in your drawing:

(define TOP-ARROW (rotate 180 (triangle 30 "solid" "red")))
(define LEFT-ARROW (rotate -90 (triangle 30 "solid" "red")))
(define ARROW-PADDING 20)
(define BACKGROUND (empty-scene DIM DIM))

;; draw-arrows : Posn -> Image
;; draws two red triangles on top of a DIM x DIM empty scene
(check-expect (draw-arrows (make-posn 100 100))
              (place-image TOP-ARROW
                           100
                           ARROW-PADDING
                           (place-image LEFT-ARROW
                                        ARROW-PADDING
                                        100
                                        BACKGROUND)))
(check-expect (draw-arrows (make-posn 30 100))
              (place-image TOP-ARROW
                           30
                           ARROW-PADDING
                           (place-image LEFT-ARROW
                                        ARROW-PADDING
                                        100
                                        BACKGROUND)))
(define (draw-arrows p)
  (place-image TOP-ARROW
               (posn-x p)
               ARROW-PADDING
               (place-image LEFT-ARROW
                            ARROW-PADDING
                            (posn-y p)
                            BACKGROUND)))

;;! Problem 1

;; Design a function `draw-mouse-game` that draws the current state of the Mouse Game.

;; Estimated Portion of Lab: 35%
;; draw-mouse-game : Mouse-Game -> image
;; draws the state of the mouse game
(check-expect (draw-mouse-game "waiting") (place-image (text "Waiting" 100 "black")
                                                                     200 200 BACKGROUND))
(check-expect (draw-mouse-game "out-of-bounds") (place-image (text "out-of-bounds" 100 "black")
                                                                     200 200 BACKGROUND))

(define (draw-mouse-game mg)
(cond [(and (string? mg) (string=? mg "waiting")) (place-image (text "Waiting" 100 "black")
                                                                     200 200 BACKGROUND)]
        [(posn? mg) (draw-arrows mg)]
        [(and (string? mg) (string=? mg "out-of-bounds")) (place-image (text "out-of-bounds" 100 "black")
                                                                     200 200 BACKGROUND)]))

;; STOP AND SWITCH WHO IS TYPING. CODE WALKS WILL BEGIN NOW!

;;! Problem 2

;; Design a function, `handle-mouse`, that takes the current state, x
;; coordinate of mouse event, y coordinate of mouse event, and the mouse event
;; itself. It should move the position if the mouse is moving and in the Posn
;; state, change the state to out-of-bounds if the mouse leaves the window, and
;; start the game on mouse click. The game should start at whatever position was
;; clicked.

;; Estimated Portion of Lab: 50%

;; handle-mouse : MouseGame Number Number Mouse-Event -> MouseGame
;; determines the state of the world which is a mouse game based upon the current state

(define (handle-mouse currentstate x y mouse-event)
  (cond [(and (string? currentstate) (string=? currentstate "waiting") (mouse=? mouse-event "button-down")) (make-posn x y)]
        [(posn? currentstate) (make-posn x y)]
        [(and (string? currentstate) (string=? currentstate "out-of-bounds") (mouse=? mouse-event 'leave)) "out-of-bounds"]))

;;! Problem 3 

;; Write the main handler, `mouse-game`, that takes an initial game state and runs
;; `big-bang`.
;;
;; NOTE: run this in the interactions window, _not_ in the definitions, as if you submit to
;; the autograder with calls to big-bang, it will run forever and won't be able to process your submission.

;; Estimated Portion of Lab: 10%
(define (mouse-game inital-state)
  (big-bang inital-state
    [to-draw draw-mouse-game]
    [on-mouse handle-mouse]))