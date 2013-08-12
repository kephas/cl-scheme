(defpackage :nothos.net/2013.08.scheme-system
  (:use :common-lisp :asdf))

(in-package :nothos.net/2013.08.scheme-system)

(defsystem "scheme"
  :description "Scheme-like library for Common Lisp"
  :version "0.1"
  :author "Pierre Thierry <pierre@nothos.net>"
  :licence "BSD"
  :components ((:file "package")
	       (:file "scheme"))
  :serial t)
