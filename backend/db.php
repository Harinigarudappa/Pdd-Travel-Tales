<?php
$host = "localhost";
$username = "root";  // Change if needed
$password = "";      // Change if needed
$dbname = "travtls"; // Change to your database name

$conn = new mysqli($host, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
