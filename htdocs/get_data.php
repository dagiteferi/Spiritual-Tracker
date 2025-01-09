<?php
include 'db_config.php';

$sql = "SELECT * FROM neh";
$result = $conn->query($sql);

$data = array();



if (!empty($result) && $result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
}else{


    echo ("not found");
}

echo json_encode($data);
$conn->close();
?>
