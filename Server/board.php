<?php
require_once 'Config/DBManager.php';
require_once 'Config/Utility.php';

/**/
	$boardType = $_POST['main_type']; // 1. 게시판 타입

	$DBManager = new DBManager();
	$con = $DBManager->getDBConnector();
	$query ="";
	if(!isset($_POST['date'])){
		$query = "SELECT home_board.*,home_member.profile_img,home_member.name FROM home_board,home_member WHERE `fk_type` = '".$boardType."' AND home_board.fk_memberID=home_member.pkid ORDER BY date DESC LIMIT 5";
	
		$result = mysqli_query($con,$query);
		$returnData = array();
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
			array_push($returnData,$data);
		}
		success_data($returnData);

	
	}
	else{
		$date = $_POST['date'];
		$query = "SELECT home_board.*,home_member.profile_img,home_member.name FROM home_board,home_member WHERE `fk_type` = '".$boardType."' AND `date`< '".$date."'  AND home_board.fk_memberID=home_member.pkid ORDER BY date DESC LIMIT 5";
		
		$result = mysqli_query($con,$query);
		$returnData = array();
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
			array_push($returnData,$data);
		}	
		success_data($returnData);
	}
	mysqli_close($con);
		
	// 2. 사용자의 정보 & 게시판 정보 Join
	// 3. Timestamp 를 이용한 데이터 정렬
	
?>