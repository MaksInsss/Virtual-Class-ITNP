import 'package:flutter/material.dart';
import '../../controllers/course_controller.dart';
import '../../models/pengumuman_model.dart';
import '../../app_theme.dart';

/// Tab Pengumuman — feed pengumuman dari dosen.
class PengumumanTab extends StatelessWidget {
  final String courseId;
  final bool isDosen;

  const PengumumanTab(
      {super.key, required this.courseId, this.isDosen = false});

  @override
  Widget build(BuildContext context) {
    final list = CourseController.getPengumuman(courseId);

    return Scaffold(
      backgroundColor: AppTheme.background,
      floatingActionButton: isDosen
          ? FloatingActionButton.extended(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Fitur buat pengumuman segera hadir')),
              ),
              backgroundColor: AppTheme.secondary,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Buat Pengumuman',
                  style: TextStyle(color: Colors.white)),
            )
          : null,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _PengumumanCard(pengumuman: list[index]);
        },
      ),
    );
  }
}

class _PengumumanCard extends StatelessWidget {
  final PengumumanModel pengumuman;
  const _PengumumanCard({required this.pengumuman});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header pengumuman
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.campaign,
                      color: AppTheme.primary, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    pengumuman.judul,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ],
            ),
            const Divider(height: 16),

            // Isi pengumuman
            Text(
              pengumuman.isi,
              style: const TextStyle(
                  fontSize: 14,
                  height: 1.55,
                  color: AppTheme.textDark),
            ),
            const SizedBox(height: 12),

            // Footer
            Row(
              children: [
                const Icon(Icons.access_time,
                    size: 12, color: AppTheme.textGrey),
                const SizedBox(width: 4),
                Text(pengumuman.tanggal,
                    style: const TextStyle(
                        fontSize: 12, color: AppTheme.textGrey)),
                const Spacer(),
                const Icon(Icons.person_outline,
                    size: 12, color: AppTheme.textGrey),
                const SizedBox(width: 4),
                Text(pengumuman.dosen,
                    style: const TextStyle(
                        fontSize: 12, color: AppTheme.textGrey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
