import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookedFlightsScreen extends StatefulWidget {
  final int userId; // Pass userId to filter bookings by user if needed

  const BookedFlightsScreen({super.key, required this.userId});

  @override
  _BookedFlightsScreenState createState() => _BookedFlightsScreenState();
}

class _BookedFlightsScreenState extends State<BookedFlightsScreen> {
  List<Map<String, dynamic>> bookedFlights = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBookedFlights();
  }

  Future<void> fetchBookedFlights() async {
    try {
      final response = await http.get(
        Uri.parse(
            "http://192.168.172.146/backend/booked_flights.php?user_id=${widget.userId}"),
      );

      if (response.statusCode == 200) {
        setState(() {
          bookedFlights =
              List<Map<String, dynamic>>.from(json.decode(response.body));
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load booked flights");
      }
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booked Flights"),
        backgroundColor: Colors.blueAccent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : bookedFlights.isEmpty
              ? const Center(child: Text("No booked flights found."))
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: bookedFlights.length,
                  itemBuilder: (context, index) {
                    final flight = bookedFlights[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Booking ID: ${flight['booking_id']}",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text("From: ${flight['source']}"),
                            Text("To: ${flight['destination']}"),
                            Text("Seat Class: ${flight['seat_class']}"),
                            Text("Price: ${flight['price']}"),
                            const SizedBox(height: 10),
                            Text("Passenger: ${flight['passenger_name']}"),
                            Text("Email: ${flight['email']}"),
                            Text("Mobile: ${flight['mobile']}"),
                            Text("Booked on: ${flight['booking_date']}"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
