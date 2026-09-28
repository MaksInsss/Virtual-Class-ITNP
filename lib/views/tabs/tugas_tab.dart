import 'package:flutter/material.dart';
import '../../controllers/course_controller.dart';
import '../../models/tugas_model.dart';
import '../../app_theme.dart';

/// Tab Tugas — menampilkan daftar tugas dengan status pengumpulan.
class TugasTab extends StatelessWidget {
  final String courseId;
  final bool isDosen;

  const TugasTab({super.key, required this.courseId, this.isDosen = false});

  @override
  Widget build(BuildContext context) {
    final tugasList = CourseController.getTugas(courseId);

    return Scaffold(
      backgroundColor: AppTheme.background,
      floatingActionButton: isDosen
          ? FloatingActionButton.extended(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur buat tugas segera hadir')),
              ),
              backgroundColor: AppTheme.secondary,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Buat Tugas',
                  style: TextStyle(color: Colors.white)),
            )
          : null,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tugasList.length,
        itemBuilder: (context, index) {
          final tugas = tugasList[index];
          return _TugasCard(tugas: tugas, isDosen: isDosen);
        },
      ),
    );
  }
}

class _TugasCard extends StatelessWidget {
  final TugasModel tugas;
  final bool isDosen;

  const _TugasCard({required this.tugas, required this.isDosen});

  @override
  Widget build(BuildContext context) {
    final bool terkumpul = tugas.sudahDikumpulkan;
    final statusColor = terkumpul ? Colors.green : Colors.orange;
    final statusLabel = terkumpul ? 'Terkumpul' : 'Belum';
    final statusIcon =
        terkumpul ? Icons.check_circle : Icons.assignment_outlined;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            leading: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(statusIcon, color: statusColor),
            ),
            title: Text(
              tugas.judul,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 3),
                Text(tugas.deskripsi,
                    style: const TextStyle(
                        fontSize: 12, color: AppTheme.textGrey)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 12, color: AppTheme.textGrey),
                    const SizedBox(width: 4),
                    Text(
                      'Deadline: ${tugas.deadline}',
                      style: const TextStyle(
                          fontSize: 11, color: AppTheme.textGrey),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                statusLabel,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ),
            isThreeLine: true,
          ),

          // ============================
          // AKSI MAHASISWA
          // ============================
          if (!isDosen) ...[
            if (!terkumpul)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Kumpulkan: ${tugas.judul}')),
                    ),
                    icon: const Icon(Icons.upload_file, size: 16),
                    label: const Text('Kumpulkan Tugas'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.secondary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ),
            if (terkumpul && tugas.nilai != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Row(
                  children: [
                    const Icon(Icons.grade, size: 16, color: AppTheme.primary),
                    const SizedBox(width: 6),
                    const Text('Nilai: ',
                        style: TextStyle(
                            fontSize: 13, color: AppTheme.textGrey)),
                    Text(
                      '${tugas.nilai}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
          ],

          // ============================
          // AKSI DOSEN
          // ============================
          if (isDosen)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Lihat pengumpulan mahasiswa')),
                  ),
                  icon: const Icon(Icons.people_outline, size: 16),
                  label: const Text('Lihat Pengumpulan'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primary,
                    side: const BorderSide(color: AppTheme.primary),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
