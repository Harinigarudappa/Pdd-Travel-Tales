<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include 'db.php';  // Ensure 'db.php' correctly connects to the database

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->email) && !empty($data->password)) {
    $email = $conn->real_escape_string($data->email);
    $password = $conn->real_escape_string($data->password); // Escape input

    // Use a prepared statement to prevent SQL injection
    $stmt = $conn->prepare("SELECT id, name, email, password, created_at FROM users WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        
        // Direct string comparison for password (if stored in plain text)
        if ($password === $user['password']) {
            echo json_encode([
                "success" => true, 
                "message" => "Login successful",
                "user_id" => $user['id'],
                "name" => $user['name'],
                "email" => $user['email'],
                "created_at" => $user['created_at']
            ]);
        } else {
            echo json_encode(["success" => false, "message" => "Invalid password"]);
        }
    } else {
        echo json_encode(["success" => false, "message" => "User not found"]);
    }
    
    $stmt->close();
} else {
    echo json_encode(["success" => false, "message" => "Please provide email and password"]);
}

$conn->close();
?>
