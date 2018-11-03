(use-modules (smt))

(smt-scalar 'A '(foo bar baz))

(smt-const 'a 'A)
(smt-const 'b 'A)
(smt-const 'c 'A)
(smt-const 'd 'A)

(smt-push 1)
(smt-assert (smt-distinct 'a 'b 'c))
(smt-check-sat)
(smt-pop 1)

(smt-push 1)
(smt-assert (smt-distinct 'a 'b 'c 'd))
(smt-check-sat)
(smt-pop 1)
