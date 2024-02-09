import 'package:flutter/material.dart';
import 'package:studentapp/screens/signin_screen.dart';
import 'package:studentapp/widgets/custom_scaffold.dart';
import 'package:studentapp/widgets/welcome_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.fromLTRB(30.0, 100.0, 25.0, 20.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/guidancelogo.png',
                    height: 150.0,
                  ),
                  const SizedBox(height: 10.0),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'SASO-IMS\n',
                            style: TextStyle(
                              fontSize: 45.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '\nStudent App',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  Expanded(
                    child: WelcomeButton(
                      buttonText: 'Sign in',
                      onTap: SignInScreen(),
                      color: Colors.white,
                      textColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
