;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9:11notes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


(check-expect (temp->cw 0) "Cold")
(check-expect (temp->cw 75) "Warm")
(check-expect (temp->cw 95) "Warm")

(define (temp->cw temp)
  (cond [(< temp 60) "Cold"]
        [else "Warm"]))

;; Vocab: if
;; Grammar: (if conditoin then-expr else-expr)
;; Semtantics: evaluates to result of then-expr
;; if condtion evalutes to #true, otherwise
;; evakuates to result of else-expr

(check-expect (temp->cw2 0) "Cold")
(check-expect (temp->cw2 75) "Warm")
(check-expect (temp->cw2 95) "Warm")

(define (temp->cw2 temp)
  (if (< temp 60) "Cold" "Warm"))

(define SKY-WIDTH 300)
(define SKY-HEIGHT 200)

(define RADIUS 25)

(define SUN (circle RADIUS "solid" "yellow"))
(define MOON (circle RADIUS "solid" "gray"))
(define SKY (rectangle SKY-WIDTH SKY-HEIGHT "solid" "light blue"))

(define DARKSKY
  (rectangle SKY-WIDTH
             SKY-HEIGHT
             "solid"
             "black"))

(define X-SUN (/ SKY-WIDTH 2))

(define (draw-eclipse x-moon)
 (place-image
  MOON
  x-moon
  (/ SKY-HEIGHT 2)
  (place-image SUN
               X-SUN
               (/ SKY-HEIGHT 2)
               (if (< (abs(- x-moon X-SUN)) 10)
               DARKSKY
               SKY))))
;; (animate draw-eclipse)


;; Design Recipe

;; temp->clothing : OutdoorTemp -> Clothing

; 1. An OutdoorTemp is a real number in [-50, 150]
; 2. Interpretation: degrees in fahrenheit
; 3. Examples
(define OT1 -10)
(define OT2 0)
(define OT3 50)
(define OT4 120)
; 4. Template
(define (ot-temp temp) (...temp...))

; 1. A Clothing is one of:
; - "t-shirt"
; - "sweater"
; - "coat"
; - "snow suit"
; 2. Interpretation: article of cliothing someone might wear
; 3. Examples:
(define C-TSHIRT "t-shirt")
(define C-SWEATER "sweater")
(define C-COAT "coat")
(define C-SNOWSUIT "snow suit")
; 4. Template:
(define (clothing-temp c)
  (cond [(string=? C-TSHIRT c) ...]
        [(string=? C-SWEATER c) ...]
        [(string=? C-COAT c)...]
        [(string=? C-SNOWSUIT c)...]))

; 1. temp->clothing : OutdoorTemp -> Clothing
; 2. retuns an article of clohting appropriate to the given
; temperature
; 3. Tests/Examples
(check-expect (temp->clothing OT1) C-SNOWSUIT)
(check-expect (temp->clothing OT2) C-SNOWSUIT)
(check-expect (temp->clothing OT3) C-COAT)
(check-expect (temp->clothing OT4) C-TSHIRT)
; 4. Implementation:
; ...

; clothing-comfortable? : Clothing -> Boolean
; tells whether the clothing is comfortable
(check-expect (clothing-comfortable? C-TSHIRT) #t)
(check-expect (clothing-comfortable? C-SWEATER) #t)
(check-expect (clothing-comfortable? C-COAT) #t)
(check-expect (clothing-comfortable? C-SNOWSUIT) #f)
(define (clothing-comfortable c)
  (cond [(string=? C-TSHIRT c) #t]
        [(string=? C-SWEATER c) #t]
        [(string=? C-COAT c) #t]
        [(string=? C-SNOWSUIT c) #f]))
 

