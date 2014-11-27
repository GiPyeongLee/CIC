<?php
require_once 'Config/DBManager.php';
require_once 'Config/Utility.php';

if(!isset($_POST['user_id'])){
	error_log_str('오류','유저아이디를 입력해주세요');
	return;
}
if(!isset($_POST['user_pw'])){
	error_log_str('오류','비밀번호를 입력해주세요');
	return;
}

	$kUSER = $_POST['user_id'];
	$kPASS = $_POST['user_pw'];
	$kTOKEN = preg_replace("/\s+/", "", $_POST['device_token']);
	
	$DBManager = new DBManager();
	$con = $DBManager->getDBConnector();
	$query = "SELECT * FROM home_member WHERE `pkid` = '".$kUSER."' AND `password`= '".sha1($kPASS)."'";
	$result = mysqli_query($con,$query);
	while($row = mysqli_fetch_array($result)) {
		$updateQuery = "UPDATE home_member SET device_token='".$kTOKEN."' WHERE `pkid`='".$kUSER."';";
		mysqli_query($con,$updateQuery);
		$data = array();
		foreach ($row as $key => $value) {
			if(!is_int($key)){
				if($key!='password'){
					if($value!=NULL)
						$data[$key] = $value;
					else
						$data[$key] = '';
				}				
			}
		}
		
		success_data($data);
		mysqli_close($con);
		return;
	}
	$query = "SELECT * FROM home_member WHERE `pkid` = '".$kUSER."'";
	$result = mysqli_query($con,$query);
	$row = mysqli_fetch_array($result);
	if(sizeof($row)>0){
		error_log_str('오류','비밀번호가 다릅니다');
		mysqli_close($con);
		return;		
	}else{
		error_log_str('오류','미등록 사용자 입니다');
		mysqli_close($con);
		return;
	}

	
	
?>