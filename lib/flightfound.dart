import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'flightbooking.dart';

class FlightScreen extends StatefulWidget {
  final String startDestination;
  final String endDestination;

  const FlightScreen({
    super.key,
    required this.startDestination,
    required this.endDestination,
  });

  @override
  _FlightScreenState createState() => _FlightScreenState();
}

class _FlightScreenState extends State<FlightScreen> {
  List<Map<String, dynamic>> flights = [];

  @override
  void initState() {
    super.initState();
    fetchFlights();
  }

  Future<void> fetchFlights() async {
  final response = await http.get(Uri.parse(
      'http://172.23.17.163/backend/flights.php?source=${widget.startDestination}&destination=${widget.endDestination}'));
  if (response.statusCode == 200) {
    print('Backend Response: ${response.body}'); // Add this line
    setState(() {
      flights = List<Map<String, dynamic>>.from(json.decode(response.body));
    });
  } else {
    throw Exception('Failed to load flights');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flight Found"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: flights.length,
        itemBuilder: (context, index) {
          final flight = flights[index];
          return FlightCard(flight: flight);
        },
      ),
    );
  }
}

class FlightCard extends StatelessWidget {
  final Map<String, dynamic> flight;

  const FlightCard({super.key, required this.flight});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.flight, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  flight['airline'],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  flight['price'],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(flight['departure'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Icon(Icons.flight_takeoff),
                Text(flight['arrival'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 5),
            Text("${flight['source']} → ${flight['destination']}", style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 10),
            const Text("Seat Class: Business Class", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  // Map the flight data to match the keys expected by BookingScreen
                  final Map<String, String> flightData = {
                    'airline': flight['airline'],
                    'startDestination': flight['source'],
                    'endDestination': flight['destination'],
                    'departure': flight['departure'],
                    'arrival': flight['arrival'],
                    'seatClass': 'Business Class', // Hardcoded for now
                    'price': flight['price'],
                    'id': flight['id'].toString(), // Ensure ID is passed as a string
                  };
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingScreen(flight: flightData),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.blue,
                ),
                child: const Text("Book Now"),
              ),
            )
          ],
        ),
      ),
    );
  }
}