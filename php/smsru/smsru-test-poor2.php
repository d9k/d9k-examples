#!/usr/bin/env php
<?php

$text = "Привет";

if (isset($argv[1])){
   $text = $argv[1];
}

$ch = curl_init("http://sms.ru/sms/send");
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
curl_setopt($ch, CURLOPT_TIMEOUT, 30);
curl_setopt($ch, CURLOPT_POSTFIELDS, array(

	"api_id"		=>	"ea3e298a-69a3-8964-359b-4675ab320dbb",
	"to"			=>	"79532393234",
	"text"		=>	$text

));
$body = curl_exec($ch);
curl_close($ch);

echo $body."\n";