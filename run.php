<?php
include('core/common.php');
include('core/PHPMailer/Exception.php');
include('core/PHPMailer/PHPMailer.php');
include('core/PHPMailer/SMTP.php');

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;
use PHPMailer\PHPMailer\Exception;

$count = 10; //单次发送多少个邮件
for($x = 0; $x < $count; $x++){
	$task = mysqli_fetch_assoc($db->query('select * from send_task where status = 0 limit 1'));
	
	//没数据滚蛋
	if(!$task) break;
	
	echo '[' . $task['id'] . '] send [' . $task['subject'] . '] to ' . $task['target'] . ' ';
	
	//设置状态为发送中
	$db->query('update send_task set status = 1 where id = ' . $task['id']);
	
	echo '.';

	//获取发送邮件的信息
	$sender = mysqli_fetch_assoc($db->query('select * from send_mail where gid = "' . $task['sender'] . '" order by rand() limit 1'));
	
	//sender未找到
	if(!$sender){
		$db->query('update send_task set status = 3, error = "sender not found." where id = "' . $task['id'] . '"');
		echo ' × : sender not found.';
		break;
	}
	
	echo '.';
	
	// ==================================================================================
	
	$mail = new PHPMailer(true);

	echo '.';
	
	try {
		$mail->SMTPSecure = 'ssl'; 
		$mail->SMTPDebug  = false;
		$mail->isSMTP();
		$mail->SMTPAuth   = true;
		$mail->Encoding   = 'base64';
		$mail->CharSet    = 'utf-8';
		$mail->Username   = $sender['username'];
		$mail->Password   = $sender['password'];
		$mail->Host       = $sender['host'];
		$mail->Port       = $sender['port'];

		$mail->setFrom($sender['username'], $sender['name']);
		$mail->addAddress($task['target']);
		$mail->addReplyTo($sender['username'], $sender['name']);

		$mail->isHTML(true);
		$mail->Subject = $task['subject'];
		$mail->Body    = $task['body'];
		$mail->AltBody = $task['altBody'];
		
		$mail->send();
		echo ' √';
		
		$db->query('update send_task set status = 2, endTime = now() where id = ' . $task['id']);
	} catch (Exception $e) {
		echo ' × : ' . $mail->ErrorInfo;
		
		$db->query('update send_task set status = 3, endTime = now(), error = "' . $mail->ErrorInfo . '" where id = ' . $task['id']);
	}
	
	echo "\r\n";
}