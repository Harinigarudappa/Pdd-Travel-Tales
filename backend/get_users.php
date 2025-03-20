<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Content-Type');

include 'db.php';

// Simulate fetching the logged-in user's email
// Replace with actual session/auth logic (e.g., session ID or token)
$loggedInEmail = "harini27@gmail.com"; // Hardcoded for testing; use session/auth in reality

// Query to fetch user by email
$sql = "SELECT email FROM users WHERE email = :email";
$stmt = $pdo->prepare($sql);
$stmt->execute([':email' => $loggedInEmail]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

if ($user) {
    http_response_code(200);
    echo json_encode(['success' => true, 'email' => $user['email']]);
} else {
    http_response_code(404);
    echo json_encode(['success' => false, 'message' => 'User not found']);
}
?>