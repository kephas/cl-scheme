#| Scheme-like library for Common Lisp

   Copyright 2013, Pierre Thierry
   See LICENSE |#

(in-package :nothos.net/2013.08.scheme)

(defmacro let@ (name binds &body body)
  "This is the LET from RnRS with a name, that creates a local function."
  `(labels ((,name ,(mapcar #'first binds) ,@body))
     (,name ,@(mapcar #'second binds))))

(defmacro lisp1ify (&rest names)
  (let@ rec ((names names)
	     (forms))
    (if names
	(let ((name (first names)))
	  (rec (rest names)
	       (append `((setf (symbol-function ',name)
			       (lambda (&rest args)
				 (apply (symbol-value ',name) args)))
			 (defvar ,name))
		       forms)))
	(cons 'progn (reverse forms)))))

(defmacro with-lisp1 (names &body body)
  `(labels (,@(mapcar (lambda (name-spec)
			`(,name-spec (&rest rest) (apply ,name-spec rest)))
                      names))
     ,@body))
