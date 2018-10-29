(define-module (smt))

(define *bug-report* "https://github.com/edoput/guile-smt")

(define-syntax smt-assert
  (syntax-rules ()
                ((_ e)
                 (begin
                   (display `(assert ,e))
                   (newline)))))

(define-syntax const
  (syntax-rules ()
                ((_ name sort)
                 (begin
                   (display `(declare-const ,name ,sort))
                   (newline)))))

(define-syntax minimize
  (syntax-rules ()
                ((_ e)
                 (begin
                   (display `(minimize ,e))
                   (newline)))))

(define-syntax maximise
  (syntax-rules ()
                ((_ e)
                 (begin
                   (display `(maximise ,e))
                   (newline)))))

(define-syntax make-symbol 
  (syntax-rules ()
                ((_ e) (symbol->string e))
                ((_ e1 e2 ...)
                 (string-append
                   (symbol->string e1)
                   "-"
                   (make-symbol e2 ...)))))

; return the representation for a new SMT quoted symbol
(define-syntax quoted-symbol
  (syntax-rules ()
                ((_ e) (string-append "|" (symbol->string e) "|"))
                ((_ e1 ...)
                 (string-append "|" (make-symbol e1 ...) "|"))))


; insert a comment in the resulting SMT file
(define-syntax comment
  (syntax-rules ()
                ((_ e1 ...)
                 (begin (display (string-append "; " e1 ...))(newline)))))

; insert the check-sat command in the resulting SMT file
(define check-sat
  (lambda ()
    (newline)
    (display '(check-sat))
    (newline)))

; insert the get-model command in the resulting SMT file
(define get-model
  (lambda ()
    (newline)
    (display '(get-model))
    (newline)))
