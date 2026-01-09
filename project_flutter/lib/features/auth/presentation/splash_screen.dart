import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_flutter/features/auth/presentation/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _navigated = false;

  void _goToLogin() {
    if (_navigated) return;
    _navigated = true;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // The decoration provides the gradient background
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.4, 0.7, 0.9], // Optional: fine-tunes where each color starts
            colors: [
              Color(0xFF73AEF5),
              Color(0xFF61A4F1),
              Color(0xFF478DE0),
              Color(0xFF398AE5),
            ],
          ),
        ),
        child: Center(
          child: Lottie.asset(
            'assets/animations/loading.json',
            width: 220,
            repeat: false,
            onLoaded: (composition) {
              Future.delayed(composition.duration, _goToLogin);
            },
            errorBuilder: (context, error, stackTrace) {
              Future.delayed(const Duration(seconds: 3), _goToLogin);
              // Using a white indicator so it's visible against the blue background
              return const CircularProgressIndicator(color: Colors.white);
            },
          ),
        ),
      ),
    );
  }
}