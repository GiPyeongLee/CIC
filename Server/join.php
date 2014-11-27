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

if(!isset($_POST['user_birth'])){
	error_log_str('오류','유저 생일을 입력해주세요');
	return;
}

if(!isset($_POST['user_name'])){
	error_log_str('오류','유저 이름을 입력해주세요');
	return;
}
if(!isset($_POST['user_mobile'])){
	error_log_str('오류','유저 핸드폰번호 확인해주세요');
	return;
}

if(!isset($_POST['user_type'])){
	error_log_str('오류','유저타입을 확인해주세요');
	return;
}

if(!isset($_POST['user_email'])){
	error_log_str('오류','이메일을 입력해주세요');
	return;
}


$kUSER = $_POST['user_id'];
$kPASS = sha1($_POST['user_pw']);
$kBIRTH = $_POST['user_birth'];
$kNAME = $_POST['user_name'];
$kMOBILE = $_POST['user_mobile'];
$kTYPE = $_POST['user_type'];
$kEMAIL = $_POST['user_email'];

$DBManager = new DBManager();

$con = $DBManager->getDBConnector();

$kUSER = preg_replace("/a/","A",$kUSER);
$kUSER = preg_replace("/b/","B",$kUSER);
$kUSER = preg_replace("/c/","C",$kUSER);
$kEMAIL = preg_replace("/[ #\&\+\-%=\/\\\:;,\'\"\^`~\_|\!\?\*$#<>()\[\]\{\}]/i", "", $kEMAIL);
if($kUSER){

	$query="SELECT * FROM home_member WHERE `pkid`='".$kUSER."';";

	$result = mysqli_query($con,$query);

	$row = mysqli_fetch_array($result);

	if($row[0]){
		error_log_str($kTYPE,'이미 등록된 사용자입니다.');
		mysqli_close($con);
		return;
	}else{
		$file = $_SERVER['DOCUMENT_ROOT'].'/home/img_profile/noimage.jpg';
		$newFile = $_SERVER['DOCUMENT_ROOT'].'/home/img_profile/'.$kUSER.'.jpg';
		$kFilePath = 'https://cic.hongik.ac.kr/home/img_profile/'.$kUSER.'.jpg';
		copy($file,$newFile);
		$insertQuery="INSERT INTO `home_member` (`pkid`,`password`,`profile_img`,`name`,`email`,`mobile`,`birth`,`type`) VALUES ('$kUSER','$kPASS','$kFilePath','$kNAME','$kEMAIL','$kMOBILE','$kBIRTH','$kTYPE')";
		//error_log_str('회원가입실패','error:'.mysqli_error($con)
			mysqli_query($con,$insertQuery) or die(error_log_str('회원가입실패','서버오류'));
	/* 		unset($_SESSION['key']); //가입성공하면 세션 삭제 */
		$query="SELECT * FROM home_member WHERE `pkid`='".$kUSER."';";
		$returnVal = mysqli_query($con,$query)or die(error_log_str('회원가입실패','서버오류'));
		
		
		
		
		
		
		while($row = mysqli_fetch_array($returnVal)) {
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
			
	}
}else{
    error_log_str('오류','학번/아이디를 확인해주세요');
    mysqli_close($con);
    return;
}
?>