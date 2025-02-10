import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wusiotapp/Dashboard.dart';
import 'package:wusiotapp/api/VerifyOtpResponse.dart';
import 'package:wusiotapp/api/WebServiceRequests.dart';
import 'package:wusiotapp/preference/SharedPrefService.dart';

class VerifyOtp extends StatelessWidget {

  final String mobile;

  // Accept the mobile number via the constructor.
  const VerifyOtp(this.mobile, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Globals.userMobileNumber = mobile;
    return const MaterialApp(
      home: OTPScreen(),
    );
  }
}

class Globals {
  static String userMobileNumber = "";
}

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  _OTPScreenState createState() => _OTPScreenState();

}

class _OTPScreenState extends State<OTPScreen> {
  // Focus nodes for each TextField
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();

  // TextEditingControllers for each OTP digit
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();
  final TextEditingController _otpController5 = TextEditingController();
  final TextEditingController _otpController6 = TextEditingController();

  @override
  void dispose() {
    // Dispose the focus nodes when the widget is disposed
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
    _focusNode6.dispose();

    // Dispose controllers
    _otpController1.dispose();
    _otpController2.dispose();
    _otpController3.dispose();
    _otpController4.dispose();
    _otpController5.dispose();
    _otpController6.dispose();

    super.dispose();
  }

  // Combine OTP digits into a single String
  String get otp {
    return _otpController1.text +
        _otpController2.text +
        _otpController3.text +
        _otpController4.text +
        _otpController5.text +
        _otpController6.text;
  }

  @override
  Widget build(BuildContext context) {
    String phone = Globals.userMobileNumber;
    return Scaffold(
      appBar: AppBar(title: const Text("OTP Verification")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Verification OTP",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "We have sent the verification code to your phone number",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildOTPField(_otpController1, _focusNode1, _focusNode2),
                buildOTPField(_otpController2, _focusNode2, _focusNode3),
                buildOTPField(_otpController3, _focusNode3, _focusNode4),
                buildOTPField(_otpController4, _focusNode4, _focusNode5),
                buildOTPField(_otpController5, _focusNode5, _focusNode6),
                buildOTPField(_otpController6, _focusNode6, null),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // When button is pressed, you can access the OTP value
                final enteredOTP = otp;
                verifyOtpApi(context, phone, enteredOTP);
              },
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all<Size>(
                    const Size(double.infinity, 50)), // Full width button
                backgroundColor: WidgetStateProperty.all<Color>(Colors.amber),
              ),
              child: const Text("Confirm OTP",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build OTP input field with custom focus color
  // Modified function to build OTP input field with a controller
  Widget buildOTPField(TextEditingController controller, FocusNode currentFocus,
      FocusNode? nextFocus) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: SizedBox(
        width: 44,
        child: TextField(
          controller: controller,
          focusNode: currentFocus,
          keyboardType: TextInputType.number,
          maxLength: 1,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24),
          decoration: InputDecoration(
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide:
              const BorderSide(
                  color: Colors.amber, width: 2.0), // Custom focused color
            ),
          ),
          onChanged: (value) {
            if (value.length == 1 && nextFocus != null) {
              // Move focus to the next field when a digit is entered
              FocusScope.of(context).requestFocus(nextFocus);
            }
          },
        ),
      ),
    );
  }

  // Function to show the success dialog
  void showLoginSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      // Prevents dialog from closing when tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: const Text("Success!",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, size: 60, color: Colors.green),
              // Success Icon
              SizedBox(height: 10),
              Text("Verified Successfully"),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                redirectToHomeScreen(context); // Redirect after closing dialog
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.amber),
              ),
              child: const Text("Continue",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
            ),
          ],
        );
      },
    );
  }

  // Function to handle redirection after dialog is closed
  void redirectToHomeScreen(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Redirecting to Home Screen...")),
    );
    // You can navigate to another screen here, e.g.:
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Dashboard()));
  }

  void verifyOtpApi(BuildContext context, String mobile, String otp) async {
    final api = WebServiceRequests();

    // Generate OTP Example
    try {
      final response = await api.otpVerify(mobile, otp);
      //print(response.data);

      // Decode the JSON string into a Map
      Map<String, dynamic> jsonMap = jsonDecode(response.toString());

      // Create an VerifyOtpResponse object from the JSON map
      VerifyOtpResponse responseOtp = VerifyOtpResponse.fromJson(jsonMap);

      // Accessing the parsed data
      print('Response Code: ${responseOtp.responseCode}');
      print('Success Message: ${responseOtp.successMessage}');
      print('Data Message: ${responseOtp.data.message}');
      print('User Name: ${responseOtp.data.user.username}');
      print('Email Address: ${responseOtp.data.user.emailaddress}');

      _showToast(responseOtp.data.message);
      if (responseOtp.responseCode == 200) {
        await SharedPrefService.saveLoginData(responseOtp.data.user.username);
        showLoginSuccessDialog(context);
      } else {
        _showToast(responseOtp.successMessage);
      }
    } catch (e) {
      print(e);
    }
  }

  void _showToast(message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      // or Toast.LENGTH_LONG
      gravity: ToastGravity.BOTTOM,
      // where you want the toast to appear
      timeInSecForIosWeb: 1,
      // duration for iOS
      backgroundColor: Colors.amber,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
