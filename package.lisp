#| Scheme-like library for Common Lisp

   Copyright 2013, Pierre Thierry
   See LICENSE |#

(defpackage :nothos.net/2013.08.scheme
  (:use :cl)
  (:export #:let@ #:lisp1ify #:with-lisp1 #:add-nickname)
  (:nicknames :scheme))
