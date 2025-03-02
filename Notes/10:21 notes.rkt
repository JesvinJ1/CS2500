;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |10:21 notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Wheel of Fortune Game - big bang program

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
;... WOF-1 through WOF-4 will be games with progressively more letter guessed

; guessing-game : String -> WoF
; runs a game using strign input
(define (guessing-game s)
  (big-bang (map make-ungussed (explode s)
    ...))