#!/usr/bin/env clisp
; A quick overview of how to lisp
;
; comments are done with semicolons

; define a function
(defun 
    double      ;function name
    (x)         ;parameter list ('nil' is no params)
    (* 2 x))    ;return value expression

; call a function
(double 8)

; print to stdout ('~%' => newline)
(format t "Double of fourteen is ~A~%" (double 14))

; Let's make an easier print function to:
;   * assume STDOUT 
;   * automatically add a newline.  
; We'll call it 'say'
(defun say (str)
    (format t str)
    (format t "~%"))

; True => 't', false => 'nil'
(defun true-or-false nil nil)

; conditional statement
(if 

    ; condition
    (true-or-false)                     

    ; then/true
    (say "Conditional returns true")    

    ; else/false 
    (say "Conditional returns false")   

    ; this feels like a mix between conventional if statements and the ternary
    ; operator
)

; recursive factorial
(defun fact (n)
    (if 
        (= n 0) 1 
        (* n (fact (- n 1)))))


(format t "(fact 6) => ~S" (fact 6))
