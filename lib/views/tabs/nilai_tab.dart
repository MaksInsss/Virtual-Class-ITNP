import 'package:flutter/material.dart';
import '../../controllers/course_controller.dart';
import '../../models/nilai_model.dart';
import '../../app_theme.dart';

/// Tab Nilai — rekap nilai per komponen dengan progress bar.
class NilaiTab extends StatelessWidget {
  final String courseId;
  final bool isDosen;

  const NilaiTab({super.key, required this.courseId, this.isDosen = false});

  String _getGrade(double score) {
    if (score >= 85) return 'A';
    if (score >= 75) return 'B';
    if (score >= 65) return 'C';
    if (score >= 55) return 'D';
    return 'E';
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A':
        return Colors.green;
      case 'B':
        return Colors.blue;
      case 'C':
        return Colors.orange;
      case 'D':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final nilaiList = CourseController.getNilai(courseId);

    // Hitung nilai sementara berdasarkan komponen yang sudah ada nilainya
    double weightedSum = 0;
    double totalBobotAda = 0;
    for (final n in nilaiList) {
      if (n.nilai > 0) {
        weightedSum += n.nilai * (n.bobot / 100);
        totalBobotAda += n.bobot;
      }
    }
    final estimasi = totalBobotAda > 0
        ? (weightedSum / totalBobotAda) * 100
        : 0.0;
    final grade = _getGrade(estimasi);
    final gradeColor = _getGradeColor(grade);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // ==================================
          // KARTU RINGKASAN NILAI
          // ==================================
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nilai Sementara',
                        style: TextStyle(
                            fontSize: 13, color: AppTheme.textGrey),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        estimasi.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'dari ${totalBobotAda.toInt()}% komponen dinilai',
                        style: const TextStyle(
                            fontSize: 11, color: AppTheme.textGrey),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: gradeColor.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                      border: Border.all(color: gradeColor, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        grade,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: gradeColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

          // ==================================
          // RINCIAN NILAI PER KOMPONEN
          // ==================================
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rincian Nilai',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 14),
                  ...nilaiList
                      .map((n) => _NilaiRow(nilai: n))
                      ,
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

          // ==================================
          // KETERANGAN NILAI
          // ==================================
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Konversi Nilai',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  _gradeRow('A', '≥ 85', Colors.green),
                  _gradeRow('B', '75 – 84', Colors.blue),
                  _gradeRow('C', '65 – 74', Colors.orange),
                  _gradeRow('D', '55 – 64', Colors.red),
                  _gradeRow('E', '< 55', Colors.grey),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _gradeRow(String grade, String range, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(grade,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: color)),
            ),
          ),
          const SizedBox(width: 12),
          Text(range,
              style: const TextStyle(fontSize: 14, color: AppTheme.textDark)),
        ],
      ),
    );
  }
}

class _NilaiRow extends StatelessWidget {
  final NilaiModel nilai;
  const _NilaiRow({required this.nilai});

  @override
  Widget build(BuildContext context) {
    final bool hasNilai = nilai.nilai > 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  nilai.komponen,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ),
              Text(
                'Bobot ${nilai.bobot.toInt()}%',
                style: const TextStyle(
                    fontSize: 11, color: AppTheme.textGrey),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 36,
                child: Text(
                  hasNilai ? nilai.nilai.toStringAsFixed(0) : '–',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: hasNilai ? AppTheme.primary : AppTheme.textGrey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: hasNilai ? nilai.nilai / 100 : 0,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                hasNilai ? AppTheme.secondary : Colors.grey.shade300,
              ),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
