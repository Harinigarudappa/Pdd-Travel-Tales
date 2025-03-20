import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'flightsearch.dart';

void main() {
  runApp(const beachdestination());
}

class beachdestination extends StatelessWidget {
  const beachdestination({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TravelPageView(),
    );
  }
}

class TravelPageView extends StatefulWidget {
  const TravelPageView({super.key});

  @override
  _TravelPageViewState createState() => _TravelPageViewState();
}

class _TravelPageViewState extends State<TravelPageView> {
  final PageController _pageController = PageController();
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        children: [
          GoaPage(position: _currentPosition),
          AndamanPage(position: _currentPosition),
          KovalamPage(position: _currentPosition),
          PuriPage(position: _currentPosition),
          GokarnaPage(position: _currentPosition),
          VarkalaPage(position: _currentPosition),
          PondicherryPage(position: _currentPosition),
          LakshadweepPage(position: _currentPosition),
          DamanPage(position: _currentPosition),
          DiuPage(position: _currentPosition),
        ],
      ),
    );
  }
}

class CityPage extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  final double latitude;
  final double longitude;
  final Position? currentPosition;

  const CityPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.latitude,
    required this.longitude,
    this.currentPosition,
  });

  @override
  _CityPageState createState() => _CityPageState();
}

class _CityPageState extends State<CityPage> {
  final TextEditingController _searchController = TextEditingController();
  Location? _searchedLocation;
  double? _searchedDistance;

  Future<void> _calculateSearchedDistance(String location) async {
    try {
      List<Location> locations = await locationFromAddress(location);
      if (locations.isNotEmpty) {
        setState(() {
          _searchedLocation = locations.first;
          _searchedDistance = Geolocator.distanceBetween(
                widget.latitude,
                widget.longitude,
                _searchedLocation!.latitude,
                _searchedLocation!.longitude,
              ) /
              1000;
        });
      }
    } catch (e) {
      setState(() {
        _searchedLocation = null;
        _searchedDistance = null;
      });
    }
  }

  double _calculateDistanceToCity() {
    if (widget.currentPosition == null) return 0.0;
    double distance = Geolocator.distanceBetween(
          widget.currentPosition!.latitude,
          widget.currentPosition!.longitude,
          widget.latitude,
          widget.longitude,
        ) /
        1000;
    return double.parse(distance.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade300,
        elevation: 0,
        title: Text(widget.title, style: const TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Search Location...",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) {
                _calculateSearchedDistance(value);
              },
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                widget.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
            const SizedBox(height: 16),
            Text(widget.title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Distance from your location: ${_calculateDistanceToCity()} km",
                style: const TextStyle(fontSize: 18, color: Colors.blueGrey)),
            if (_searchedDistance != null)
              Text("Distance to searched location: ${_searchedDistance!.toStringAsFixed(2)} km",
                  style: const TextStyle(fontSize: 18, color: Colors.red)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade300, blurRadius: 4)
                ],
              ),
              child: Text(
                widget.description,
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyApp()));// Implement search flights functionality
                },
                child: const Text("Search Flights",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoaPage extends StatelessWidget {
  final Position? position;
  const GoaPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/goa.png',
      title: 'Goa',
      description: "Goa, known for its pristine beaches, vibrant nightlife, and Portuguese heritage. Popular beaches include Calangute, Baga, and Anjuna. Goa is also famous for its seafood, flea markets, and water sports.",
      latitude: 15.2993,
      longitude: 74.1240,
      currentPosition: position,
    );
  }
}

class AndamanPage extends StatelessWidget {
  final Position? position;
  const AndamanPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/andaman.png',
      title: 'Andaman',
      description: "Andaman and Nicobar Islands, known for their crystal-clear waters, white sandy beaches, and coral reefs. Popular spots include Radhanagar Beach, Cellular Jail, and Havelock Island.",
      latitude: 11.7401,
      longitude: 92.6586,
      currentPosition: position,
    );
  }
}

class KovalamPage extends StatelessWidget {
  final Position? position;
  const KovalamPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/kovalam.png',
      title: 'Kovalam',
      description: "Kovalam, a beach town in Kerala, famous for its crescent-shaped beaches and lighthouse. It's a perfect destination for relaxation, Ayurvedic treatments, and water sports.",
      latitude: 8.3666,
      longitude: 76.9969,
      currentPosition: position,
    );
  }
}

class PuriPage extends StatelessWidget {
  final Position? position;
  const PuriPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/puri.png',
      title: 'Puri',
      description: "Puri, a coastal city in Odisha, known for its golden beaches and the iconic Jagannath Temple. Puri Beach is a popular spot for pilgrims and tourists alike.",
      latitude: 19.8135,
      longitude: 85.8312,
      currentPosition: position,
    );
  }
}

class GokarnaPage extends StatelessWidget {
  final Position? position;
  const GokarnaPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/gokarna.png',
      title: 'Gokarna',
      description: "Gokarna, a serene beach town in Karnataka, known for its pristine beaches and religious significance. Popular beaches include Om Beach, Kudle Beach, and Half Moon Beach.",
      latitude: 14.5477,
      longitude: 74.3188,
      currentPosition: position,
    );
  }
}

class VarkalaPage extends StatelessWidget {
  final Position? position;
  const VarkalaPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/varkala.png',
      title: 'Varkala',
      description: "Varkala, a coastal town in Kerala, known for its stunning cliffs and Papanasam Beach. It's a popular destination for Ayurvedic treatments and yoga retreats.",
      latitude: 8.7333,
      longitude: 76.7167,
      currentPosition: position,
    );
  }
}

class PondicherryPage extends StatelessWidget {
  final Position? position;
  const PondicherryPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/pondichery.png',
      title: 'Pondicherry',
      description: "Pondicherry, a union territory known for its French colonial heritage and serene beaches. Popular beaches include Promenade Beach and Paradise Beach.",
      latitude: 11.9139,
      longitude: 79.8145,
      currentPosition: position,
    );
  }
}

class LakshadweepPage extends StatelessWidget {
  final Position? position;
  const LakshadweepPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/lakshadweep.png',
      title: 'Lakshadweep',
      description: "Lakshadweep, a group of islands in the Arabian Sea, known for their coral reefs, turquoise waters, and white sandy beaches. Popular activities include snorkeling and scuba diving.",
      latitude: 10.5667,
      longitude: 72.6417,
      currentPosition: position,
    );
  }
}

class DamanPage extends StatelessWidget {
  final Position? position;
  const DamanPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/daman.png',
      title: 'Daman',
      description: "Daman, a coastal town in Gujarat, known for its beautiful beaches and Portuguese architecture. Popular beaches include Jampore Beach and Devka Beach.",
      latitude: 20.4283,
      longitude: 72.8397,
      currentPosition: position,
    );
  }
}

class DiuPage extends StatelessWidget {
  final Position? position;
  const DiuPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/diu.png',
      title: 'Diu',
      description: "Diu, a small island off the coast of Gujarat, known for its serene beaches and Portuguese forts. Popular beaches include Nagoa Beach and Ghoghla Beach.",
      latitude: 20.7144,
      longitude: 70.9874,
      currentPosition: position,
    );
  }
}