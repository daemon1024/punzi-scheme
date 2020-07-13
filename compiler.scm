(load "tests/tests-driver.scm")
(load "tests/tests-1.1-req.scm")

(define (compile-program x)
    (unless (integer? x) (error 'compile-program "not an integer"))
    (emit " .text")
    (emit " .globl scheme_entry")
    (emit " .type scheme_entry, @function")
    (emit "scheme_entry:")
    (emit " movl $~s, %eax" x)
    (emit " ret"))