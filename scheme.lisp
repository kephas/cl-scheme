#| Scheme-like library for Common Lisp

   Copyright 2013, Pierre Thierry
   See LICENSE |#

(in-package :nothos.net/2013.08.scheme)

(defmacro let@ (name binds &body body)
  "This is the LET from RnRS with a name, that creates a local function."
  `(labels ((,name ,(mapcar #'first binds) ,@body))
     (,name ,@(mapcar #'second binds))))

(defmacro lisp1ify (&rest names)
  "Make each name a function that calls the value of the variable with
the same name."
  (let@ rec ((names names)
	     (forms))
    (if names
	(let ((name (first names)))
	  (rec (rest names)
	       (append `((setf (symbol-function ',name)
			       (lambda (&rest args)
				 (apply (symbol-value ',name) args))))
		       forms)))
	(cons 'progn (reverse forms)))))

(defmacro with-lisp1 (names &body body)
  "Make each name a function that calls the value of the variable with
the same name within BODY."
  `(labels (,@(mapcar (lambda (name-spec)
			`(,name-spec (&rest rest) (apply ,name-spec rest)))
                      names))
     ,@body))

(defmacro add-nickname (package nickname)
  "Add a nickname to a package, with effect similar to R6RS' prefix."
  `(eval-when (:compile-toplevel :load-toplevel :execute)
     (rename-package ,package (package-name ,package) (cons ,nickname (package-nicknames ,package)))))
