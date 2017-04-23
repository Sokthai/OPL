#lang racket
(require rsound net/sendurl)
;(require racket/gui)
;(require  json  net/url)
(require  json srfi/13  net/url (only-in racket/gui play-sound))

;(require web-server/http)
;(require net/http-client)


;------connection-------------------
(define word "")
(define app_id "app_id:da0194c3")
(define app_key "app_key:761ad80847bb97ee40842f7ecc43fade")
(define open_api "https://od-api.oxforddictionaries.com:443/api/v1/entries/en/")


(define file-path "C:\\Users\\sokthai\\Downloads/")
(define sound-url "")
(define result "")


(define macPath "/Users/sokthaitang/downloads/") ; path for mac
(define winPath "C:\\Users\\sokthai\\Downloads\\") ; path for widnow
(define ubuPath "/home/thai/Downloads/") ; path for ubuntu
(define path winPath)
(define wordList "wordList")

(define (search word)


  
  (set! result "")
  (define con-url (string->url (string-append open_api word)))
  (define dict-port (get-pure-port con-url (list app_id app_key)))
  (define respond (port->string dict-port))
  (close-input-port dict-port)
   
  (cond ((number? (string-contains respond "404 Not Found")) (set! result (list (list "Error:" "Not Found"))))
        (else
         (searchDict (readjson-from-input respond) '|word| "word:")
         (searchDict (readjson-from-input respond) '|definitions| "definitions:")
         (searchDict (readjson-from-input respond) '|examples| "examples:")
         (searchDict (readjson-from-input respond) '|audioFile| "pronunciation:")
         (let* ((audioURL (soundPath result)) 
                (fileName (string-append path
                                       (substring audioURL 43 (string-length audioURL)))))
           (if (not (file-exists? fileName))
               (send-url (soundPath result))
               'ok)


           (write-to-file word wordList)
          ;(set! wordHistory (append wordHistory (list word)))
         )
  ))
  
  result
)


(define (history word)
  ;(lambda (x)  (set! word (append word x)))
  1
)




(define (readjson-from-input var)
  (with-input-from-string var
    (lambda () (read-json)))
      
  )



(define (searchDict hash k des)
  (cond ((list? hash)  (searchDict (car hash) k des))
        ((and (hash? hash) (not (empty? (hash-ref hash k (lambda () empty))))) (display hash k des))     
        (else        
         (cond ((hash? hash)              
                (for (((key val) (in-hash hash)))
                  (searchDict (hash-ref hash key) k des)))                  
               (else hash)))))




(define (display hash k des)
  (cond  
    ((list? (hash-ref hash k))
     (cond
    
       ((string? (car (hash-ref hash k))) (return  des (car (hash-ref hash k))))
       (else
        (show (hash-ref hash k) k des))))
    
    (else (return  des (hash-ref hash k (lambda () ""))))
  )
)




(define (return des content )
  
  (if (list? result)
      (set! result (append result (list (list des content))))
      (set! result (list (list des content))))
  
  
)
  

(define (show lst k des)

  (cond ((null? lst) lst)
        (else
         (for (((key val) (in-hash (car lst )))) 
          (return des val)
           )

         (show (cdr lst) k des)
         ))
  )



(define (soundPath lst)
  
  (if (and (list? lst) (null? (cdr lst))) 
      (cadr (car lst))
      (soundPath (cdr lst)))
)






(define (pronounce lst)
  
  (let ((audioURL (soundPath lst)))
    (cond  ((equal? (caar lst) "Error:") '())
           (else
            (play-sound
               (string-append path
                                       (substring audioURL 43
                                                  (string-length audioURL))) #t)))
 )
  )




 (define (write-to-file data path) 
   (with-output-to-file path 
     (lambda () 
       (write data)) #:exists 'append))


(define (read-from-file path)
  (file->list path))

