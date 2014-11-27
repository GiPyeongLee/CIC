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
	$query ="select home_comment.*,home_member.profile_img,home_member.name from home_comment,home_member where home_comment.fk_boardID =".$board_id." AND home_comment.fk_memberID = home_member.pkid";
	
	$result = mysqli_query($con,$query) or die(mysqli_error($con));
	
	$returnData = array();

	$commentsData = array();
	
	while($row = mysqli_fetch_array($result)) {
		$data = array();
		foreach ($row as $key => $value) {
			if(!is_int($key)){			
				if($value!=NULL)
					$data[$key] = $value;
				else
					$data[$key] = '';	
			}
		}
		array_push($commentsData,$data);
	}
		
	
	$returnData['comments'] = $commentsData;	
	// 좋아요 상태인지 확인
	$likeQuery = "select * from home_like where fk_member_id='".$member_id."' AND fk_board_id=".$board_id." AND status=1 ";
	$likeResult = mysqli_query($con,$likeQuery) or die($likeQuery."\n".mysqli_error($con));
	// 있으면
	$row=mysqli_fetch_array($likeResult);
	if($row[0]){
		$returnData['isLike'] = '1';
	}else{
		$returnData['isLike'] = '0';
	}

	success_data($returnData);
	mysqli_close($con);
?>