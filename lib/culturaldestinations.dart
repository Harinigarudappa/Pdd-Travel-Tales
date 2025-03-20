import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'flightsearch.dart';

void main() {
  runApp(const TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

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
          TirumalaPage(position: _currentPosition),
          VaranasiPage(position: _currentPosition),
          AgraPage(position: _currentPosition),
          UdaipurPage(position: _currentPosition),
          MysorePage(position: _currentPosition),
          AmritsarPage(position: _currentPosition),
          KhajurahoPage(position: _currentPosition),
          HampiPage(position: _currentPosition),
          LucknowPage(position: _currentPosition),
          PattadakalPage(position: _currentPosition),
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
            Text(
                "Distance from your location: ${_calculateDistanceToCity()} km",
                style: const TextStyle(fontSize: 18, color: Colors.blueGrey)),
            if (_searchedDistance != null)
              Text(
                  "Distance to searched location: ${_searchedDistance!.toStringAsFixed(2)} km",
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

// Cultural Destinations in India

class TirumalaPage extends StatelessWidget {
  final Position? position;
  const TirumalaPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/tirumula.png',
      title: 'Tirumala',
      description:
          "Tirumala, located in the Chittoor district of Andhra Pradesh, is a sacred pilgrimage site known for the Tirumala Venkateswara Temple. It is one of the most visited religious places in the world.",
      latitude: 13.6831,
      longitude: 79.3493,
      currentPosition: position,
    );
  }
}

class VaranasiPage extends StatelessWidget {
  final Position? position;
  const VaranasiPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/varanasi.png',
      title: 'Varanasi',
      description:
          "Varanasi, one of the oldest living cities in the world, is a spiritual and cultural hub. Key attractions include the Ghats of Ganga, Kashi Vishwanath Temple, and Sarnath.",
      latitude: 25.3176,
      longitude: 82.9739,
      currentPosition: position,
    );
  }
}

class AgraPage extends StatelessWidget {
  final Position? position;
  const AgraPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/agra.png',
      title: 'Agra',
      description:
          "Agra is home to the iconic Taj Mahal, a UNESCO World Heritage Site. Other attractions include Agra Fort, Fatehpur Sikri, and Mehtab Bagh.",
      latitude: 27.1767,
      longitude: 78.0081,
      currentPosition: position,
    );
  }
}

class UdaipurPage extends StatelessWidget {
  final Position? position;
  const UdaipurPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/udaipur.png',
      title: 'Udaipur',
      description:
          "Udaipur, the City of Lakes, is known for its royal palaces, serene lakes, and rich cultural heritage. Key attractions include City Palace, Lake Pichola, and Jag Mandir.",
      latitude: 24.5854,
      longitude: 73.7125,
      currentPosition: position,
    );
  }
}

class MysorePage extends StatelessWidget {
  final Position? position;
  const MysorePage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/mysore.png',
      title: 'Mysore',
      description:
          "Mysore is famous for its royal heritage, grand palaces, and vibrant festivals. Key attractions include Mysore Palace, Chamundi Hill, and Brindavan Gardens.",
      latitude: 12.2958,
      longitude: 76.6394,
      currentPosition: position,
    );
  }
}

class AmritsarPage extends StatelessWidget {
  final Position? position;
  const AmritsarPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/amritsar.png',
      title: 'Amritsar',
      description:
          "Amritsar is the spiritual and cultural center of Sikhism. Key attractions include the Golden Temple, Jallianwala Bagh, and Wagah Border.",
      latitude: 31.6340,
      longitude: 74.8723,
      currentPosition: position,
    );
  }
}

class KhajurahoPage extends StatelessWidget {
  final Position? position;
  const KhajurahoPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/khajuraho.png',
      title: 'Khajuraho',
      description:
          "Khajuraho is famous for its group of temples known for their intricate erotic sculptures. Key attractions include the Western Group of Temples and Kandariya Mahadeva Temple.",
      latitude: 24.8315,
      longitude: 79.9235,
      currentPosition: position,
    );
  }
}

class HampiPage extends StatelessWidget {
  final Position? position;
  const HampiPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/hampi.png',
      title: 'Hampi',
      description:
          "Hampi, a UNESCO World Heritage Site, is known for its ancient ruins and temples. Key attractions include Virupaksha Temple, Vittala Temple, and Hampi Bazaar.",
      latitude: 15.3350,
      longitude: 76.4600,
      currentPosition: position,
    );
  }
}

class LucknowPage extends StatelessWidget {
  final Position? position;
  const LucknowPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/lucknow.png',
      title: 'Lucknow',
      description:
          "Lucknow, the capital of Uttar Pradesh, is known for its rich cultural heritage, historical monuments, and delicious cuisine. Key attractions include Bara Imambara, Chota Imambara, and Rumi Darwaza.",
      latitude: 26.8467,
      longitude: 80.9462,
      currentPosition: position,
    );
  }
}

class PattadakalPage extends StatelessWidget {
  final Position? position;
  const PattadakalPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/pattadakal.png',
      title: 'Pattadakal',
      description:
          "Pattadakal, a UNESCO World Heritage Site, is known for its group of temples showcasing a blend of architectural styles. Key attractions include Virupaksha Temple, Mallikarjuna Temple, and Sangameshwara Temple.",
      latitude: 15.9492,
      longitude: 75.8167,
      currentPosition: position,
    );
  }
}
