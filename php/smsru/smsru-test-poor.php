#!/usr/bin/env php
<?php

$text = "Привет";

if (isset($argv[1])){
   $text = $argv[1];
}

echo $text."\n";

echo file_get_contents(
    "http://sms.ru/sms/send?api_id=ea3e298a-69a3-8964-359b-4675ab320dbb&to=79532393234&text=".urlencode($text)
);