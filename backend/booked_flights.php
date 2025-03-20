<?php
header('Content-Type: application/json');
include 'db.php';

$user_id = isset($_GET['user_id']) ? $_GET['user_id'] : null;



// Modify query based on whether user_id is used to filter bookings
$sql = $user_id ? "SELECT * FROM booking WHERE user_id = '$user_id'" : "SELECT * FROM booking";
$result = $conn->query($sql);

$bookings = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $bookings[] = $row;
    }
}

echo json_encode($bookings);

$conn->close();
?>