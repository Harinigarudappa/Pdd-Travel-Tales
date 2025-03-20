import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'flightticket.dart'; // Ensure this file contains the FlightTicket class

class PaymentScreen extends StatefulWidget {
  final Map<String, String> flightDetails;
  final Map<String, String> passengerDetails;

  const PaymentScreen({super.key, required this.flightDetails, required this.passengerDetails});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late Razorpay _razorpay;
  bool _isProcessing = true; // Show loader initially

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // Automatically trigger Razorpay checkout
    WidgetsBinding.instance.addPostFrameCallback((_) => openCheckout());
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_HhsOEvvf2Mk23e', // Replace with actual Razorpay key
      'amount': (double.parse(widget.flightDetails['price']!.replaceAll('₹', '')) * 100).toInt(), // Convert ₹ to paise
      'currency': 'INR',
      'name': 'Travel Agency',
      'description': 'Flight Ticket Booking',
      'prefill': {
        'contact': widget.passengerDetails['mobile'],
        'email': widget.passengerDetails['email'],
      },
      'theme': {'color': '#3399cc'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
      setState(() => _isProcessing = false); // Stop loader
      _showErrorDialog("Payment Error", "An unexpected error occurred.");
    }
  }

 void _handlePaymentSuccess(PaymentSuccessResponse response) {
  print('Flight Details: ${widget.flightDetails}'); // Add this line
  setState(() => _isProcessing = false);
  // Rest of the code...
 // Stop loader

    // Navigate to Ticket Confirmation Page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => FlightTicket(
          flight: {
            'source': widget.flightDetails['startDestination'] ?? 'Not Available', // Updated key
            'destination': widget.flightDetails['endDestination'] ?? 'Not Available', // Updated key
            'seatClass': widget.flightDetails['seatClass'] ?? 'Not Available',
            'price': widget.flightDetails['price'] ?? 'Not Available',
          },
          passengerName: widget.passengerDetails['name']!,
          email: widget.passengerDetails['email']!,
          mobile: widget.passengerDetails['mobile']!,
          userId: 12345, // Add the required userId parameter
        ),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() => _isProcessing = false); // Stop loader
    _showErrorDialog("Payment Failed", "Error: ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    setState(() => _isProcessing = false); // Stop loader
    _showErrorDialog("External Wallet", "Wallet: ${response.walletName}");
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Processing Payment...')),
      body: Center(
        child: _isProcessing
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Processing your payment..."),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 50),
                  const SizedBox(height: 10),
                  const Text("Payment failed. Please try again."),
                  ElevatedButton(
                    onPressed: openCheckout,
                    child: const Text("Retry Payment"),
                  ),
                ],
              ),
      ),
    );
  }
}