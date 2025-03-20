<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

include 'db.php';

// Handle API requests
$request_method = $_SERVER["REQUEST_METHOD"];

switch ($request_method) {
    case "GET":
        if (isset($_GET["flight_id"])) {
            getFlightDetails($conn, $_GET["flight_id"]);
        } else {
            getAllFlights($conn);
        }
        break;

    case "POST":
        $data = json_decode(file_get_contents("php://input"), true);
        if (isset($data["name"], $data["email"], $data["mobile"], $data["flight_id"])) {
            bookFlight($conn, $data);
        } else {
            echo json_encode(["error" => "Missing required fields"]);
        }
        break;

    default:
        echo json_encode(["error" => "Invalid Request"]);
}

$conn->close();

// Fetch all flights
function getAllFlights($conn) {
    $sql = "SELECT * FROM flights";
    $result = $conn->query($sql);
    $flights = [];
    
    while ($row = $result->fetch_assoc()) {
        $flights[] = $row;
    }

    echo json_encode($flights);
}

// Fetch flight details
function getFlightDetails($conn, $flight_id) {
    $sql = "SELECT * FROM flights WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("i", $flight_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($row = $result->fetch_assoc()) {
        echo json_encode($row);
    } else {
        echo json_encode(["error" => "Flight not found"]);
    }
}

// Book a flight
function bookFlight($conn, $data) {
    $sql = "INSERT INTO passengers (name, email, mobile, flight_id) VALUES (?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("sssi", $data["name"], $data["email"], $data["mobile"], $data["flight_id"]);

    if ($stmt->execute()) {
        echo json_encode(["success" => "Flight booked successfully"]);
    } else {
        echo json_encode(["error" => "Booking failed"]);
    }
}
?>
