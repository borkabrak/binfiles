; How do you recurse an anonymous function?
; Apparently, with the 'Y-Combinator'
;
; This tries to follow along with:
;
;   http://mvanier.livejournal.com/2897.html

; Here's a typical recursive function for calculating a factorial:
(define factorial (lambda (n)
  (if (< n 1)
    1
    (* n (factorial (- n 1))))))

; What if we couldn't use the function's name?  Like, say, it was anonymous.
; How would we write the above then?

; The Y-combinator takes a non-recursive function, and returns a version of it
; that is recursive.  Sounds like just what we need.
;
; So.. how does it do that?

; A 'combinator' is a lambda expression with no free variables.
; A free variable is one that is not a parameter to its containing lambda
; expression.  The opposite is a 'bound' variable, which is contained in a
; lambda expression that has that variable as an argument.

; ABSTRACTING OUT THE RECURSIVE FUNCTION CALL

(define almost-factorial 
  (lambda (f)
    (lambda (n)
      (if (< n 1)
        1
        (* n (f (- n 1)))))))

; But f there is contained in a version of itself.  So we want almost-factorial
; to return f applied to f.. not quite?  I feel like I'm so close..
; [Keep reading, past Jon.. that's essentially it.]
; 
; Something like:
; (define almost-factorial
;   (lambda (f)
;     (f f)
;
; back to the lesson..
;
; if we have a working factorial function already, we can pass that to
; almost-factorial and it will work (since it's used to get the factorial of (- n 1)
;
; But where do we get a working factorial function that is also a combinator?
; Watch close, because this is twisted..
; Why don't we just define it like:
; (define working-factorial (almost-factorial working-factorial))
; Hrm.. doesn't work, though I'm told it should.. are my interpreters not using lazy evaluation?

(define (identity x) x) ; returns its argument
(define factorial0 (almost-factorial identity)) ; calculates factorials up to 0 (so.. just 0)
(define factorial1 (almost-factorial factorial0)) ; calculates factorials up to 1 (so 0 and 1)
(define factorial2 (almost-factorial factorial1)) ; calculates factorials up to 2 (so 0..2)
(define factorial3 (almost-factorial factorial2)) ; calculates factorials up to 3 (so 0..3)
(define factorial4 (almost-factorial factorial3)) ; calculates factorials up to 4 (so 0..4)

; ... and so on.  
; If we keep doing this, we get:
; (define true-factorial (almost-factorial factorialInfinity)
;
; The function that we converge on after repeated applications of
; almost-factorial to identity is the real, working factorial function.
; This is called the 'fixpoint' of the function.
;
; In other words:  The fixpoint of almost-factorial is true-factorial
;
; How do we find the fixpoint of a function?  Well, that apparently is exactly
; what the Y-Combinator does.
;
; This works, but only in a lazy (evaluating) language:
; (define Y 
;   (lambda (f)
;     (f (Y f))))
;
;
; Here's one that works in strictly evaluated languages:
; The difference is a bit of a trick.  cf. the website from the beginning.
(define Y 
  (lambda (f)
    (f (lambda (x) 
        ((Y f) x)))))

; Look ma!  No recursion! (except in Y)
(define true-factorial 
  (lambda (n)
  ((Y almost-factorial) n)))

; So we've got Y.  But it's not the Y-Combinator because it's not a combinator.
; It's not a combinator because it has a free variable -- 'Y'!  In other words,
; it's explicitly recursive, and that's not allowed in combinators.
;
; Get the Y-Combinator, and we're done!
;
; In a way, we're still at the beginning -- how do we get recursion a situation
; where we can't recurse (such as an anonymous function)?

; Start over.. (halfway down the webpage ;) )


; Rewrite as not explicitly recursive, because we send along the function to
; 'recurse' with.  In other words, we're NOT recursing, we're just calling a
; function that we got as a parameter.
(define (part-factorial self)
  (lambda (n)
  (if (= n 0)
    1
    (* n ((self self) (- n 1))))))

(define real-factorial (part-factorial part-factorial))

; THIS WORKS!  WE'VE DONE IT!!!
; We're recursing without recursing.  Whaaaa???
; This was the secret.  Everything else is details and refactoring.
; Really understanding this may take some revisiting..  But there it is, in 5 or 6 short lines..
;
; There's more to this before we're at the true Y-combinator, which is sort of
; a generalization of the above principle.  Keep following the lesson.
