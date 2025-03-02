;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname L20-915) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; Wheel of Fortune Game - big-bang program

;; There is a secret word, player guesses letters that get revealed when they are correct


(define-struct guessed [letter])
(define-struct unguessed [letter])
; A Game1String is one of:
; - (make-guessed 1String)
; - (make-unguessed 1String)
; a 1String is a single character string, either guessed or still hidden

(define G1S-1 (make-guessed "a"))
(define GIS-2 (make-unguessed "a"))

(define (g1s-temp g)
  (cond [(guessed? g) (... (guessed-letter g) ...)]
        [(unguessed? g) (... (unguessed-letter g) ...)]))

; A WorldOfFortune (WoF) is a [ListOf Game1String]
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

; guessing-game : String -> WoF
; runs a game using string input
(define (guessing-game s)
  (big-bang (map make-unguessed (explode s))
    [to-draw draw-game]
    [on-key key-game]
    [stop-when all-guessed? draw-game]))


;; key-game : WoF KeyEvent -> WoF
(define (key-game w ke)
  (local [;; guess-key : Game1String -> Game1String
          ;; changes from unguessed to guessed if key matches
          (define (guess-key g)
            (cond [(guessed? g) g]
                  [(unguessed? g) (if (string=? (unguessed-letter g) ke)
                                      (make-guessed (unguessed-letter g))
                                      g)]))]

  (map guess-key w)))

(define TEXT-SIZE 50)
(define TEXT-COLOR "black")

;; draw-game : WoF -> Image
;; draws the letters, with underscores for unknown
(check-expect (draw-game WOF-0) (text "_____" TEXT-SIZE TEXT-COLOR))
(check-expect (draw-game WOF-4) (text "hello" TEXT-SIZE TEXT-COLOR))
(check-expect (draw-game WOF-1) (text "__ll_" TEXT-SIZE TEXT-COLOR))
(define (draw-game w)
  (text (get-rendered-text w) TEXT-SIZE TEXT-COLOR))

;; get-rendered-text : WoF -> String
;; returns a string where unguessed show up as _, guessed as letters
(check-expect (get-rendered-text '()) "")
(check-expect (get-rendered-text WOF-0) "_____")
(check-expect (get-rendered-text WOF-1) "__ll_")
(check-expect (get-rendered-text WOF-4) "hello")
(define (get-rendered-text w)
  (foldr string-append "" (map (lambda (g)
                                 (cond [(guessed? g) (guessed-letter g)]
                                       [(unguessed? g) "_"]) )
                               w))
  #;(local [; get-rendered-g1s : Game1String -> String
          ; return "_" for unguessed, letter for guessed
          (define (get-rendered-g1s g)
            (cond [(guessed? g) (guessed-letter g)]
                  [(unguessed? g) "_"]))]
    (foldr string-append "" (map get-rendered-g1s w))
    #;(cond [(empty? w) ""]
          [(cons? w) (string-append (get-rendered-g1s (first w))
                                    (get-rendered-text (rest  w)))])))


;; all-guessed? : WoF -> Boolean
;; determines if all the letters have been guessed in game
(check-expect (all-guessed? '()) #t)
(check-expect (all-guessed? WOF-4) #t)
(check-expect (all-guessed? WOF-0) #f)
(check-expect (all-guessed? WOF-2) #f)
(define (all-guessed? w)
  (andmap guessed? w)
  #;(cond [(empty? w) #t]
        [(cons? w)
         #;(if (unguessed? (first w))
               #f
               (all-guessed? (rest w)))
         (and (guessed? (first w))
              (all-guessed? (rest w)))]))


;; 1. what is the base case?
;; 2. How do we combine the recursive call with the first letter?
;;    - if the first is unguessed then return #f, otherwise check if there are unguessed in rest
;;    - PLAN: we want to know that the first is guessed and that all the rest are guessed




                    
