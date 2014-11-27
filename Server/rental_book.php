<?
	require_once 'Config/DBManager.php';
	require_once 'Config/Utility.php';
	$DBManager = new DBManager();
	$con = $DBManager->getDBConnector();
	$reserverID = $_POST['user_id'];
	$equip_id = $_POST['equip_id'];
	$start_date = $_POST['start_date'];
	$end_date = $_POST['end_date'];
	$status = $_POST['status'];
	$equip_rental_count = 0;
	$equip_total_count =0;
	$newStatus =-1;
	
	if(isset($_POST['newStatus'])){
		$newStatus=$_POST['newStatus'];
	}
	
	if($newStatus>-1){
	// 취소 관련 사항 
		$query = "SELECT * FROM home_equip WHERE equip_id='$equip_id'";
		$result = mysqli_query($con,$query) or die(error_json('장비가 없습니다.',''));
		while($row = mysqli_fetch_array($result)) {
			$equip_id=$row['pkid'];
			$equip_name=$row['name'];
			$equip_rentaled_count = $row['rental_count'];
			$equip_total_count = $row['total_count'];
		}
		$update_query = "UPDATE home_reservation SET home_reservation.status=$newStatus WHERE fk_reserverID='$reserverID' AND fk_equipID=$equip_id AND start_date='$start_date' AND end_date='$end_date'";
			$update_result = mysqli_query($con,$update_query) or die(error_json('대여할 수 없습니다.',$update_query));
			
			if($update_result){
				if($status==1&&$newStatus==2){
				 //  신청중에서 > 대여중
					if($equip_rental_count+1<=$equip_total_count)
						$equip_rental_count +=1;
					$update_query = "UPDATE home_equip SET rental_count=$equip_rental_count WHERE name='$equip_name'";	
					$update_result = mysqli_query($con,$update_query) or die(error_json('대여할 수 없습니다.',''));
					if($update_result){
						success_data(array('status'=>$status));
					}
	
				}else if($status==1){
					success_data(array('status'=>$status));
				}else if($status==4&&$newStatus==0){
				// 반납신청 -> 반납완료
					if($equip_rental_count>0)
						$equip_rental_count -=1;
						
					$update_query = "UPDATE home_equip SET rental_count=$equip_rental_count WHERE name='$equip_name'";	
					$update_result = mysqli_query($con,$update_query) or die(error_json('반납할 수 없습니다.',''));
					if($update_result){
						success_data(array('status'=>$status));
					}
					
				}
			}	
	
	
		
	}else {
	// 신청 관련 사항
		
		$query = "SELECT * FROM home_equip WHERE equip_id='$equip_id'";
		$result = mysqli_query($con,$query) or die(error_json('장비가 없습니다.',''));
		while($row = mysqli_fetch_array($result)) {
			$equip_id=$row['pkid'];
			$equip_name=$row['name'];
			$equip_rentaled_count = $row['rental_count'];
			$equip_total_count = $row['total_count'];
		}
		
		$query = "SELECT * FROM home_reservation WHERE fk_reserverID='$reserverID' AND fk_equipID='$equip_id' AND start_date='$start_date' AND end_date='$end_date'";
		
		$result = mysqli_query($con,$query) or die(error_json('대여할 수 없습니다.',''));
		
		if(mysqli_num_rows($result)>0){
			// 있다.
			// UPDATE
			$update_query = "UPDATE home_reservation SET home_reservation.status=$status WHERE fk_reserverID='$reserverID' AND fk_equipID='$equip_id'AND start_date='$start_date' AND end_date='$end_date'";
			$update_result = mysqli_query($con,$update_query) or die(error_json('대여할 수 없습니다.',''));
			
			if($update_result){
				if($status==2){
					if($equip_rental_count+1<=$equip_total_count)
						$equip_rental_count +=1;
					$update_query = "UPDATE home_equip SET rental_count=$equip_rental_count WHERE name='$equip_name'";	
					$update_result = mysqli_query($con,$update_query) or die(error_json('대여할 수 없습니다.',''));
					if($update_result){
						success_data(array('status'=>$status));
					}
	
				}else if($status==1){
					success_data(array('status'=>$status));
				}else if($status==0){// 반납
					if($equip_rental_count>0)
						$equip_rental_count -=1;
						
					$update_query = "UPDATE home_equip SET rental_count=$equip_rental_count WHERE name='$equip_name'";	
					$update_result = mysqli_query($con,$update_query) or die(error_json('반납할 수 없습니다.',''));
					if($update_result){
						success_data(array('status'=>$status));
					}
					
				}
			}		
		}
		else {
			// 없다.
			$insert_query = "INSERT INTO home_reservation (fk_reserverID,fk_equipID,start_date,end_date,status) VALUES ('$reserverID','$equip_id','$start_date','$end_date',$status)";
			$result = mysqli_query($con,$insert_query) or die(error_json('대여할 수 없습니다.',''));
			if($result){
				success_data(array());
			}else{
				error_log_str("error",mysqli_error($con));
			}
	
		}	
	}
	// change equip id
	
	
?>