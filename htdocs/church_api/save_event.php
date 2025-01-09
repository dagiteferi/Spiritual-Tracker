<?php

header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
header('Content-Type: application/json');

// Your existing code...
header('Content-Type: application/json');
$response = array('success' => false, 'message' => '');

try {
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "church_calendar";

    $conn = new mysqli($servername, $username, $password, $dbname);

    if ($conn->connect_error) {
        throw new Exception("Connection failed: " . $conn->connect_error);
    }

    // Get data from the POST request
    if (isset($_POST['name']) && isset($_POST['description'])) {
        $name = $conn->real_escape_string($_POST['name']); // Sanitize input
        $description = $conn->real_escape_string($_POST['description']);

        // Save data to the database
        $sql = "INSERT INTO events (name, description) VALUES ('$name', '$description')";
        if ($conn->query($sql) === TRUE) {
            $response['success'] = true;
            $response['message'] = 'Event submitted successfully.';
        } else {
            throw new Exception("Error: " . $sql . "<br>" . $conn->error);
        }
    } else {
        throw new Exception("Name and description must be provided.");
    }

    // Close connection
    $conn->close();
} catch (Exception $e) {
    $response['message'] = $e->getMessage();
}

echo json_encode($response);
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(); // Exit before your main logic
}
?>