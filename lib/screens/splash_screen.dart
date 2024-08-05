// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:internshala_mini_clone/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset('assets/images/splash_image.png',),
            ),
            const SizedBox(height: 20),
            const Text.rich(
                      TextSpan(
                        text: 'Welcome ',
                        style: TextStyle(color: Color.fromARGB(255, 10, 151, 194),
                        fontSize: 22), // default text style
                        children: <TextSpan>[
                      TextSpan(text: 'Pupil', style: TextStyle(fontWeight: FontWeight.bold, 
                      fontSize: 22,
                      color: Color.fromARGB(255, 102, 102, 102),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
