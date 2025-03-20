import 'package:flutter/material.dart';
import 'flightfound.dart';
import 'populardestinations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlightSearchScreen(),
    );
  }
}

class FlightSearchScreen extends StatefulWidget {
  const FlightSearchScreen({super.key});

  @override
  _FlightSearchScreenState createState() => _FlightSearchScreenState();
}

class _FlightSearchScreenState extends State<FlightSearchScreen> {
  String tripType = "One Way";
  String startDestination = "Chennai (MAA)";
  String endDestination = "Mumbai (BOM)";
  String seatClass = "Business Class";
  int childCount = 0;
  int infantCount = 0;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 7));

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? startDate : endDate,
      firstDate: DateTime(2024, 1, 1),
      lastDate: DateTime(2030, 12, 31),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flight Search", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue[800],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PopularDestination()),
            );
          },
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trip Type Buttons
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.lightBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  children: [
                    _tripTypeButton("One Way", Icons.flight_takeoff),
                    _tripTypeButton("Round Trip", Icons.flight_land),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Start and End Destination
              _dropdownField("From", Icons.flight_takeoff, _airportList, startDestination, (value) {
                setState(() {
                  startDestination = value!;
                });
              }),
              const SizedBox(height: 20),
              _dropdownField("To", Icons.flight_land, _airportList, endDestination, (value) {
                setState(() {
                  endDestination = value!;
                });
              }),
              const SizedBox(height: 20),

              // Date Fields
              Row(
                children: [
                  Expanded(child: _dateField("Departure", Icons.calendar_today, startDate, true)),
                  const SizedBox(width: 10),
                  if (tripType == "Round Trip")
                    Expanded(child: _dateField("Return", Icons.calendar_today, endDate, false)),
                ],
              ),
              const SizedBox(height: 20),

              // Seat Class
              _dropdownField(
                "Class",
                Icons.airline_seat_recline_extra,
                ["Economy", "Business Class", "First Class"],
                seatClass,
                (value) {
                  setState(() {
                    seatClass = value!;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Passengers
              Row(
                children: [
                  Expanded(child: _passengerSelector("Adults", Icons.person, childCount, (value) {
                    setState(() {
                      childCount = value;
                    });
                  })),
                  const SizedBox(width: 10),
                  Expanded(child: _passengerSelector("Children", Icons.child_care, infantCount, (value) {
                    setState(() {
                      infantCount = value;
                    });
                  })),
                ],
              ),
              const SizedBox(height: 30),

              // Search Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FlightScreen(
                          startDestination: startDestination,
                          endDestination: endDestination,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Search Flights",
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tripTypeButton(String type, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              tripType = type;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: tripType == type ? Colors.blue[800] : Colors.grey[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: tripType == type ? Colors.white : Colors.black),
              const SizedBox(width: 8),
              Text(
                type,
                style: TextStyle(
                  color: tripType == type ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dropdownField(String label, IconData icon, List<String> items, String selectedItem, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[800]),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: DropdownButtonFormField(
            value: selectedItem,
            items: items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              prefixIcon: Icon(icon, color: Colors.blue[800]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dateField(String label, IconData icon, DateTime date, bool isStartDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[800]),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _selectDate(context, isStartDate),
          child: AbsorbPointer(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  prefixIcon: Icon(icon, color: Colors.blue[800]),
                  hintText: "${date.toLocal()}".split(' ')[0],
                ),
                controller: TextEditingController(
                    text: "${date.toLocal()}".split(' ')[0]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _passengerSelector(String label, IconData icon, int value, Function(int) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[800]),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove, color: Colors.blue),
                onPressed: () {
                  if (value > 0) onChanged(value - 1);
                },
              ),
              Text(value.toString(), style: const TextStyle(fontSize: 16)),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.blue),
                onPressed: () {
                  onChanged(value + 1);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  final List<String> _airportList = [
    "Agartala (IXA)",
    "Agatti (AGX)",
    "Agra (AGR)",
    "Ahmedabad (AMD)",
    "Aizawl (AJL)",
    "Amritsar (ATQ)",
    "Aurangabad (IXU)",
    "Ayodhya (AYJ)",
    "Bagdogra (IXB)",
    "Bareilly (BEK)",
    "Belagavi (IXG)",
    "Bengaluru (BLR)",
    "Bhopal (BHO)",
    "Bhubaneswar (BBI)",
    "Chandigarh (IXC)",
    "Chennai (MAA)",
    "Coimbatore (CJB)",
    "Darbhanga (DBR)",
    "Dehradun (DED)",
    "Delhi (DEL)",
    "Deoghar (DGH)",
    "Dharamshala (DHM)",
    "Dibrugarh (DIB)",
    "Dimapur (DMU)",
    "Diu (DIU)",
    "Durgapur (RDP)",
    "Gaya (GAY)",
    "Goa (GOI)",
    "Gondia (GDB)",
    "Gorakhpur (GOP)",
    "Guwahati (GAU)",
    "Gwalior (GWL)",
    "Hirasar (HSR)",
    "Hubli (HBX)",
    "Hyderabad (HYD)",
    "Imphal (IMF)",
    "Indore (IDR)",
    "Itanagar (HGI)",
    "Jabalpur (JLR)",
    "Jagdalpur (JGB)",
    "Jaipur (JAI)",
    "Jaisalmer (JSA)",
    "Jammu (IXJ)",
    "Jharsuguda (JRG)",
    "Jodhpur (JDH)",
    "Jorhat (JRH)",
    "Kadapa (CDP)",
    "Kannur (CNN)",
    "Kanpur (KNU)",
    "Khajuraho (HJR)",
    "Kochi (COK)",
    "Kolhapur (KLH)",
    "Kolkata (CCU)",
    "Kozhikode (CCJ)",
    "Kurnool (KJB)",
    "Leh (IXL)",
    "Lucknow (LKO)",
    "Madurai (IXM)",
    "Mangaluru (IXE)",
    "Mumbai (BOM)",
    "Mysuru (MYQ)",
    "Nagpur (NAG)",
    "Nashik (ISK)",
    "North Goa (GOX)",
    "Pantnagar (PGH)",
    "Patna (PAT)",
    "Port Blair (IXZ)",
    "Prayagraj (IXD)",
    "Pune (PNQ)",
    "Raipur (RPR)",
    "Rajahmundry (RJA)",
    "Rajkot (RAJ)",
    "Ranchi (IXR)",
    "Salem (SXV)",
    "Shillong (SHL)",
    "Shirdi (SAG)",
    "Shivamogga (RQY)",
    "Silchar (IXS)",
    "Srinagar (SXR)",
    "Surat (STV)",
    "Thiruvananthapuram (TRV)",
    "Tiruchirappalli (TRZ)",
    "Tirupati (TIR)",
    "Tuticorin (TCR)",
    "Udaipur (UDR)",
    "Vadodara (BDQ)",
    "Varanasi (VNS)",
    "Vijayawada (VGA)",
    "Visakhapatnam (VTZ)"
  ];
}