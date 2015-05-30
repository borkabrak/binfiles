; Lisp stuff I writed!
; 
; Some of this is from Paul Graham's book, ANSI Common Lisp
(defun sum (n)
  "Sum numbers less than n."
  (let ((s 0))
    (dotimes (i n s)
      (incf s i))))

; ACL, Chapter 2 Exercise 7, p. 30
;
; (Got it in one.  Works perfectly.  BAM!)
(defun contains-list-p (lst)
  "Define a function that takes a list as an argument and returns true if one of its elements is a list."
  (if (null lst)
      nil
    (if (listp (car lst))
	t
      (contains-list-p (cdr lst)))))

;; Exercise 8
;;
;; Give iterative and recursive definitions of a function that
;;
;; (a) takes a positive integer and prints that many dots
;;
;; (b) takes a list and returns the number of times the symbol a occurs in it

(defun dots-recursive (n)
  "print dots - recursive"
  (if (> n 0)
    ((lambda nil (format t ".") (dots-recursive (- n 1))))))


(defun dots-iterative (n)
  "print dots - iterative"
  (do ((i 1 (+ i 1)))
      ((> i n) nil)
    (format t ".")))

(defun count-a-r (lst)
  "count 'a's - recursive"
  (if (null lst)
      0
    (if (equal 'a (car lst))
	(+ 1 (count-a-r (cdr lst)))
      (count-a-r (cdr lst)))))

(defun count-a-i (lst)
  "count 'a's - iterative"
  (setq count 0)
  (dolist (el lst)
    (if (equal el 'a)
	(setq count (+ count 1))))
  count)

(defun range0 (end)
  "Return a list of numbers from 0 to end"
  (if (< end 1)
    (list 0)
    (cons (range0 (- end 1)) end)))

(defun range (start &optional end)
  "Return a list of numbers from start to end (non-inclusive)"
  (if (null end)
      (lambda nil (setq end start)
       (setq start 0)))
  (if (equal start end)
    nil
    (cons start (range (+ start 1) end))))

;; my favorite exercise
;; reverse a sequence
(defun rev (seq)
  (if (null seq)
    nil
  (cons
    (nth (- (length seq) 1) seq)
    (rev (subseq seq 0 (- (length seq) 1))))))

