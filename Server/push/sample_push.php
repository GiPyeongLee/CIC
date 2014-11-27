<?php

// Put your device token here (without spaces):
$deviceToken = '5ac95a8f47279fad28ad494e1f1ad1ae417a3870869cd43f3b26de24f852e697';
$deviceToken2 = '799d5b2affa041c679735d2ec71793b4ad5ece36fdc9426552c9c1ee43f07978';
$deviceToken3 = 'dcc80c3f8cc0b5205ce8ee1a5cc9456ec8de5a0e8a5fc008ab2054e175a13e2c';
/* $deviceToken4 = '55e0ff79e8a2cdd8c34c06004a0fe4733039c0cd4b097720dfb6bffc714fa622'; */
$deviceToken4 = '4d2fe671bfc98f7444fa944835a70e5cdebe37d7d454588057d6b83ab65548ed';
// Put your private key's passphrase here:
$passphrase = 'CICApp';

// Put your alert message here:
$message = '[중요] 학술제 공지사항';

////////////////////////////////////////////////////////////////////////////////

$ctx = stream_context_create();
stream_context_set_option($ctx, 'ssl', 'local_cert', 'ck.pem');
stream_context_set_option($ctx, 'ssl', 'passphrase', $passphrase);

// Open a connection to the APNS server
$fp = stream_socket_client(
	'ssl://gateway.sandbox.push.apple.com:2195', $err,
	$errstr, 60, STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT, $ctx);

if (!$fp)
	exit("Failed to connect: $err $errstr" . PHP_EOL);

echo 'Connected to APNS' . PHP_EOL;

// Create the payload body
$body['aps'] = array(
	'alert' => $message,
	'badge'=>3,
	'sound' => 'default'
	);

// Encode the payload as JSON
$payload = json_encode($body);

// Build the binary notification
$msg = chr(0) . pack('n', 32) . pack('H*', $deviceToken) . pack('n', strlen($payload)) . $payload;
$msg2 = chr(0) . pack('n', 32) . pack('H*', $deviceToken2) . pack('n', strlen($payload)) . $payload;
$msg3 = chr(0) . pack('n', 32) . pack('H*', $deviceToken3) . pack('n', strlen($payload)) . $payload;
$msg4 = chr(0) . pack('n', 32) . pack('H*', $deviceToken4) . pack('n', strlen($payload)) . $payload;
// Send it to the server
$result = fwrite($fp, $msg, strlen($msg));
$result = fwrite($fp, $msg2, strlen($msg2));
$result = fwrite($fp, $msg3, strlen($msg3));
$result = fwrite($fp, $msg4, strlen($msg4));
if (!$result)
	echo 'Message not delivered' . PHP_EOL;
else
	echo 'Message successfully delivered' . PHP_EOL;

// Close the connection to the server
fclose($fp);
