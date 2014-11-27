<?
	require_once 'Config/DBManager.php';
	require_once 'Config/Utility.php';
	$DBManager = new DBManager();
	$con = $DBManager->getDBConnector();
	// devsfolder
	// a889056
	
	// a889056
	// devsfolder


	$room_id = $_POST['room_id'];
	$user_id = $_POST['user_id']; // a889056
	$person_id = $_POST['person_id']; // devsfolder

	$query = "SELECT *,home_member.profile_img FROM home_room_message,home_member WHERE home_room_message.fk_sender_id=home_member.pkid AND fk_room_id='$room_id' AND is_confirm=0 AND home_room_message.fk_receiver_id='$user_id' AND home_room_message.fk_sender_id='$person_id'";
	
	$tempData = array();
	$result = mysqli_query($con,$query);

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
		array_push($tempData,$data);
	}
	
	$updateQuery = "UPDATE home_room_message SET is_confirm=1 WHERE fk_receiver_id='$user_id' AND fk_sender_id='$person_id' AND send_date < CURRENT_TIMESTAMP";
	$result = mysqli_query($con,$updateQuery) or die(error_json('Error',''));
	
	success_data($tempData);
?>