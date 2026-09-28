import 'dart:async';
import 'package:flutter/material.dart';
import 'home_ui.dart';

class SplashScreenUI extends StatefulWidget {
  const SplashScreenUI({super.key});

  @override
  State<SplashScreenUI> createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {
  @override
  void initState() {
    super.initState();
    // รอ 3 วินาทีแล้วเปิดหน้า HomeUI
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeUI()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD83B01),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/icon.png',
              width: 140,
              height: 140,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.calculate_outlined,
                  size: 110,
                  color: Colors.white,
                );
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Body Health Calculator',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3.0,
            ),
          ],
        ),
      ),
    );
  }
}