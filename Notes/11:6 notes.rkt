;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |11:6 notes|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct section [title docs])
(define-struct paragraph [text])

;; A Doc is one of:
;; - (make-section Docs)
;; - (make-paragraph String)
;; Interpretation: a document in a wordprocessor where:
;; - a (make-section title docs) is a section of the document that contains
;; other documents inside (possibly none)
;; a (make-paragraph text) contains actual text

;; A Docs is a [ListOf Doc]
;; Interpretation: a sequence of Doc

(define DOCS0 '())
(define DOC0 (make-paragraph "Hello"))
(define DOC1 (make-paragraph "More text"))
(define DOCS1 (list DOC1 DOC1))
(define DOC2 (make-section "Subtitle" DOCS1))
(define DOC3 (make-section "Title" (list DOC0 DOC2)))

(define (doc-temp d)
  (cond [(section? d) (... (section-title d)
                      ... (docs-temp (section-docs d))
                      ...)]
        [(paragraph? d) (... (paragraph-text d)...)]))

(define (docs-temp ds)
  (cond [(empty? ds) ...]
        [(cons? ds) (... (doc-temp (first ds))
                         (docs-temp (rest ds))
                         ...)]))

;; count-sections : Doc -> Number
;; returns how many sections exist in the document
;; Tests:
(check-expect (count-sections DOC3) 2)
(check-expect (count-sections DOC1) 0)
(check-expect (count-sections DOC2) 1)
;; Code
(define (count-sections d)
  (cond [(section? d) (+ 1 (count-sections-docs (section-docs d)))]
        [(paragraph? d) 0]))

;; count-sections-docs : Docs -> Number
;; returns how mayn sections exist in the list of documents
;; Tests:
(check-expect (count-sections-docs DOCS0) 0)
(check-expect (count-sections-docs (list DOC2)) 1)
;; Code:
(define (count-sections-docs ds)
  (cond [(empty? ds) 0]
        [(cons? ds) (+ (count-sections (first ds))
                       (count-sections-docs (rest ds)))]))

;; to-html : Doc -> String
;; translates into html, using <h1> for section titles, <p> for paragraphs
;; Tests:
(check-expect (to-html DOC0) "<p>Hello/<p>")
(check-expect (to-html DOC3) "<h1>Title/<h1><p>Hello/<p><h1>Subtitle/<h1><p>More text/<p>")
;; Code:
(define (to-html d)
  (cond [(section? d) (string-append "<h1>"
                                     (section-title d)
                                     "</h1>"
        (to-html-docs (section-docs d)))]
        [(paragraph? d) (string-append "<p>"
                                       (paragraph-text d)
                                       "/<p>")]))

