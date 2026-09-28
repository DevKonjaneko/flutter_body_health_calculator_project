import 'package:flutter/material.dart';
import 'bmi_ui.dart';
import 'about_ui.dart';
import 'bmr_ui.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  // หน้าเริ่มต้น: 1 คือ About (ตรงกลางตามภาพโจทย์)
  int _currentIndex = 1;

  // รายชื่อ 3 หน้าจอเรียงตามลำดับแท็บ
  final List<Widget> _pages = const [
    BmiUI(),   // index 0: BMI
    AboutUI(), // index 1: About
    BmrUI(),   // index 2: BMR
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Body Health Calculator',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xFFD83B01),
        centerTitle: true,
        elevation: 0,
      ),
      // แสดงเนื้อหาของหน้าจอที่ถูกเลือก
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFFD83B01), // สีส้มเมื่อเลือก
        unselectedItemColor: Colors.grey.shade500,  // สีเทาเมื่อไม่ได้เลือก
        backgroundColor: Colors.white,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'BMI',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_new),
            label: 'BMR',
          ),
        ],
      ),
    );
  }
}