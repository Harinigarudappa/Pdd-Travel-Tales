import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dashboard.dart'; // Adjust the path as necessary
import 'profile_widgets.dart'; // Import the widgets file

class ProfilePage extends StatefulWidget {
  final int userId;
  final String userName;
  final String userEmail;
  final String mobileNumber;

  const ProfilePage({
    super.key,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.mobileNumber,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill fields with passed data
    _nameController.text = widget.userName;
    _emailController.text = widget.userEmail; // Login email
    _mobileController.text = widget.mobileNumber;
  }

  Future<void> _saveProfile(BuildContext context) async {
    final name = _nameController.text;
    final email = _emailController.text;
    final mobile = _mobileController.text;

    try {
      final response = await http.post(
        Uri.parse('http://192.168.172.146/backend/save_profile.php'), // Adjust URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': widget.userId,
          'name': name,
          'email': email,
          'mobile': mobile,
        }),
      );

      print('Save profile response: ${response.statusCode} - ${response.body}');
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['success']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile saved successfully!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardScreen(
              userId: widget.userId,
              userName: name,
              userEmail: email,
              createdAt: '2025-02-13 14:53:21', // Adjust as needed
            ),
          ),
        );
      } else {
        throw Exception(responseData['message'] ?? 'Failed to save profile');
      }
    } catch (e) {
      print('Error saving profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "My Profile",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: 'Handwritten',
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLabel("Name *"),
            buildInputField("Enter your name", _nameController),
            buildLabel("Mobile Number*"),
            buildInputField("Enter your number", _mobileController),
            buildLabel("Email *"),
            buildInputField("Enter your Email", _emailController, readOnly: true),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                onPressed: () => _saveProfile(context),
                child: Text(
                  "Save changes",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Handwritten',
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}