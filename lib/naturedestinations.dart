import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'flightsearch.dart';

void main() {
  runApp(const naturedestination());
}

class naturedestination extends StatelessWidget {
  const naturedestination({super.key});

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
          ManaliPage(position: _currentPosition),
          ShimlaPage(position: _currentPosition),
          MunnarPage(position: _currentPosition),
          OotyPage(position: _currentPosition),
          DarjeelingPage(position: _currentPosition),
          NainitalPage(position: _currentPosition),
          CoorgPage(position: _currentPosition),
          MussooriePage(position: _currentPosition),
          KodaikanalPage(position: _currentPosition),
          LehLadakhPage(position: _currentPosition),

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

class ManaliPage extends StatelessWidget {
  final Position? position;
  const ManaliPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/manali.png',
      title: 'Manali',
      description:
          "Manali, a picturesque hill station in Himachal Pradesh, is known for its snow-capped mountains, lush valleys, and adventure sports. Popular attractions include Rohtang Pass, Solang Valley, and Hadimba Temple.",
      latitude: 32.2396,
      longitude: 77.1887,
      currentPosition: position,
    );
  }
}

class ShimlaPage extends StatelessWidget {
  final Position? position;
  const ShimlaPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/shimla.png',
      title: 'Shimla',
      description:
          "Shimla, the capital of Himachal Pradesh, is famous for its colonial architecture, scenic beauty, and pleasant weather. Key attractions include The Ridge, Mall Road, and Jakhu Temple.",
      latitude: 31.1048,
      longitude: 77.1734,
      currentPosition: position,
    );
  }
}

class MunnarPage extends StatelessWidget {
  final Position? position;
  const MunnarPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/munnar.png',
      title: 'Munnar',
      description:
          "Munnar, a hill station in Kerala, is known for its sprawling tea plantations, misty hills, and serene lakes. Popular spots include Eravikulam National Park, Mattupetty Dam, and Tea Museum.",
      latitude: 10.0889,
      longitude: 77.0595,
      currentPosition: position,
    );
  }
}

class OotyPage extends StatelessWidget {
  final Position? position;
  const OotyPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/ooty.png',
      title: 'Ooty',
      description:
          "Ooty, also known as Udhagamandalam, is a popular hill station in Tamil Nadu. It is famous for its botanical gardens, Nilgiri Mountain Railway, and Doddabetta Peak.",
      latitude: 11.4100,
      longitude: 76.6950,
      currentPosition: position,
    );
  }
}

class DarjeelingPage extends StatelessWidget {
  final Position? position;
  const DarjeelingPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/darjeeling.png',
      title: 'Darjeeling',
      description:
          "Darjeeling, a hill station in West Bengal, is renowned for its tea plantations, Himalayan views, and the Darjeeling Himalayan Railway. Key attractions include Tiger Hill, Batasia Loop, and Peace Pagoda.",
      latitude: 27.0360,
      longitude: 88.2627,
      currentPosition: position,
    );
  }
}

class NainitalPage extends StatelessWidget {
  final Position? position;
  const NainitalPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/nainital.png',
      title: 'Nainital',
      description:
          "Nainital, a charming hill station in Uttarakhand, is known for its beautiful Naini Lake, lush hills, and pleasant climate. Popular spots include Naina Devi Temple, Tiffin Top, and Snow View Point.",
      latitude: 29.3803,
      longitude: 79.4636,
      currentPosition: position,
    );
  }
}

class CoorgPage extends StatelessWidget {
  final Position? position;
  const CoorgPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/coorg.png',
      title: 'Coorg',
      description:
          "Coorg, also known as Kodagu, is a nature lover's paradise in Karnataka. It is famous for its coffee plantations, waterfalls, and scenic landscapes. Key attractions include Abbey Falls, Raja's Seat, and Dubare Elephant Camp.",
      latitude: 12.3375,
      longitude: 75.8069,
      currentPosition: position,
    );
  }
}

class MussooriePage extends StatelessWidget {
  final Position? position;
  const MussooriePage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/mussoorie.png',
      title: 'Mussoorie',
      description:
          "Mussoorie, the 'Queen of Hills', is a popular hill station in Uttarakhand. It offers breathtaking views of the Himalayas, lush greenery, and colonial charm. Key attractions include Kempty Falls, Gun Hill, and Lal Tibba.",
      latitude: 30.4598,
      longitude: 78.0644,
      currentPosition: position,
    );
  }
}

class KodaikanalPage extends StatelessWidget {
  final Position? position;
  const KodaikanalPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/kodaikanal.png',
      title: 'Kodaikanal',
      description:
          "Kodaikanal, a serene hill station in Tamil Nadu, is known for its misty hills, lush forests, and beautiful lakes. Popular spots include Kodaikanal Lake, Coaker's Walk, and Pillar Rocks.",
      latitude: 10.2381,
      longitude: 77.4892,
      currentPosition: position,
    );
  }
}

class LehLadakhPage extends StatelessWidget {
  final Position? position;
  const LehLadakhPage({super.key, this.position});

  @override
  Widget build(BuildContext context) {
    return CityPage(
      image: 'assets/leh_ladakh.png',
      title: 'Leh-Ladakh',
      description:
          "Leh-Ladakh, a high-altitude region in Jammu and Kashmir, is known for its stunning landscapes, Buddhist monasteries, and adventure activities. Key attractions include Pangong Lake, Nubra Valley, and Magnetic Hill.",
      latitude: 34.1526,
      longitude: 77.5771,
      currentPosition: position,
    );
  }
}
