import 'package:flutter/material.dart';

class AboutUI extends StatelessWidget {
  const AboutUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480), // จำกัดความกว้างให้พอดีหน้าจอมือถือ
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  // ขยายความกว้างเต็มพื้นที่เพื่อบังคับให้เนื้อหาทุกชิ้นอยู่กึ่งกลาง
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center, // จัดกึ่งกลางแนวนอน
                        children: [
                          const Spacer(),

                          // 1. หัวข้อแอพสีส้มอมแดง
                          const Text(
                            'Body Health Calculator',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD83B01),
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 28),

                          // 2. ไอคอนตรงกลาง (logo.png)
                          Image.asset(
                            'assets/images/logo.png',
                            width: 130,
                            height: 130,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.calculate_outlined,
                                size: 100,
                                color: Color(0xFFD83B01),
                              );
                            },
                          ),
                          const SizedBox(height: 28),

                          // 3. ข้อความอธิบาย 2 บรรทัด
                          const Text(
                            'คำนวณหาค่าดัชนีมวลกาย (BMI)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD83B01),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'คำนวณหาแคลอรี่ที่ร่างกายต้องการ (BMR)',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFD83B01),
                            ),
                          ),
                          const Spacer(),

                          // 4. โลโก้มหาวิทยาลัย (saulogo.png)
                          Image.asset(
                            'assets/images/saulogo.png',
                            width: 65,
                            height: 65,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey.shade400, width: 1.5),
                                ),
                                child: const Icon(
                                  Icons.school_outlined,
                                  size: 32,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 12),

                          // 5. ข้อความลิขสิทธิ์
                          Text(
                            '© 2026 SAU. All rights reserved.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Created by SAU Software Development Team',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}