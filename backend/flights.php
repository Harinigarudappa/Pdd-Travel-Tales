<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include 'db.php';

$source = $_GET['source'];
$destination = $_GET['destination'];

$sql = "SELECT id, airline, price, departure, arrival, source, destination FROM flights WHERE source = ? AND destination = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ss", $source, $destination);
$stmt->execute();
$result = $stmt->get_result();

$flights = array();

if ($result->num_rows > 0) {
    // output data of each row
    while($row = $result->fetch_assoc()) {
        $flights[] = $row;
    }
    echo json_encode($flights);
} else {
    echo json_encode(array());
}
$conn->close();
?>