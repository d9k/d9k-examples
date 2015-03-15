#!/usr/bin/env php
<?php

$text = "Привет";

if (isset($argv[1])){
   $text = $argv[1];
}

$ch = curl_init("http://sms.ru/auth/get_token");
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
curl_setopt($ch, CURLOPT_TIMEOUT, 30);
$token = curl_exec($ch);
curl_close($ch);


$ch = curl_init("http://sms.ru/sms/send");
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
curl_setopt($ch, CURLOPT_TIMEOUT, 30);
curl_setopt($ch, CURLOPT_POSTFIELDS, array(

	"login"		=>	"79532393234",
	"sha512"			=>	hash("sha512","пароль".$token."ea3e298a-69a3-8964-359b-4675ab320dbb"),
	"token"		=>	$token,
	"to"			=>	"79532393234",
	"text"		=>	$text

));
$body = curl_exec($ch);
curl_close($ch);
echo $body."\n";