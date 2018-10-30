(define-module (smt)
                #:export (smt-assert
                          smt-check-sat
                          smt-comment
                          smt-const
                          smt-fun
                          smt-get-model
                          smt-maximize
                          smt-minimize
                          smt-quoted-symbol
                          smt-record
                          smt-scalar
                          smt-sort))

(define *bug-report* "https://github.com/edoput/guile-smt/issues")

(define-syntax smt-assert
  (syntax-rules ()
                ((_ e)
                 (begin
                   (display `(assert ,e))
                   (newline)))
                ;; TODO add the ability to set the smt
                ;; keyword to this assertion
                ((_ e name)
                 (begin
                   (display `(assert ,e))
                   (newline)))))

(define-syntax smt-sort
  (syntax-rules ()
                ((_ name)
                 (begin
                   (display `(declare-sort ,name 0))
                   (newline)))
                ((_ name e)
                 (begin
                   (display `(define-sort ,name () ,e))
                   (newline)))
                ((_ name parameters e)
                 (begin
                   (display `(define-sort ,name (,@parameters) ,@e))
                   (newline)))))

(define-syntax smt-fun
  (syntax-rules ()
                ((_ name input-sort output-sort)
                 (begin
                   (display `(declare-fun ,name (,@input-sort) ,output-sort))
                   (newline)))
                ((_ name input-sort output-sort e)
                 (begin
                   (display `(define-fun ,name (,@input-sort) ,ouput-sort
                                         e))
                   (newline)))))

(define-syntax smt-const
  (syntax-rules ()
                ((_ name sort)
                 (begin
                   (display `(declare-const ,name ,sort))
                   (newline)))))

(define-syntax smt-minimize
  (syntax-rules ()
                ((_ e)
                 (begin
                   (display `(minimize ,e))
                   (newline)))))

(define-syntax smt-maximize
  (syntax-rules ()
                ((_ e)
                 (begin
                   (display `(maximize ,e))
                   (newline)))))

(define-syntax smt-scalar
  (syntax-rules ()
                ((_ name v)
                 (begin
                   (display `(declare-datatypes () ((,name ,@v))))
                   (newline)))))
;                 (_ name params v)
;                 (begin
;                   (display `(declare-datatypes (,@params) ((,name ,@v))))
;                   (newline)))))

(define-syntax smt-record
  (syntax-rules ()
                ((_ name)
                 (begin
                   (display `(declare-datatypes ((,name (constructor (some field))))))
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
(define-syntax smt-quoted-symbol
  (syntax-rules ()
                ((_ e) (string-append "|" (symbol->string e) "|"))
                ((_ e1 ...)
                 (string-append "|" (make-symbol e1 ...) "|"))))


; insert a comment in the resulting SMT file
(define-syntax smt-comment
  (syntax-rules ()
                ((_ e1 ...)
                 (begin (display (string-append "; " e1 ...))(newline)))))

; insert the check-sat command in the resulting SMT file
(define smt-check-sat
  (lambda ()
    (newline)
    (display '(check-sat))
    (newline)))

; insert the get-model command in the resulting SMT file
(define smt-get-model
  (lambda ()
    (newline)
    (display '(get-model))
    (newline)))
