(load "tests/tests-driver.scm")
(load "tests/tests-1.2-req.scm")
(load "tests/tests-1.1-req.scm")

(define fxshift 2)
(define fxmask #x03)
(define bool_f #x2F)
(define bool_t #x6F)
(define charmask  #x0F)
(define chartag   #x0F)
(define charshift 8)
(define empty_list #x3F)
(define wordsize 4) ; bytes

(define fixnum-bits (- (* wordsize 8) fxshift))

(define fxlower (- (expt 2 (- fixnum-bits 1))))

(define fxupper (sub1 (expt 2 (- fixnum-bits 1))))

(define (fixnum? x)
(and (integer? x) (exact? x) (<= fxlower x fxupper)))

(define (to-char x)
  (logior (ash (char->integer x) charshift) chartag))

(define (immediate? x)
(or (fixnum? x) (boolean? x) (char? x) (null? x)))

(define (immediate-rep x)
  (cond
    [(fixnum? x) (ash x fxshift)]
    [(boolean? x) (if x bool_t bool_f)]
    [(char? x) (to-char x)]
    [(null? x) empty_list]
    [else #f]))

(define (compile-program x)
    (unless (immediate? x) (error 'compile-program "not an immediate"))
    (emit " .text")
    (emit " .globl scheme_entry")
    (emit " .type scheme_entry, @function")
    (emit "scheme_entry:")
    (emit " movl $~s, %eax" (immediate-rep x))
    (emit " ret"))