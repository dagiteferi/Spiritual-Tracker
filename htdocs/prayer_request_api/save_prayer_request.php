<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Content-Type: application/json; charset=UTF-8");

// Database credentials
$host = "localhost";
$user = "root"; // Default XAMPP user
$password = ""; // Default XAMPP password
$dbname = "prayer_requests_db";

// Create a connection
$conn = new mysqli($host, $user, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get POST data
$data = json_decode(file_get_contents("php://input"), true);

$name = isset($data['name']) ? $data['name'] : null;
$request = $data['request'];

// Insert into database
$sql = "INSERT INTO prayer_requests (name, request) VALUES (?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ss", $name, $request);

if ($stmt->execute()) {
    echo json_encode(["status" => "success", "message" => "Prayer request saved successfully."]);
} else {
    echo json_encode(["status" => "error", "message" => "Failed to save prayer request."]);
}

$stmt->close();
$conn->close();
?>
