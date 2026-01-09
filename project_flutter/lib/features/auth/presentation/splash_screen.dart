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
      body: Center(
        child: Lottie.asset(
          'assets/animations/loading.json',
          width: 220,
          repeat: false,
          onLoaded: (composition) {
            Future.delayed(composition.duration, _goToLogin);
          },
          errorBuilder: (context, error, stackTrace) {
            Future.delayed(const Duration(seconds: 3), _goToLogin);
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
