<?php

error_reporting(E_ALL | E_STRICT);
define ('MAX_FILE_SIZE', 1024000 * 50);
$msg = " ".var_dump($_FILES)." ";
if ($_FILES["file"]["error"] > 0){// 파일 업로드 에러 체크
	
		// 업로드 에러 있음
		switch ($_FILES['upload']['error']) {// 실패 내용을 출력
			case 1:
				echo '1 : php.ini 파일의 upload_max_filesize 설정값을 초과함(업로드 최대용량 초과';
				break;
			case 2:
				echo '2 : Form에서 설정된 MAX_FILE_SIZE 설정값을 초과함(업로드 최대용량 초과';
				break;
			case 3:
				echo '3 : 파일 일부만 업로드 됨';
				break;
			case 4:
				echo '4 : 업로드된 파일이 없음';
				break;
			case 6:
				echo '6 : 사용가능한 임시폴더가 없음';
				break;
			case 7:
				echo '7 : 디스크에 저장할수 없음';
				break;
			case 8:
				echo '8 : 파일 업로드가 중지됨';
				break;
			default:
				echo 'etc : 시스템 오류가 발생';
				break;
		} // switch
}

// 0 유저 id 및 사진 받기
// 1 사진 쓰기 ( 서버에 )

/*      
	conn.setRequestProperty("Connection", "Keep-Alive");
    conn.setRequestProperty("Content-Type", "multipart/form-data;boundary="+boundary); 
	dos.writeBytes("Content-Disposition: form-data; name=\"uploadedfile\";filename=\"" + exsistingFileName +"\"" + lineEnd);
*/
// 

/*
	foreach ($_FILES["pictures"]["error"] as $key => $error) {
    if ($error == UPLOAD_ERR_OK) {
        $tmp_name = $_FILES["pictures"]["tmp_name"][$key];
        $name = $_FILES["pictures"]["name"][$key];
        move_uploaded_file($tmp_name, "$uploads_dir/$name");
    }
}
	
*/

$uploads_dir = $_SERVER['DOCUMENT_ROOT'].'/home/img_profile/';

if (move_uploaded_file($_FILES['file']['tmp_name'], $uploads_dir.basename($_FILES['file']['name']))) {
	echo "Success";
}else{
	 
	echo "Fail : ".$_FILES['file']['error'];
}

/*
if (move_uploaded_file($_FILES['file']['tmp_name'], $uploads_dir.$_FILES["file"]['name'])) {
    echo "Uploaded";
} else {
    $html_body = '<h1>File upload error!</h1>';
   switch ($_FILES[0]['error']) {
   case 1:
      $html_body .= 'The file is bigger than this PHP installation allows';
      break;
   case 2:
      $html_body .= 'The file is bigger than this form allows';
      break;
   case 3:
      $html_body .= 'Only part of the file was uploaded';
      break;
   case 4:
      $html_body .= 'No file was uploaded';
      break;
   default:
      $html_body .= 'unknown errror'.
   } 
   echo ($html_body);
}
*/

// 2 디비 접속
// 3 해당 유저 id 사진의 Path Update



?>