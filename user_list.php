<?php
$return["data1"] = array();
include "conn.php";
  
  if(isset($_REQUEST["auth"]))
  {
    $authkey = $_REQUEST["auth"];
    if($authkey == "kjgdkhdfldfguttedfgr")
    {
        $json["data1"] = array();
        $sql = "
SELECT ROW_NUMBER() OVER () AS idy, username, name, datetime1, email
FROM t_user
ORDER BY id asc
";
        
		$res = mysqli_query($connect, $sql);
        $numrows = mysqli_num_rows($res);
        while($array = mysqli_fetch_assoc($res))
        {
          array_push($return["data1"], $array);
        }
        mysqli_close($connect);
        header('Content-Type: application/json');
    }
        else
        {
        $return["error"] = true;
        $return["msg"] = "Authentication error.";
        }
    }
    else{
        $return["error"]  = true;
        $return["msg"] = "Send auth key.";
        }
    header('Content-Type: application/json');
    echo json_encode($return);
    ?>
    
