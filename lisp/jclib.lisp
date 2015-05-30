#!/usr/bin/env clisp

; A collection of toys, atm.

(defun double (x) 
    (* 2 x))


(format t "Double of fourteen is ~A" (double 14))
