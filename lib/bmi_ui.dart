import 'package:flutter/material.dart';

class BmiUI extends StatefulWidget {
  const BmiUI({super.key});

  @override
  State<BmiUI> createState() => _BmiUIState();
}

class _BmiUIState extends State<BmiUI> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  double _bmi = 0.00;
  String _interpretation = 'การแปรผล';

  // ฟังก์ชันคำนวณ BMI
  void _calculateBMI() {
    final double? weight = double.tryParse(_weightController.text);
    final double? height = double.tryParse(_heightController.text);

    if (weight != null && height != null && height > 0) {
      final double heightInMeters = height / 100;
      final double calculatedBmi = weight / (heightInMeters * heightInMeters);

      String resultText = '';
      if (calculatedBmi < 18.5) {
        resultText = 'น้ำหนักน้อย / ผอม';
      } else if (calculatedBmi <= 22.99) {
        resultText = 'น้ำหนักปกติ / สมส่วน';
      } else if (calculatedBmi <= 24.99) {
        resultText = 'ท้วม / น้ำหนักเกิน';
      } else if (calculatedBmi <= 29.99) {
        resultText = 'อ้วนระดับ 1';
      } else {
        resultText = 'อ้วนระดับ 2 (อันตราย)';
      }

      setState(() {
        _bmi = calculatedBmi;
        _interpretation = resultText;
      });
    }
  }

  // ฟังก์ชันล้างข้อมูล
  void _clearData() {
    setState(() {
      _weightController.clear();
      _heightController.clear();
      _bmi = 0.00;
      _interpretation = 'การแปรผล';
    });
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
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
            'คำนวณหาค่าดัชนีมวลกาย (BMI)',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          // 2. รูปมิเตอร์ BMI (ใช้ bmi.png ถ้ามี หรือไอคอนสำรอง)
          Center(
            child: Image.asset(
              'assets/images/bmi.png',
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
                    Icons.speed_outlined,
                    size: 80,
                    color: Color(0xFFD83B01),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // 3. ช่องกรอกน้ำหนัก
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

          // 4. ช่องกรอกส่วนสูง
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
          const SizedBox(height: 20),

          // 5. ปุ่มคำนวณ BMI (สีส้มสด ทรงมนแคปซูลตามภาพ)
          ElevatedButton(
            onPressed: _calculateBMI,
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
              'คำนวณ BMI',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),

          // 6. ปุ่มล้างข้อมูล (สีเทา ทรงมนแคปซูล)
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

          // 7. กล่องแสดงผลลัพธ์ (สีเขียวอ่อน)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFC8E6C9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                const Text(
                  'BMI',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  _bmi.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF04A1D),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _interpretation,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}