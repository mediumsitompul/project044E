<?php


include "conn.php";

if(isset($_REQUEST["auth"]))
  {

    $authkey = $_REQUEST["auth"];
    if($authkey == "kjgdkhdfldfguttedfgr")
    {



  if($connect) {
$sql='
SELECT a.username, b.name, COUNT(a.username) AS count
FROM t_user_log a
LEFT JOIN t_user b
ON a.username=b.username
GROUP BY a.username
ORDER by count desc
';

$query=mysqli_query($connect, $sql);
$results=array();


while($row=mysqli_fetch_assoc($query)) {
		$results[]=$row;
}

echo json_encode($results);
}
  }
}

?>
