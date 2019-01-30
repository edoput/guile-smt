(use-modules (smt))

(smt-record 'Point '((x T) (y S)) '(T S))

(smt-const 'a '(Point Int Int))
(smt-const 'b '(Point Int Int))

(smt-push 1)
(smt-assert (smt-distinct 'a 'b))
(smt-check-sat)
(smt-pop 1)
