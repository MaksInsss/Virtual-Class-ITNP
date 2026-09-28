import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/mata_kuliah_model.dart';
import '../controllers/course_controller.dart';
import '../app_theme.dart';
import 'course_detail_page.dart';

/// Halaman Home untuk Dosen.
/// Menampilkan daftar kelas yang diampu dengan tombol aksi.
class HomeDosenTab extends StatelessWidget {
  final UserModel user;
  const HomeDosenTab({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final List<MataKuliahModel> kelasDiampu =
        CourseController.getMatkulDosen(user.nama);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ====================================
          // HEADER DOSEN
          // ====================================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/peler.jpg'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.nama,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'NIDN: ${user.nidn ?? '-'}',
                        style: const TextStyle(
                            fontSize: 13, color: AppTheme.textGrey),
                      ),
                      Text(
                        user.programStudi,
                        style: const TextStyle(
                            fontSize: 13, color: AppTheme.textGrey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // ====================================
          // JUDUL SECTION
          // ====================================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                const Text(
                  'Kelas yang Diampu',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.secondary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${kelasDiampu.length} Kelas',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // ====================================
          // LIST KELAS DIAMPU
          // ====================================
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              itemCount: kelasDiampu.length,
              itemBuilder: (context, index) {
                final matkul = kelasDiampu[index];
                return _DosenCourseCard(matkul: matkul);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================
// WIDGET CARD KELAS UNTUK DOSEN
// =====================================================
class _DosenCourseCard extends StatelessWidget {
  final MataKuliahModel matkul;
  const _DosenCourseCard({required this.matkul});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==========================
          // GAMBAR DARI INTERNET
          // ==========================
          SizedBox(
            height: 130,
            width: double.infinity,
            child: Image.network(
              matkul.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: const Color(0xFFE8E8E8),
                  child: const Center(
                    child: CircularProgressIndicator(color: AppTheme.secondary),
                  ),
                );
              },
              errorBuilder: (_, _, _) => Container(
                color: AppTheme.secondary,
                child: const Icon(
                  Icons.image_not_supported_outlined,
                  size: 48,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // ==========================
          // INFO & AKSI
          // ==========================
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppTheme.secondary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        matkul.kode,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.people_outline,
                        size: 14, color: AppTheme.textGrey),
                    const SizedBox(width: 4),
                    const Text(
                      '32 Mahasiswa',
                      style:
                          TextStyle(fontSize: 12, color: AppTheme.textGrey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  matkul.nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${matkul.sks} SKS',
                  style:
                      const TextStyle(fontSize: 13, color: AppTheme.textGrey),
                ),
                const SizedBox(height: 12),

                // TOMBOL AKSI
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Fitur tambah materi segera hadir')),
                          );
                        },
                        icon: const Icon(Icons.add, size: 15),
                        label: const Text('Materi'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.primary,
                          side: const BorderSide(color: AppTheme.primary),
                          padding:
                              const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CourseDetailPage(
                              matkul: matkul,
                              isDosen: true,
                            ),
                          ),
                        ),
                        icon: const Icon(Icons.visibility, size: 15),
                        label: const Text('Lihat Kelas'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.secondary,
                          foregroundColor: Colors.white,
                          padding:
                              const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
