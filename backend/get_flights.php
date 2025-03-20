<?php
header("Content-Type: application/json");
include "db.php"; // Include database connection

if (isset($_GET['start']) && isset($_GET['end'])) {
    $start_location = $_GET['start'];
    $end_location = $_GET['end'];

    $sql = "SELECT * FROM flights WHERE start_location = '$start_location' AND end_location = '$end_location'";
    $result = mysqli_query($conn, $sql);

    $flights = [];
    while ($row = mysqli_fetch_assoc($result)) {
        $flights[] = [
            "id" => $row['id'],
            "airline" => $row['airline'],
            "start_location" => $row['start_location'],
            "end_location" => $row['end_location'],
            "departure" => $row['departure_time'],
            "arrival" => $row['arrival_time'],
            "class" => $row['class'],
            "price" => $row['price']
        ];
    }

    if (count($flights) > 0) {
        echo json_encode(["success" => true, "flights" => $flights]);
    } else {
        echo json_encode(["success" => false, "message" => "No flights found"]);
    }

    mysqli_close($conn);
} else {
    echo json_encode(["success" => false, "message" => "Missing parameters"]);
}
?>
