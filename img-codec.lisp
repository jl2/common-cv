(in-package #:cv)

(define-cfun ("cvConvertImage" convert-image) :void
  (src :pointer)
  (dst :pointer)
  (flags :int 0))

(define-cfun ("cvLoadImage" load-image) :pointer
  (file :string)
  (iscolor :int +load-image-color+))

(define-cfun ("cvSaveImage" cv-save-image) :pointer
  (file-name :string)
  (image :pointer)
  (params :pointer (cffi:null-pointer)))

(defun save-image (file-name image &rest params)
  (cond ((= 0 (length params))
         (cv-save-image file-name image (cffi:null-pointer)))
        ((= 1 (mod (length params) 2))
         (error "Must be an even number of parameter values!"))
        (t
         (let ((args (make-array (1+ (length params)) :element-type 'integer :initial-contents (concatenate 'list params (list 0 0)))))
           (cffi:with-foreign-array (parameters args (list :array :int (length params)))
             (cv-save-image file-name image parameters))))))

(define-cfun ("cvLoadImageM" load-image-m) :pointer
  (filename :string)
  (iscolor :int +load-image-color+))
