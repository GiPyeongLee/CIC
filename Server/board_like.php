<?php
	require_once 'Config/DBManager.php';
	require_once 'Config/Utility.php';
	
	$DBManager = new DBManager();
	$con = $DBManager->getDBConnector();
	
	if (mysqli_connect_errno())
	{
		error_log_str("error",mysqli_connect_error());
		return;
	}	
	
	$board_id = $_POST['board_id'];
	$member_id = $_POST['member_id'];
	
	// 게시글 아이디,  아이디
	// 좋아요 있는지 확인
	// 없으면 추가
	// 있는데 status =0 > 1 로 , 1 > 0
	
	$query ="select * from home_like where fk_board_id=".$board_id." AND fk_member_id='".$member_id."'";
	
	$result = mysqli_query($con,$query) or die(mysqli_error($con));
	
	$row = mysqli_fetch_array($result);
	if($row[0]){
	// 있음
		$statusFlag = 0;
	
	        //Do stuff
	        foreach ($row as $key => $value) {
				if(!is_int($key)){
					if($key=="status"&&$value==0){
						$statusFlag = 1;
						break;
					}
					else if($key=="status"&&$value==1){
						$statusFlag = 0;
						break;
					}
				}
			}
	    
		$updateQuery = "update home_like set status=".$statusFlag." where fk_board_id=".$board_id." AND fk_member_id='".$member_id."'";
		$result = mysqli_query($con,$updateQuery) or die(mysqli_error($con));
		
		success_data(array());

	}else{
	// 없음 
		$insertQuery = "insert into home_like (fk_member_id,fk_board_id,status) values('".$member_id."',".$board_id.",1)";
		$result = mysqli_query($con,$insertQuery) or die(mysqli_error($con));
		success_data(array());
	}
	


?>