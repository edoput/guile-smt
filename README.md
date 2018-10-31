SMT
===

Write SMT syntax from Guile.

| SMT | Scheme |
|-----|--------|
| assert e | smt-assert 'e |
| declare-sort A | smt-sort 'A |
| define-sort A () Int | smt-sort 'A 'Int |
| define-sort A (T) (Array Int T) | smt-sort 'A '(T) '(Array Int T) |
| declare-fun foo ((p Int) (q Int)) Int | smt-fun 'foo '((p Int) (q Int)) 'Int |
| define-fun foo ((p Int) (q Int)) Int (+ p q) | smt-fun 'foo '((p Int) (q Int)) 'Int (+ p q) |
| declare-const bar Int | smt-const 'foo 'Int |
| minimize e | smt-minimize e |
| maximize e | smt-maximize e |
| declare-datatypes () ((A Foo Bar Baz)) | smt-scalar 'A '(Foo Bar Baz) |
| ; a comment | smt-comment "a comment" |
| check-sat | smt-check-sat |
| get-model | smt-get-model |

