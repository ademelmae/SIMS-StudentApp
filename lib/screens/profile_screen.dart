import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  final String studentIdNum;

  const ProfileScreen({super.key, required this.studentIdNum});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? studentFirstName;
  String? studentMiddleName;
  String? studentLastName;
  String? email;
  String? phone;

  @override
  void initState() {
    super.initState();
    studentFirstName = '';
    studentMiddleName = '';
    studentLastName = '';
    email = '';
    phone = ''; // Initialize here
    fetchProfileDetails();
  }

  Future<void> fetchProfileDetails() async {
    String studentIdNum = widget.studentIdNum;
    try {
      final response = await http.get(
        Uri.parse(
            'https://192.168.254.106:7203/api/Student/GetStudentDetail?studentIdNum=$studentIdNum'),
      );

      print('Response Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          studentFirstName = data['firstname'];
          studentMiddleName = data['middlename'];
          studentLastName = data['lastname'];
          email = data['email'];
          phone = data['phone'];
        });
      } else {
        // Handle the error more gracefully
        print(
            'Failed to load student data. Server returned ${response.statusCode}');
        print('Error Message: ${response.body}');
      }
    } catch (error) {
      // Handle other types of errors (e.g., network issues)
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Wrap the entire page in a container
        color: Colors.white, // Set the background color for the entire page
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue, // Updated background color
                ),
                child: const Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.white, // Updated icon color
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '$studentFirstName $studentMiddleName $studentLastName',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Updated text color
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Student',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(
                height: 20,
                thickness: 0, // Set thickness to 0 to remove the border
                color: Colors.transparent, // Set the color to transparent
              ),
              const SizedBox(height: 16),
              buildInfoRow(
                  Icons.email, '$email', Colors.blue), // Pass icon color
              const SizedBox(height: 8),
              buildInfoRow(
                  Icons.phone, '$phone', Colors.blue), // Pass icon color
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(IconData icon, String text, Color iconColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor), // Pass the icon color
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87, // Updated text color
          ),
        ),
      ],
    );
  }
}
