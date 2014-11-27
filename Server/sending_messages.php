<?
	require_once 'Config/DBManager.php';
	require_once 'Config/Utility.php';
	$DBManager = new DBManager();
	$con = $DBManager->getDBConnector();
	// 방번호 취득
	$room_id = '';
	$send_user_id = $_POST['user_id'];
	$receive_user_id = $_POST['person_id'];
	$message = $_POST['message'];
	if(!isset($_POST['room_id'])){	
		// 방 찾기
		$query = "SELECT fk_room_id FROM home_room_message WHERE fk_receiver_id='$receive_user_id' AND fk_sender_id='$send_user_id'";
		$result = mysqli_query($con,$query) or die(error_json('room error',''));
		if(mysqli_num_rows($result)>=1)
		{
			while($row = mysqli_fetch_array($result)){
				$room_id = $row['fk_room_id'];
			}

		}
		$query = "SELECT fk_room_id FROM home_room_message WHERE fk_receiver_id='$send_user_id' AND fk_sender_id='$receive_user_id'";
		$result = mysqli_query($con,$query) or die(error_json('room error',''));
		if(mysqli_num_rows($result)>=1)
		{
			while($row = mysqli_fetch_array($result)){
				$room_id = $row['fk_room_id'];
			}

		}
		if($room_id==''){
			$query = "INSERT INTO home_room (last_message) VALUES ('$message')";		
			$result = mysqli_query($con,$query) or die(error_json('room error',''));
			$room_id = mysqli_insert_id($con);
		}
	}
	else{
		$room_id = $_POST['room_id'];
	}
	// 룸멤버 등록 만약 안되어있으면
	$query = "SELECT * FROM home_room_member WHERE fk_room_id=$room_id AND fk_member_id='$send_user_id'";
	$result = mysqli_query($con,$query) or die (error_json('Error',''));
	if(mysqli_num_rows($result)!=1){
		//룸 멤버 등록 
		$query = "INSERT INTO home_room_member (fk_room_id,fk_member_id) VALUES ($room_id,'$send_user_id'),($room_id,'$receive_user_id')";
		$result = mysqli_query($con,$query) or die (error_json('Error',''));
	}

	// 메시지 보내기
	$query = "INSERT INTO home_room_message (fk_room_id,fk_receiver_id,fk_sender_id,message) VALUES ($room_id,'$receive_user_id','$send_user_id','$message')";
	$result = mysqli_query($con,$query) or die (error_json('Error',''));
	
	$query = "UPDATE home_room_message SET is_confirm=1 WHERE send_date < CURRENT_TIMESTAMP AND fk_room_id=$room_id AND fk_receiver_id='$send_user_id'";
	$result = mysqli_query($con,$query) or die (error_json('update error',''));
		
	$query = "UPDATE home_room SET last_message='$message' WHERE pkid=$room_id ";
	$result = mysqli_query($con,$query) or die (error_json('update error',''));
	
	success_data(array("room_id"=>$room_id));
?>