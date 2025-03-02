;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |10:23 notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; Wheel of Fortune Game - big bang program

;; There is a secret word, plater guesses letters that get revealed when they are correct


(define-struct guessed [letter])
(define-struct unguessed [letter])
; A Game1String is one of:
; - (make-guessed 1String)
; - (make-unguessed 1String)
; a 1String is a single character string, either guessed or still hidden

(define G1S-1 (make-guessed "a"))
(define G1S-2 (make-unguessed "a"))

(define (g1s-temp g)
  (cond [(guessed? g) (... (guessed-letter g) ...)]
        [(unguessed? g) (... (unguessed-letter g) ...)]))

; A WorldOfFortune is a [ListOf Game1String]
; Interpretation: current state of the game

(define WOF-0 (list (make-unguessed "h")
                    (make-unguessed "e")
                    (make-unguessed "l")
                    (make-unguessed "l")
                    (make-unguessed "o")))
(define WOF-1 (list (make-unguessed "h")
                    (make-unguessed "e")
                    (make-guessed "l")
                    (make-guessed "l")
                    (make-unguessed "o")))
(define WOF-2 (list (make-unguessed "h")
                    (make-unguessed "e")
                    (make-guessed "l")
                    (make-guessed "l")
                    (make-guessed "o")))
(define WOF-3 (list (make-guessed "h")
                    (make-unguessed "e")
                    (make-guessed "l")
                    (make-guessed "l")
                    (make-guessed "o")))
(define WOF-4 (list (make-guessed "h")
                    (make-guessed "e")
                    (make-guessed "l")
                    (make-guessed "l")
                    (make-guessed "o")))
;... WOF-1 through WOF-4 will be games with progressively more letter guessed

; guessing-game : String -> WoF
; runs a game using strign input
;(define (guessing-game s)
#;(big-bang (map make-ungussed (explode s)
                 [to-draw draw-game]
                 [on-key key-game]
                 [stop-when all-guessed? draw-game]))

;; guess-key : Gmae1String -> Game1Strings


;; key-game : WoF KeyEvent -> WoF
(define (key-game w ke)
  (local [
          (define (guess-key g)
            (cond [(guessed? g) g]
                  [(unguessed? g) (if (string=? (unguessed-letter g) ke)
                                      (make-guessed (unguessed-letter g))
                                      g)]))]))
(define TEXT-SIZE 20)
(define TEXT-COLOR "black")

;; draw-game : WoF -> Image
;; draws the letters, with underscores for unknown
;; Tests:
(check-expect (draw-game WOF-0) (text "_____" TEXT-SIZE TEXT-COLOR))
(check-expect (draw-game WOF-4) (text "hello" TEXT-SIZE TEXT-COLOR))
(check-expect (draw-game WOF-1) (text "__ll_" TEXT-SIZE TEXT-COLOR))
;; Code:
(define (draw-game w)
  (text (get-rendered-text w) TEXT-SIZE TEXT-COLOR))

;; get-rendered-text : WoF -> String
;; returns a string where unguessed show up as _, guessed as letters
(check-expect (get-rendered-text WOF-0) "_____")
(check-expect (get-rendered-text WOF-1) "__ll_")
(check-expect (get-rendered-text WOF-0) "hello")

(define (get-rendered-text w)
  (local [ ; get rendered-g1s : Game1String -> String
          ; return "_" for unguessed, letter for guessed
          (define (get-rendered-g1s g)
            (cond [(guessed? g) (guessed-letter g)]
                  [(unguessed? g) "_"]))]
    (cond [(empty? w) ""]
          [(cons? w) (string-append (g1s-temp (first w))
                                    (get-rendered-text (rest w)))])))
             
;; all-guessed? : WoF -> Boolean
;; determines if all the letters have been guessed in game
;;(check-expect (all-guessed '()))
(check-expect (all-guessed? WOF-4) #t)
(check-expect (all-guessed? WOF-0) #f)
(check-expect (all-guessed? WOF-2) #f)
(define (all-guessed? w)
  (andmap guessed? w)
  #;(cond [(empty? w) ...]
          [(cons? w) (and (guessed? (first w))
                          (all-guessed? (rest w)))]))

;; 1. what is the base case?
;; 2. How do we combine the recursive call with the first letter?
;;     if the first is unguessed return #f
;;     we want to know that the first is guessed and that all the rest are guessed