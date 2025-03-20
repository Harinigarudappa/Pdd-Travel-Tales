<?php
include 'db.php'; // Include database connection

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get JSON data from the request
    $data = json_decode(file_get_contents("php://input"), true);

    // Extract flight details
    $flight_name = $data['flight_name'];
    $airline = $data['airline'];
    $departure = $data['departure'];
    $arrival = $data['arrival'];
    $date = $data['date'];
    $time = $data['time'];
    $price = $data['price'];
    $available_seats = $data['available_seats'];

    // Insert flight into database
    $sql = "INSERT INTO search_flight (flight_name, airline, departure, arrival, date, time, price, available_seats) 
            VALUES ('$flight_name', '$airline', '$departure', '$arrival', '$date', '$time', '$price', '$available_seats')";

    if ($conn->query($sql) === TRUE) {
        echo json_encode(["message" => "Flight added successfully", "status" => true]);
    } else {
        echo json_encode(["message" => "Error: " . $conn->error, "status" => false]);
    }
}

$conn->close();
?>
