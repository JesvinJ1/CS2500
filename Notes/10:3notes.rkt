;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 10:3notes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct student [name next-student])
;; A Students is one of:
;; - "no more students"
;; - (makes-student String Students)
;; Interpretation:
;; - either no students at all or some number of named students
(define S0 "no more students")
(define S1 (make-student "John" S0))
(define S2 (make-student "John"
                         (make-student "Jane"
                                       (make-student "Alice"
                                                     (make-student "Ellen"
                                                                   "no more student")))))
(define (students-temp s)
  (cond [(string? s) ...]
        [(student? s) (... (student-name s)
                           (students-temp (student-next-student s)) ...)]))
;; Design a function count-students that returns count of named students

;; count-students : Students -> Number
;; returns how many named students are in input
(check-expect (count-students S0) 0)
(check-expect (count-students S1) 1)
(check-expect (count-students S2) 4)
(check-expect (count-students (make-student "Jane"
                                       (make-student "Alice"
                                                     (make-student "Ellen"
                                                                   "no more student"))))
              3)

(define (count-students s)
  (cond [(string? s) 0]
        [(student? s) (+ 1 (count-students (student-next-student s)))]))

;; has-alice? : Students -> Boolean
;; does Alice occur anywhere in the Students
;(check-expect (has-alice? S0) #f)
;(check-expect (count-students S1) #f)
;(check-expect (count-students S2) #f)
#;(define (has-alice? s)
  (cond [(string? s) #f]
        [(student? s) (... (student-name s)
                           (has-alice? (student-next-student s)) ...)]))
  ;; EXERCISE: Finish!


