<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

// Your existing code...
header('Content-Type: application/json');
$servername = "localhost";
$username = "root"; 
$password = ""; 
$dbname = "church_calendar";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fetch all events
$sql = "SELECT id, name, description, created_at FROM events ORDER BY created_at DESC";
$result = $conn->query($sql);

$events = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $events[] = $row;
    }
}

echo json_encode($events);
$conn->close();
?>
