import 'package:flutter/material.dart';

class HolidayPackagesScreen extends StatelessWidget {
  const HolidayPackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Holiday Packages'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: holidayPackages.length,
        itemBuilder: (context, index) {
          final package = holidayPackages[index];
          return HolidayPackageCard(package: package);
        },
      ),
    );
  }
}

class HolidayPackageCard extends StatelessWidget {
  final Map<String, String> package;

  const HolidayPackageCard({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.asset(
              package['image']!,
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Text('Image not found',
                        style: TextStyle(color: Colors.black)),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  package['name']!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Destination: ${package['destination']!}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Duration: ${package['duration']!}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Price: \$${package['price']!}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Sample data for holiday packages
final List<Map<String, String>> holidayPackages = [
  {
    'name': 'Tropical Paradise Getaway',
    'destination': 'Maldives',
    'duration': '7 Days / 6 Nights',
    'price': '1200',
    'image': 'assets/maldives.png',
  },
  {
    'name': 'European Adventure',
    'destination': 'Paris, France',
    'duration': '10 Days / 9 Nights',
    'price': '2500',
    'image': 'assets/paris.png',
  },
  {
    'name': 'Mountain Retreat',
    'destination': 'Swiss Alps',
    'duration': '5 Days / 4 Nights',
    'price': '1800',
    'image': 'assets/swiss_alps.png',
  },
  {
    'name': 'Cultural Exploration',
    'destination': 'Kyoto, Japan',
    'duration': '8 Days / 7 Nights',
    'price': '2200',
    'image': 'assets/kyoto.png',
  },
];