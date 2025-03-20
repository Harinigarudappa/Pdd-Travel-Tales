import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dashboard.dart';
import 'signup.dart';
import 'dart:developer';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  Future<void> login() async {
    const String apiUrl = "http://192.168.172.146/backend/login.php"; // Emulator IP

    try {
      log('🔵 Sending request to: $apiUrl');
      log('📧 Email: ${emailController.text}');
      log('🔑 Password: ${passwordController.text}');

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      ).timeout(const Duration(seconds: 15));

      log('🟢 Response status: ${response.statusCode}');
      log('📜 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data["success"] == true) {
          log("✅ Login successful! Navigating to Dashboard...");

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardScreen(
                userId: data["user_id"], 
                userName: data["name"],  
                userEmail: data["email"],
                createdAt: data["created_at"],
              ),
            ),
          );
        } else {
          setState(() {
            errorMessage = data["message"] ?? "Login failed.";
          });
        }
      } else {
        setState(() {
          errorMessage = "⚠️ Server error: ${response.statusCode} - ${response.body}";
        });
      }
    } catch (e) {
      log('❌ Error: $e');
      setState(() {
        errorMessage = "⚠️ Network error. Please try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/login.jpeg',
              width: double.infinity,
              height: 280,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text("Hello again!",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue)),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Email",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  TextField(
                      controller: emailController,
                      decoration: const InputDecoration(hintText: "Enter your email")),
                  const SizedBox(height: 15),
                  const Text("Password",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration:
                          const InputDecoration(hintText: "Enter your password")),
                  const SizedBox(height: 10),
                  Text(errorMessage, style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: login,
                      child: const Text("Login",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        },
                        child: const Text("Sign up",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
