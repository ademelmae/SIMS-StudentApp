import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViolationScreen extends StatefulWidget {
  final String studentIdNum;

  const ViolationScreen({super.key, required this.studentIdNum});

  @override
  _ViolationScreenState createState() => _ViolationScreenState();
}

class _ViolationScreenState extends State<ViolationScreen> {
  List<String> violationType = [];
  List<String> violationDate = [];
  List<String> violationTime = [];
  List<String> offenseLevel = [];
  List<String> offenseType = [];
  List<String> description = [];
  List<String> disciplinaryAction = [];
  List<String> status = [];
  String? studentFirstName;
  String? studentMiddleName;
  String? studentLastName;
  String? course;
  late http.Client client;

  @override
  void initState() {
    super.initState();
    client = http.Client();
    studentFirstName = '';
    course = '';
    fetchViolationDetails();
    fetchProfileDetails();
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
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
          course = data['course'];
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

  void _showViolationDetails(
    String type,
    String date,
    String time,
    String offenseLevel,
    String offenseType,
    String description,
    String disciplinaryAction,
    String status,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          child: contentBox(type, date, time, offenseLevel, offenseType,
              description, disciplinaryAction, status),
        );
      },
    );
  }

  Widget contentBox(
    String type,
    String date,
    String time,
    String offenseLevel,
    String offenseType,
    String description,
    String disciplinaryAction,
    String status,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Violation Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(Icons.dangerous, color: Colors.red),
                  title: Text('Type: $type'),
                ),
                ListTile(
                  leading: const Icon(Icons.date_range, color: Colors.blue),
                  title: Text('Date: $date'),
                ),
                ListTile(
                  leading: const Icon(Icons.access_time, color: Colors.blue),
                  title: Text('Time: $time'),
                ),
                ListTile(
                  leading:
                      const Icon(Icons.assistant_photo, color: Colors.orange),
                  title: Text('Offense Level: $offenseLevel'),
                ),
                ListTile(
                  leading: const Icon(Icons.description, color: Colors.orange),
                  title: Text('Offense Type: $offenseType'),
                ),
                ListTile(
                  leading: const Icon(Icons.subject, color: Colors.orange),
                  title: Text('Description: $description'),
                ),
                ListTile(
                  leading: const Icon(Icons.gavel, color: Colors.orange),
                  title: Text('Disciplinary Action: $disciplinaryAction'),
                ),
                ListTile(
                  leading: const Icon(Icons.access_time, color: Colors.blue),
                  title: Text('Status: $status'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchViolationDetails() async {
    String studentIdNum = widget.studentIdNum;
    print(studentIdNum);
    try {
      final response = await client.get(
        Uri.parse(
            'https://192.168.254.106:7203/api/Student/getviolationdetails?studentIdNum=$studentIdNum'),
      );

      print('Response Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          violationType =
              List<String>.from(data.map((item) => item['violationType']));
          violationDate =
              List<String>.from(data.map((item) => item['violationDate']));
          violationTime =
              List<String>.from(data.map((item) => item['violationTime']));
          offenseLevel =
              List<String>.from(data.map((item) => item['offenseLevel']));
          offenseType =
              List<String>.from(data.map((item) => item['offenseType']));
          description =
              List<String>.from(data.map((item) => item['description']));
          disciplinaryAction =
              List<String>.from(data.map((item) => item['disciplinaryAction']));
          status = List<String>.from(data.map((item) => item['status']));
        });
      } else {
        print(
            'Failed to load student data. Server returned ${response.statusCode}');
        print('Error Message: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 3, 169, 191),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$studentFirstName $studentMiddleName $studentLastName',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '$course',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: violationType.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.green,
                          size: 100,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'No violations recorded',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: violationType.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _showViolationDetails(
                            violationType[index],
                            violationDate[index],
                            violationTime[index],
                            offenseLevel[index],
                            offenseType[index],
                            description[index],
                            disciplinaryAction[index],
                            status[index],
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                Icons.warning,
                                color: Colors.red,
                                size: 30,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      violationType[index],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.access_time,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Time: ${violationTime[index]}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Date: ${violationDate[index]}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
