import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'flightsearch.dart';

void main() {
  runApp(const PopularDestination());
}

class PopularDestination extends StatelessWidget {
  const PopularDestination({super.key});

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
          MumbaiPage(position: _currentPosition),
          BangalorePage(position: _currentPosition),
          MaduraiPage(position: _currentPosition),
          JaipurPage(position: _currentPosition),
          HyderabadPage(position: _currentPosition),
          CoimbatorePage(position: _currentPosition),
          KochiPage(position: _currentPosition),
          NewDelhiPage(position: _currentPosition),
          KolkataPage(position: _currentPosition),
          NagpurPage(position: _currentPosition),
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
                      builder: (context) => const MyApp(),
                    ),
                  );
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

class MumbaiPage extends StatelessWidget {
  final Position? position;
  const MumbaiPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/mumbai.png',
      title: 'Mumbai',
      description:
          "Mumbai, the city of dreams, known for Bollywood & Marine Drive. It is the financial capital of India and home to the iconic Gateway of India, Chhatrapati Shivaji Maharaj Terminus, and the bustling markets of Colaba Causeway.",
      latitude: 19.0760,
      longitude: 72.8777,
      currentPosition: position,
    );
  }
}

class BangalorePage extends StatelessWidget {
  final Position? position;
  const BangalorePage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/bangalore.png',
      title: 'Bangalore',
      description:
          "Bangalore, the IT hub, known for its pleasant weather. It is also known as the Garden City of India, with beautiful parks like Lalbagh and Cubbon Park. The city is famous for its vibrant nightlife, shopping, and delicious South Indian cuisine.",
      latitude: 12.9716,
      longitude: 77.5946,
      currentPosition: position,
    );
  }
}

class MaduraiPage extends StatelessWidget {
  final Position? position;
  const MaduraiPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/madurai.png',
      title: 'Madurai',
      description:
          "Madurai, the temple city, is known for Meenakshi Amman Temple. It is one of the oldest continuously inhabited cities in the world and is famous for its rich cultural heritage, historical monuments, and vibrant festivals.",
      latitude: 9.9252,
      longitude: 78.1198,
      currentPosition: position,
    );
  }
}

class JaipurPage extends StatelessWidget {
  final Position? position;
  const JaipurPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/jaipur.png',
      title: 'Jaipur',
      description:
          "Jaipur, the Pink City, famous for its palaces and forts. It is the capital of Rajasthan and is known for its rich history, stunning architecture, and vibrant culture. Major attractions include the Hawa Mahal, City Palace, and Amber Fort.",
      latitude: 26.9124,
      longitude: 75.7873,
      currentPosition: position,
    );
  }
}

class HyderabadPage extends StatelessWidget {
  final Position? position;
  const HyderabadPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/hyderabad.png',
      title: 'Hyderabad',
      description:
          "Hyderabad, famous for Charminar and its rich cuisine. It is known as the City of Pearls and is a major center for the technology industry. The city is also famous for its historical sites, including the Golconda Fort and Qutb Shahi Tombs.",
      latitude: 17.3850,
      longitude: 78.4867,
      currentPosition: position,
    );
  }
}

class CoimbatorePage extends StatelessWidget {
  final Position? position;
  const CoimbatorePage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/coimbature.png',
      title: 'Coimbatore',
      description:
          "Coimbatore, the Manchester of South India, known for textiles. It is a major industrial city and is also known for its pleasant climate, educational institutions, and beautiful temples like the Marudamalai Temple.",
      latitude: 11.0168,
      longitude: 76.9558,
      currentPosition: position,
    );
  }
}

class KochiPage extends StatelessWidget {
  final Position? position;
  const KochiPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/kochi.png',
      title: 'Kochi',
      description:
          "Kochi, famous for its backwaters and colonial architecture. It is a major port city in Kerala and is known for its beautiful beaches, historic sites like Fort Kochi, and vibrant culture. The city is also a gateway to the scenic backwaters of Kerala.",
      latitude: 9.9312,
      longitude: 76.2673,
      currentPosition: position,
    );
  }
}

class NewDelhiPage extends StatelessWidget {
  final Position? position;
  const NewDelhiPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/delhi.png',
      title: 'New Delhi',
      description:
          "New Delhi, the capital of India, home to historical landmarks. It is a bustling metropolis with a rich history and is known for its iconic landmarks like India Gate, Red Fort, and Qutub Minar. The city is also famous for its vibrant markets and delicious street food.",
      latitude: 28.6139,
      longitude: 77.2090,
      currentPosition: position,
    );
  }
}

class KolkataPage extends StatelessWidget {
  final Position? position;
  const KolkataPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/kolkata.png',
      title: 'Kolkata',
      description:
          "Kolkata, the City of Joy, rich in culture and literature. It is the cultural capital of India and is known for its literary heritage, artistic traditions, and historical landmarks like Victoria Memorial and Howrah Bridge. The city is also famous for its festivals, especially Durga Puja.",
      latitude: 22.5726,
      longitude: 88.3639,
      currentPosition: position,
    );
  }
}

class NagpurPage extends StatelessWidget {
  final Position? position;
  const NagpurPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/nagpur.png',
      title: 'Nagpur',
      description:
          "Nagpur, the Orange City, famous for its oranges. It is a major commercial and political center in Maharashtra and is known for its rich cultural heritage, beautiful temples, and delicious oranges. The city is also home to the Zero Mile Stone, marking the geographical center of India.",
      latitude: 21.1458,
      longitude: 79.0882,
      currentPosition: position,
    );
  }
}
