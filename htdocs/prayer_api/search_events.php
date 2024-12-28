<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');
$servername = "localhost";
$username = "root"; // Default username
$password = ""; // Default password for XAMPP
$dbname = "prayer_request"; // Your database name

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die(json_encode(["error" => "Connection failed: " . $conn->connect_error]));
}

// Fetch prayer requests
$sql = "SELECT * FROM prayer ORDER BY created_at DESC";
$result = $conn->query($sql);

$requests = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $requests[] = $row;
    }
}
echo json_encode($requests);

$conn->close();
?>