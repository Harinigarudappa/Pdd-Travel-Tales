<?php
header('Content-Type: application/json');
include 'db.php'; // Database connection file

// Get JSON input from the request body
$input = json_decode(file_get_contents('php://input'), true);

// Extract data from the input
$user_id = $input['user_id'] ?? null;
$source = $input['source'] ?? '';
$destination = $input['destination'] ?? '';
$seat_class = $input['seat_class'] ?? '';
$price = $input['price'] ?? ''; // Keep as string initially
$passenger_name = $input['passenger_name'] ?? '';
$email = $input['email'] ?? '';
$mobile = $input['mobile'] ?? '';
$booking_date = $input['booking_date'] ?? date('Y-m-d H:i:s');

// Log the input for debugging
error_log("Received input: " . print_r($input, true));
error_log("Price before conversion: " . $price);

// Validate required fields
if (!$user_id || !$source || !$destination || !$seat_class || !$price || !$passenger_name || !$email || !$mobile) {
    echo json_encode([
        "success" => false,
        "error" => "All required fields (user_id, source, destination, seat_class, price, passenger_name, email, mobile) must be provided"
    ]);
    exit;
}

// Convert price to a float/double explicitly
$price = floatval($price); // Convert string to float
error_log("Price after conversion: " . $price);

// Prepare the SQL query with prepared statements
$sql = "INSERT INTO booking (user_id, source, destination, seat_class, price, passenger_name, email, mobile, booking_date) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
$stmt = $conn->prepare($sql);

if ($stmt === false) {
    echo json_encode([
        "success" => false,
        "error" => "Prepare failed: " . $conn->error
    ]);
    exit;
}

// Bind parameters (i for integer, s for string, d for double)
$stmt->bind_param("isssdssss", $user_id, $source, $destination, $seat_class, $price, $passenger_name, $email, $mobile, $booking_date);

if ($stmt->execute()) {
    $booking_id = $conn->insert_id;
    echo json_encode([
        "success" => true,
        "booking_id" => $booking_id,
        "price" => $price, // Return price for confirmation
        "message" => "Booking saved successfully"
    ]);
} else {
    echo json_encode([
        "success" => false,
        "error" => $stmt->error
    ]);
}

// Clean up
$stmt->close();
$conn->close();
?>