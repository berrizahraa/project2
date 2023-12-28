<?php
// Retrieve the raw POST data
$jsonData = file_get_contents('php://input');
// Decode the JSON data into a PHP associative array
$data = json_decode($jsonData, true);
// Check if decoding was successful
if ($data !== null) {
    $id = addslashes(strip_tags($data['id']));
    $name = addslashes(strip_tags($data['name']));
    $section = addslashes(strip_tags($data['section']));
    $score = addslashes(strip_tags($data['score']));
    $key = addslashes(strip_tags($data['key']));

if ($key != "Zahraaberri2!" or trim($name) == "")
    die("access denied");

    $con=mysqli_connect("localhost","id21040008_user2", "Zahraaberri2!","id21040008_company");
// Check connection
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }

$sql = "insert into students values ($id, '$name' , '$section' , $score)";
mysqli_query($con,$sql) or
    die ("can't add info");

echo "Info Added";
   
mysqli_close($con);
} else {
   // JSON decoding failed
   http_response_code(400); // Bad Request
   echo "Invalid JSON data";
}

?> 		
