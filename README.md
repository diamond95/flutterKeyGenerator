## Web Auth Key Generator

Simple flutter application that generates 6-digit code and updates it to a web server using HTTP POST Request.
After update, the administrator types this code in the web application on login site.

Adventage of using key generator is stopping brute-force attacks on your web application.

![Screenshot](https://raw.githubusercontent.com/diamond95/flutterKeyGenerator/master/1.jpg)




## PHP - HTTP Request


```php
    <?php

    $data = json_decode(file_get_contents('php://input'), true);

    if($data['key'] != 0 && $data['key'] != "" && $data['key'] != "0") {
        // save key in database
    } else {
        echo "error";
        die();
    }

```
## TODO 
    - [:white_check_mark:] change key length
    - [] automatic key update after generating 


## Creator
Ivan Miljanić

