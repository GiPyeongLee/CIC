<?php
	function error_log_str($title,$message){
		$returnObj = array('status' => '400','data'=> array('title'=>$title,'message'=> $message));
		echo json_encode($returnObj);
	}
	function error_json($title,$message){
			$returnObj = array('status' => '400','data'=> array('title'=>$title,'message'=> $message));
			return json_encode($returnObj);
		}
	function success_data($data){
		$returnObj = array('status' => '200','data'=> $data);
		echo json_encode($returnObj);
	}
	
	/*
		JSON 
		[] : Array 배열  a[0],
		{} : Association Array 관계형 배열 , a["key"] = value
		{"이름":"조승환"}  = a["이름"] = 조승환
		
	*/
?>