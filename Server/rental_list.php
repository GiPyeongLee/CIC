<?
	require_once 'Config/DBManager.php';
	require_once 'Config/Utility.php';
	$DBManager = new DBManager();
	$con = $DBManager->getDBConnector();
	$status = $_POST['status'];
	$user_id = $_POST['user_id'];
	if($status==0)
	{   // 리스트
		$query = "SELECT DISTINCT * FROM home_equip GROUP BY name";
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
		
		success_data($tempData);
	}
	else if($status==1)
	{   // 신청중

	 	$query = "SELECT * FROM home_equip,home_reservation WHERE home_equip.pkid=home_reservation.fk_equipID AND home_reservation.fk_reserverID='$user_id'AND home_reservation.status IN (1,4)";

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
		
		success_data($tempData);	
	}
	else if($status==2)
	{	// 대여중
$query = "SELECT * FROM home_equip,home_reservation WHERE home_equip.pkid=home_reservation.fk_equipID AND home_reservation.fk_reserverID='$user_id'AND home_reservation.status=$status";
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
		
		success_data($tempData);			
	}
	else if($status==3)
	{	// 반납완료/혹은 반려완료
$query = "SELECT * FROM home_equip,home_reservation WHERE home_equip.pkid=home_reservation.fk_equipID AND home_reservation.fk_reserverID='$user_id'AND home_reservation.status=0";
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
		
		success_data($tempData);			
	}

?>