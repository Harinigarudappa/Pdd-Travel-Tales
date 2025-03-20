<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

include 'db.php';

// Get JSON input from the request body
$input = json_decode(file_get_contents('php://input'), true);

// Extract data
$user_id = $input['user_id'] ?? null;
$name = $input['name'] ?? '';
$email = $input['email'] ?? '';
$mobile = $input['mobile'] ?? '';

// Validate required fields
if (!$user_id || !$name || !$email || !$mobile) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'All fields (user_id, name, email, mobile) are required']);
    exit;
}

$sql = "UPDATE profiles SET name = :name, email = :email, mobile_number = :mobile WHERE user_id = :user_id";
$stmt = $pdo->prepare($sql);

try {
    $stmt->execute([
        ':name' => $name,
        ':email' => $email,
        ':mobile' => $mobile,
        ':user_id' => $user_id,
    ]);

    if ($stmt->rowCount() > 0) {
        http_response_code(200);
        echo json_encode(['success' => true, 'message' => 'Profile updated successfully']);
    } else {
        // If no rows affected, it might mean the user_id doesn't exist
        http_response_code(404);
        echo json_encode(['success' => false, 'message' => 'User not found or no changes made']);
    }
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Failed to update profile: ' . $e->getMessage()]);
}
?>