import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'splash_screen_ui.dart';

void main() {
  runApp(const BodyWowApp());
}

class BodyWowApp extends StatelessWidget {
  const BodyWowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Body ว้าว',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFFD83B01), // สีส้มอมแดงตามโจทย์
        // กำหนดให้ทุกข้อความในแอพใช้ฟอนต์ Kanit อัตโนมัติ
        textTheme: GoogleFonts.kanitTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const SplashScreenUI(), // หน้าแรกสุดคือ Splash Screen
    );
  }
}