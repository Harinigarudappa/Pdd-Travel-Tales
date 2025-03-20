import 'package:flutter/material.dart';
import 'populardestinations.dart';
import 'beachdestinations.dart';
import 'naturedestinations.dart';
import 'culturaldestinations.dart';
import 'holidaypackage.dart';
import 'booked_flights.dart';
import 'profile.dart';

class DashboardScreen extends StatelessWidget {
  final int userId;
  final String userName;
  final String userEmail;
  final String createdAt;

  DashboardScreen({
    super.key,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.createdAt,
  });

  final List<Map<String, String>> destinations = [
    {'title': 'Popular Destinations', 'image': 'assets/popular.png'},
    {'title': 'Beach Destinations', 'image': 'assets/beach.png'},
    {'title': 'Nature Destinations', 'image': 'assets/nature.png'},
    {'title': 'Cultural Destinations', 'image': 'assets/cultural.png'},
    {'title': 'Holiday Packages', 'image': 'assets/holiday.png'}, 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/profile.png'),
                    radius: 30,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    userEmail,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      userId: userId,
                      userName: userName,
                      userEmail: userEmail,
                      mobileNumber: userEmail,
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.flight),
              title: const Text('Booked Flights'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookedFlightsScreen(userId: userId),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // Added Logout button
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Navigate to the root of the app, removing all previous routes
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen(
                    userId: userId,
                    userName: userName,
                    userEmail: userEmail,
                    createdAt: createdAt,
                  )), // Replace with your login screen widget if different
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.png'),
                ),
                const SizedBox(width: 10),
                Text(
                  'Hi, $userName!',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Choose Places',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: destinations.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      switch (destinations[index]['title']) {
                        case 'Popular Destinations':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PopularDestination(),
                            ),
                          );
                          break;
                        case 'Beach Destinations':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const beachdestination(),
                            ),
                          );
                          break;
                        case 'Nature Destinations':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const naturedestination(),
                            ),
                          );
                          break;
                        case 'Cultural Destinations':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TravelApp(),
                            ),
                          );
                          break;
                        case 'Holiday Packages': // Added case for Holiday Packages
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HolidayPackagesScreen(),
                            ),
                          );
                          break;
                        default:
                          break;
                      }
                    },
                    child: DestinationCard(
                      title: destinations[index]['title']!,
                      imageUrl: destinations[index]['image']!,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const DestinationCard({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image.asset(
              imageUrl,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 120,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Text('Image not found',
                        style: TextStyle(color: Colors.black)),
                  ),
                );
              },
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              color: Colors.black.withOpacity(0.5),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}