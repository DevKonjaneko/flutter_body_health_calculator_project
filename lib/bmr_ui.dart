import 'package:flutter/material.dart';

class BmrUI extends StatefulWidget {
  const BmrUI({super.key});

  @override
  State<BmrUI> createState() => _BmrUIState();
}

class _BmrUIState extends State<BmrUI> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  bool _isMale = true; // เพศเริ่มต้นคือ ชาย
  double _bmr = 0.00;

  // ฟังก์ชันคำนวณ BMR (สูตร Harris-Benedict)
  void _calculateBMR() {
    final double? weight = double.tryParse(_weightController.text);
    final double? height = double.tryParse(_heightController.text);
    final int? age = int.tryParse(_ageController.text);

    if (weight != null && height != null && age != null) {
      double result = 0.0;
      if (_isMale) {
        result = 66 + (13.7 * weight) + (5 * height) - (6.8 * age);
      } else {
        result = 665 + (9.6 * weight) + (1.8 * height) - (4.7 * age);
      }

      setState(() {
        _bmr = result > 0 ? result : 0.00;
      });
    }
  }

  // ฟังก์ชันล้างข้อมูล
  void _clearData() {
    setState(() {
      _weightController.clear();
      _heightController.clear();
      _ageController.clear();
      _isMale = true;
      _bmr = 0.00;
    });
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. หัวข้อหน้า
          const Text(
            'คำนวณหาอัตราการเผาผลาญที่\nร่างกายต้องการ (BMR)',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          // 2. รูปหัวใจและดัมเบล (bmr.png หรือไอคอนสำรอง)
          Center(
            child: Image.asset(
              'assets/images/bmr.png',
              width: 120,
              height: 120,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.favorite_outline,
                    size: 80,
                    color: Color(0xFFD83B01),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // 3. ปุ่มเลือกเพศ (ชาย / หญิง)
          const Text(
            'เพศ',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => setState(() => _isMale = true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isMale ? const Color(0xFFBBDEFB) : Colors.white,
                    foregroundColor: _isMale ? const Color(0xFF1976D2) : Colors.black87,
                    elevation: 0,
                    side: BorderSide(
                      color: _isMale ? const Color(0xFF1976D2) : Colors.grey.shade300,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('ชาย', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => setState(() => _isMale = false),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !_isMale ? const Color(0xFFFFCDD2) : Colors.white,
                    foregroundColor: !_isMale ? const Color(0xFFD32F2F) : Colors.black87,
                    elevation: 0,
                    side: BorderSide(
                      color: !_isMale ? const Color(0xFFD32F2F) : Colors.grey.shade300,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('หญิง', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 4. ช่องกรอกน้ำหนัก
          const Text(
            'น้ำหนัก (kg.)',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _weightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: 'กรอกน้ำหนักของคุณ',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // 5. ช่องกรอกส่วนสูง
          const Text(
            'ส่วนสูง (cm.)',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _heightController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: 'กรอกส่วนสูงของคุณ',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // 6. ช่องกรอกอายุ
          const Text(
            'อายุ (ปี)',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'กรอกอายุของคุณ',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 7. ปุ่มคำนวณ BMR
          ElevatedButton(
            onPressed: _calculateBMR,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF04A1D),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 0,
            ),
            child: const Text(
              'คำนวณ BMR',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),

          // 8. ปุ่มล้างข้อมูล
          ElevatedButton(
            onPressed: _clearData,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9E9E9E),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 0,
            ),
            child: const Text(
              'ล้างข้อมูล',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 24),

          // 9. กล่องผลลัพธ์
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFC8E6C9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const Text(
                  'BMR',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  _bmr.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF04A1D),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'kcal/day',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}