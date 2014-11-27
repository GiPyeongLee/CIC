<?
	require_once 'Config/DBManager.php';
	require_once 'Config/Utility.php';
	$DBManager = new DBManager();
	$con = $DBManager->getDBConnector();
	$returnData = array();
	$user_id = $_POST['user_id'];
	$query = "SELECT * FROM home_member";
	$result = mysqli_query($con,$query);
		// 장비데이터를 모두 가져온다.
		// 해당 부품별 총 개수를 SET한다..
		// status 가 대여중인 것을 SET 한다. (status=1)
	$tempData = array();
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
	$returnData['people'] = $tempData;

// 채팅 룸 받아오기

/*
	$room_query = "SELECT * FROM home_room WHERE home_room.pkid IN (SELECT fk_room_id FROM home_room_member WHERE fk_member_id='$user_id')";
	$result = mysqli_query($con,$room_query) or die(error_json('에러',''));
		// 장비데이터를 모두 가져온다.
		// 해당 부품별 총 개수를 SET한다..'
		// status 가 대여중인 것을 SET 한다. (status=1)
	$tempData = array();
	$room_id='';
	if(mysqli_num_rows($result)>0){
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
			$room_id = $data['pkid'];
			array_push($tempData,$data);
		}
	}
	$returnData['room'] = $tempData;
*/
	$tempData = array();
	$receiveQuery = "SELECT DISTINCT home_member.*,home_room_message.fk_room_id,home_room.last_message FROM home_member,home_room_message,home_room WHERE home_room_message.fk_receiver_id=home_member.pkid AND  home_room_message.fk_sender_id='$user_id' AND home_room.pkid=home_room_message.fk_room_id";
	$result = mysqli_query($con,$receiveQuery) or die(/*  error_json('에러','') */mysqli_error($con).$receiveQuery);
	if(mysqli_num_rows($result)>0){
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
	}
	$returnData['room'] = $tempData;

	success_data($returnData);
	
?>