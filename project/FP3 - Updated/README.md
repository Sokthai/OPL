## My Library: (web-server/servlet)
My name: Sokthai Tang

the "web-server/servlet" and "web-server/servlet-evn" are the Racket Web servlet libraries. 
they provide the way to build the web very easily. for example, to create the label or input tag, 
i can simply put the tag name in the parentheses. 
```racket
(label "Username   : ")
(input ((name "username")))
```

It is very convenience to include any external file such as .CSS style sheet. 
```racket
  (link ((rel "stylesheet")
  (href "/style.css")
  (type "text/css"))))
```

In this project, I build a simple registration form that allow users to create a profile account. 
It requires user to enter their username, password, name etc.… 
The web-server/servlet library provides the necessary functions to do this. 
``` racket
   (select (option "Select a country")
       (option "United States")
       (option "United Kingdom")
       (option "Canada"))
```

this code would generate the HTML “select” tag and its option. 
in this simple project, when we look the linking of the external .CSS file,
it is very simple and straightforward. It uses the "link" keyword and the
parenthesis to include the file.
```racket
  (link ((rel "stylesheet")
         (href "/style.css")
         (type "text/css")))
```

The following code is a simple registration form that is build using the libaries. 
```racket
#lang web-server/insta
(require web-server/servlet)
(define (start request)
  (response/xexpr
   '(html (head (title "Web Page")
                (link ((rel "stylesheet")
                       (href "/style.css")
                       (type "text/css"))))

          (body 
                (h1 "Registration Form")
                (label "Username : ")
                (input ((name "username")))
                (br)(br)
                (label "Password : ")
                (input ((name "password")))
                (br)(br)
                (label "Name : ")
                (input ((name "name")))
                (br)(br)
                (label "Address : ")
                (input ((name "address")))
                (br)(br)
                (label "Country : ")
                (select (option "Select a country")
                        (option "United States")
                        (option "United Kingdom")
                        (option "Canada")
                ) 
                (br)(br)
                (label "Zipcode : ")
                (input ((name "zipcode")))
                (br)(br)
                (label "Email : ")
                (input ((type "email" name "email")))
                (br)(br)
                (input ((type "submit")))
          )
     )

   ))
 
(static-files-path "htdocs")
```
When running the code, the “static-files-path” function will inform the web server to look into the “htdocs” directory for the “style.css” file. This will eventually link the registration form to the .CSS file and produce the result. 

![alt tag](https://github.com/Sokthai/OPL/blob/master/FP1/form.png)





