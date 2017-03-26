;Sokthai Tang 3/12/2017
#lang web-server/insta
(require web-server/servlet)
(define (start request)
  (response/xexpr
   '(html (head (title "Web Page")
                (link ((rel "stylesheet")
                       (href "/style.css")
                       (type "text/css"))))

          (body 
                (h1 "Dictionary")              
                (label "Search : ")
                (input ((name "search")))
                (br)(br)
                (label "Word : ")
                (input ((name "word")))
                (br)(br)
                (label "Definition : ")
                (input ((name "definition")))
                (br)(br)
                (label "Examples : ")
                (input ((name "example")))
              
                (br)
                (input ((type "submit")))
          )
     )

   ))



(send/suspend
 (lambda (k-url)
   (response/xexpr
    `(html (head (title "Enter a number"))
           (body
            (form ([action ,k-url])
                  "Enter a number: "
                  (input ([name "number"]))
                  (input ([type "submit"]))))))))





 
(static-files-path "htdocs")