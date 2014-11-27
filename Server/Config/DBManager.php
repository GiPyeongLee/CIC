<?php
require 'Config.php';

class DBManager{
	protected $con;
	public function __construct() // 초기 할당시 콜됨 .
	{
		$this->con=mysqli_connect(DB_HOST,DB_USER,DB_PASS,DB_NAME);
		if (mysqli_connect_errno()) {
			echo "Failed to connect to MySQL: " . mysqli_connect_error();
		}
	}
	public function getDBConnector(){
		return $this->con;
	}
}
function IsNullOrEmptyString($question){
    return (!isset($question) || trim($question)==='');
}
?>