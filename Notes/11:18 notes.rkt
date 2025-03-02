;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |11:18 notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; A Graph is a list of nodes and a list of edges

;; A Label is a String
;; Interpretation: name of a node in the graph
(define A "A")
(define B "B")
(define C "C")
(define D "D")
(define E "E")

(define-struct node [label neighbors])
;; A Node is a (make-node Label [ListOf Label])
;; Interpretation: represents a node in a directed graph,
;; including its label and all the other nodes that it has
;; edges to. NOTE: the edges are directed

(define NA (make-node A (list C)))
(define NB (make-node B (list A)))
(define NC (make-node C (list B)))
(define ND (make-node D '()))
(define NE (make-node E (list C D)))

(define (node-temp n)
  (... (node-label n)
       ... (list-temp (node-neighbors n))))

;; A Graph is a [ListOf Node]
;; Interpretation: all the nodes in the graph. Constraint:
;; all mentioned neighbors must be included as nodes.
(define G0 (list NA NB NC ND NE))
(define G1 (list (make-node "Amy" (list "Bill" "Claire"))
                 (make-node "Bill" (list "Ben"))
                 (make-node "Ben" (list))
                 (make-node "Claire" (list "Eli"))
                 (make-node "Eli" (list "Claire"))))

;; A PreGraph is a [ListOf Node]
(define PG0 (list (make-node "Amy" (list "Bill" "Claire"))
                 (make-node "Bill" (list "Ben"))
                 #;(make-node "Ben" (list))
                 (make-node "Claire" (list "Eli"))
                 (make-node "Eli" (list "Claire"))))

;; good? : PreGraph -> Boolean
;; returns whether input satisfies well-formed graph constraint
(check-expect (good? G1) #t)
(check-expect (good? PG0) #f)
;; for every node, go through neighbors and see if those all
;; exist as nodes
(define (good? g)
  (local [(define ALL-LABELS (map node-label g)); good-node? : Node -> Boolean
          ;; should go through neighbors and see if they exist as nodes
          (define (good-node? n)
            (andmap exists-as-node? (node-neighbors n)))
          ;; exists-as-node? : Label -> Boolean
          ;; checks if the given label exists as a node
          (define (exists-as-node? l)
            (member? l ALL-LABELS))]
  (andmap good-node? g)))

;; path? : Graph Label Label -> Boolean
;; is there a path from the first label to the second
;; Tests:
(check-expect (path? G0 "A" "C") #t)
(check-expect (path? G0 "D" "E") #f)
(check-expect (path? G0 "C" "D") #f)
;; Code:
(define (path? g from to)
  (local [ ;path?/acc : [ListOf Label] Label Label -> Boolean
          ; ACCUMULATOR: list of visited nodes
          ; TERMINATES: visited nodes will strictly increase
          (define (path?/acc visited from to)
            (cond [(member? to FROM-POINTS-TO) #t]
                  [(member? from visited) #f]
                  [else (ormap (lambda (new-from)
                                 (path?/acc (cons new-from visited)
                                            new-from to))
                               FROM-POINTS-TO)]))
          ; point-to : Label -> [ListOf Label]
          ; gets all pointed to nodes
          (define (points-to l)
            (node-neighbors (first (filter (lambda (n)
                                             (string=? (node-label n)
                                                       l))
                                           g))))
          (define FROM-POINTS-TO (points-to from))]
          (path?/acc (list from) from to)))

