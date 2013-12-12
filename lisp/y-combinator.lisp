#!/usr/bin/env clisp
;
;   Scratch pad for an article explaining the Y-combinator at http://mvanier.livejournal.com/2897.html 
;
;   Teaser: It's about how to have anonymous recursive functions. Think about it, Jon.. (you rakish devil)
;
; He uses Scheme, and this is lisp, so caveat grasshopper..

(defun factorial (n)
    (if (= n 0)
        1
        (* (factorial (- n 1)))))

(defun almost-factorial nil
    (lambda (f)
        (lambda (n)
            (if (= n 0)
                1
                (* n (f (- n 1)))))))

(format t "(facty) => ~S" (almost-factorial factorial))
