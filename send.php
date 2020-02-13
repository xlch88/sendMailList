<?php
include('core/common.php');

$id		= isset($_GET['id']) && $_GET['id'] > 0 ? (int)$_GET['id'] : die('empty id !');
$secret	= isset($_GET['secret']) && strlen($_GET['secret']) == 32 ? addslashes($_GET['secret']) : die('empty secret !');

if(!$auth = mysqli_fetch_assoc($db->query('select * from send_auth where id = "' . $id . '" and secret = "' . $secret . '" limit 1'))){
	die('error id or secret !');
}

$gid		= isset($_POST['gid']) ? (int)$_POST['gid'] : die('empty gid !');
$target		= isset($_POST['target']) ? addslashes($_POST['target']) : die('empty target !');
$subject	= isset($_POST['subject']) ? addslashes($_POST['subject']) : die('empty subject !');
$body		= isset($_POST['body']) ? addslashes($_POST['body']) : die('empty body !');
$altBody	= isset($_POST['altBody']) ? addslashes($_POST['altBody']) : '';

if(!in_array($gid, explode(',', $auth['allowGid']))){
	die('gid disallow !');
}

if(!filter_var($target, FILTER_VALIDATE_EMAIL)){
	die('error target !');
}

$db->query('insert into send_task set sender = "' . $gid . '", target = "' . $target . '", subject = "' . $subject . '", body = "' . $body . '", altBody = "' . $altBody . '"');

die('ok!');