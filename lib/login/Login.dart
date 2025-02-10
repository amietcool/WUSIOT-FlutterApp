import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wusiotapp/api/ApiResponse.dart';
import 'package:wusiotapp/api/WebServiceRequests.dart';
import 'package:wusiotapp/login/VerifyOtp.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController mobileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Sign in to your \n Account',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign:TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter phone number to send one time password',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10), // Limits to 10 digits
                  FilteringTextInputFormatter.digitsOnly, // Allows only numbers
                ],
              decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle: const TextStyle(color: Colors.black26), // Label color
                // Default border
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.amber),
                ),

                // Border when enabled but not focused
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.amber, width: 2.0),
                ),

                // Border when the TextField is focused
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.amber, width: 3.0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'By Logging in I agree to the Terms and Conditions',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                String mobile = mobileController.text;
                loginApi(context, mobile);
              },
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all<Size>(const Size(double.infinity, 50)), // Full width button
                backgroundColor: WidgetStateProperty.all<Color>(Colors.amber),
              ),
              child: const Text(
                "Generate OTP",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loginApi(BuildContext context,String mobile) async {
    final api = WebServiceRequests();

    // Generate OTP Example
    try {
      final response = await api.otp(mobile);
      print(response.data);

      // Decode the JSON string
      Map<String, dynamic> jsonMap = jsonDecode(response.toString());
      ApiResponse responseCode = ApiResponse.fromJson(jsonMap);

      print('Response Code: ${responseCode.responseCode}');
      print('Success Message: ${responseCode.successMessage}');
      print('Message: ${responseCode.data.message}');
      print('OTP: ${responseCode.data.otp}');
      _showToast(responseCode.data.otp);
      if(responseCode.responseCode == 200){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VerifyOtp(mobile))
        );
      }else{
        _showToast(responseCode.successMessage);
      }

    } catch (e) {
      print(e);
    }
  }

  void _showToast(message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
      gravity: ToastGravity.BOTTOM, // where you want the toast to appear
      timeInSecForIosWeb: 1, // duration for iOS
      backgroundColor: Colors.amber,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

}
