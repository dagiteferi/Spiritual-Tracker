<?php
$servername = "localhost";
$username = "root"; // Default XAMPP username
$password = ""; // Default XAMPP password
$dbname = "church_events";

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

header("Content-Type: application/json");

// Handle GET request to fetch events
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $sql = "SELECT * FROM events ORDER BY created_at DESC";
    $result = $conn->query($sql);

    $events = [];
    while ($row = $result->fetch_assoc()) {
        $events[] = $row;
    }

    echo json_encode($events);
    exit;
}

// Handle POST request to add a new event
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);

    $name = $data['name'];
    $church_name = $data['church_name'];
    $city = $data['city'];
    $address = $data['address'];
    $description = $data['description'];

    $sql = "INSERT INTO events (name, church_name, city, address, description) VALUES (?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("sssss", $name, $church_name, $city, $address, $description);

    if ($stmt->execute()) {
        echo json_encode(["success" => true, "message" => "Event added successfully."]);
    } else {
        echo json_encode(["success" => false, "message" => "Failed to add event."]);
    }

    $stmt->close();
    exit;
}

$conn->close();
?>
