#!/usr/bin/env php
<?php

if(count($argv) < 2){
	echo 'not enough args'."\n";
	exit;
}

function xmlToArray($xml){
	$xml = simplexml_load_string($xml);
	$array = json_decode(json_encode((array) $xml), 1);
	return array($xml->getName() => $array);
}

$filePath = $argv[1];
$rawXml = file_get_contents($filePath);
$xmlArray = xmlToArray($rawXml);
echo var_export($xmlArray, 1);

// echo $xmlArray['returnPaymentRequest']['@attributes']['invoiceId'];