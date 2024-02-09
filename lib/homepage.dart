import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:studentapp/screens/home_screen.dart';
import 'package:studentapp/screens/profile_screen.dart';
import 'package:studentapp/screens/signin_screen.dart';
import 'package:studentapp/screens/violation_screen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final String studentIdNum;

  const HomePage({super.key, required this.studentIdNum});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // @override
  // void initState() {
  //   super.initState();
  //   _configureFirebaseMessaging();
  // }

  // void _configureFirebaseMessaging() {
  //   _firebaseMessaging.getToken().then((token) {
  //     print("FCM Token: $token");
  //     // Send this token to your .NET server for identification
  //   });

  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print("Received message: ${message.notification?.title}");
  //     // Handle the received message
  //   });

  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print("App opened from notification: ${message.notification?.title}");
  //     // Handle the opened app from notification
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    print('Student ID: ${widget.studentIdNum}');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/images/guidancelogo.png',
              height: 60,
            ),
            const SizedBox(
              width: 4,
              height: 30,
            ),
            const Text(
              'SASO-IMS',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 40, 184, 184),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'logout',
                child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Log Out'),
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'logout') {
                // Perform logout action
                _showLogoutDialog(); // Show a confirmation dialog if needed
              }
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeContent(),
          _buildViolationScreen(),
          _buildProfileScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.teal, // Use your preferred color
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            backgroundColor: Colors.transparent,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: const Color.fromARGB(255, 11, 88, 73),
            padding: const EdgeInsets.all(16),
            gap: 8,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
                onPressed: () => _showHomeContent(),
              ),
              GButton(
                icon: Icons.warning_amber,
                text: 'Violations',
                onPressed: () => _showViolationScreen(),
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
                onPressed: () => _showProfileScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeContent() {
    return MyHomePage(studentIdNum: widget.studentIdNum);
  }

  void _showHomeContent() {
    setState(() {
      _currentIndex = 0;
    });
  }

  void _showViolationScreen() {
    setState(() {
      _currentIndex = 1;
    });
  }

  void _showProfileScreen() {
    setState(() {
      _currentIndex = 2;
    });
  }

  Widget _buildProfileScreen() {
    return ProfileScreen(studentIdNum: widget.studentIdNum);
  }

  Widget _buildViolationScreen() {
    return ViolationScreen(studentIdNum: widget.studentIdNum);
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _performLogout();
              },
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );
  }

  void _performLogout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }
}
