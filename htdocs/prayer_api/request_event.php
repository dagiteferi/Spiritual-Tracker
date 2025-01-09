<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');
header('Content-Type: application/json');
$response = array('success' => false, 'message' => '');

$servername = "localhost";
$username = "root"; // Default XAMPP username
$password = ""; // Default XAMPP password
$dbname = "prayer_request"; // Your database name

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die(json_encode(["success" => false, "error" => "Connection failed: " . $conn->connect_error]));
}

// Get data from POST request
$name = $_POST['name'] ?? null;
$request = $_POST['request'] ?? null;

// Prepare and bind
$stmt = $conn->prepare("INSERT INTO prayer (name, request) VALUES (?, ?)");
$stmt->bind_param("ss", $name, $request);

// Execute and check if successful
if ($stmt->execute()) {
    echo json_encode(["success" => true]);
} else {
    echo json_encode(["success" => false, "error" => "Error: " . $stmt->error]);
}

$stmt->close();
$conn->close();
?>