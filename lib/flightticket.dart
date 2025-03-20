import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dashboard.dart'; // Adjust the path as necessary

class FlightTicket extends StatefulWidget {
  final Map<String, String> flight;
  final String passengerName;
  final String email;
  final String mobile;
  final int userId; // Add userId to link booking to a user

  const FlightTicket({
    super.key,
    required this.flight,
    required this.passengerName,
    required this.email,
    required this.mobile,
    required this.userId,
  });

  @override
  _FlightTicketState createState() => _FlightTicketState();
}

class _FlightTicketState extends State<FlightTicket> {
  bool isBooking = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _bookFlight(); // Call booking function when the widget loads
  }

Future<void> _bookFlight() async {
  print('Sending price: ${widget.flight['price']}'); // Debug price before sending
  final url = Uri.parse('http://192.168.172.146/backend/bookings.php');
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'user_id': widget.userId,
        'source': widget.flight['source'],
        'destination': widget.flight['destination'],
        'seat_class': widget.flight['seatClass'],
        'price': widget.flight['price'],
        'passenger_name': widget.passengerName,
        'email': widget.email,
        'mobile': widget.mobile,
      }),
    );

    final result = json.decode(response.body);
    print('Server response: $result'); // Debug server response
    if (result['success']) {
      setState(() {
        isBooking = false;
      });
    } else {
      setState(() {
        isBooking = false;
        errorMessage = result['error'];
      });
    }
  } catch (e) {
    setState(() {
      isBooking = false;
      errorMessage = 'Network error: $e';
    });
  }
}

  @override
  Widget build(BuildContext context) {
    if (isBooking) {
      return Scaffold(
        appBar: AppBar(title: const Text('Ticket Confirmation')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Ticket Confirmation')),
        body: Center(
          child: Text(
            'Error: $errorMessage',
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Ticket Confirmation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 10),
            const Text(
              'Booking Confirmed!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Flight Details',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const Divider(),
                  Text('From: ${widget.flight['source'] ?? 'Not Available'}'),
                  Text('To: ${widget.flight['destination'] ?? 'Not Available'}'),
                  Text('Seat Class: ${widget.flight['seatClass'] ?? 'Not Available'}'),
                  Text('Total Paid: ${widget.flight['price'] ?? 'Not Available'}'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Passenger Details',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const Divider(),
                  Text('Name: ${widget.passengerName}'),
                  Text('Email: ${widget.email}'),
                  Text('Mobile: ${widget.mobile}'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(
                      userId: widget.userId, // Use dynamic userId
                      userName: 'Harry', // Replace with actual userName
                      userEmail: 'harini27@gmail.com', // Replace with actual userEmail
                      createdAt: '2025-02-13 14:53:21', // Replace with actual createdAt
                    ),
                  ),
                );
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}