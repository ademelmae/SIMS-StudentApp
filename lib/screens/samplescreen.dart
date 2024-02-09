import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  TextEditingController studentIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: studentIdController,
              decoration: const InputDecoration(labelText: 'Student ID'),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                getStudentDetails();
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void getStudentDetails() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.254.113:7203/api/auth/getstudentdetails')); // Replace with your API endpoint

      if (response.statusCode == 200) {
        print('Student details fetched successfully:');
        print(response.body);
      } else {
        print(
            'Failed to fetch student details. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void login() async {
    String studentId = studentIdController.text;
    String password = passwordController.text;

    // Create a map with the data
    Map<String, dynamic> data = {
      'studentId': studentId,
      'password': password,
    };

    // Convert the map to a JSON string
    String jsonData = jsonEncode(data);

    try {
      final httpClient = HttpClient();

      // Allow self-signed certificates for testing
      httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      var uri = Uri.parse('https://192.168.254.113:443/api/auth/login');

      // Use the client for making requests with custom badCertificateCallback
      var request = await httpClient.postUrl(uri);
      request.headers.set('Content-Type', 'application/json');
      request.write(jsonData);

      var response = await request.close();

      // Check the response status code
      if (response.statusCode == 200) {
        print('Login successful');
        // You can navigate to the next screen or perform other actions here
      } else {
        print(jsonData);
        print('Login failed. Status code: ${response.statusCode}');
        print(
            'Response Body: ${await response.transform(utf8.decoder).join()}');

        // Handle login failure
      }
    } catch (e) {
      print('Error: $e');
      // Handle other errors
    }
  }
}
