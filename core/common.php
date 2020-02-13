<?php
$config = include('config.php');
$db = mysqli_connect($config['db']['host'], $config['db']['user'], $config['db']['pass'], $config['db']['name'], $config['db']['port']);
if (!$db) die('db boom!');