<?php
	require_once 'Config/DBManager.php';
	require_once 'Config/Utility.php';
	// 게시판 번호, 작성자 번호, 작성글 내용
	$board_id = $_POST['board_id'];
	$member_id = $_POST['member_id'];
	$comment = $_POST['comment'];
	$now = new DateTime();
	$date= $now->format('Y-m-d H:i:s');
	$DBManager = new DBManager();
	$con = $DBManager->getDBConnector();
	$insertQuery = "insert into home_comment (fk_memberID,fk_boardID,text,date) values('".$member_id."',".$board_id.",'".$comment."','".$date."')";
	$result = mysqli_query($con,$insertQuery) or die(mysqli_error($con));
	success_data(array('date'=>$date));
?>