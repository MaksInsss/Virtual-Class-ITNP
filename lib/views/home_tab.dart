import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/mata_kuliah_model.dart';
import '../controllers/course_controller.dart';
import '../app_theme.dart';
import 'course_detail_page.dart';

/// Halaman Home untuk Mahasiswa.
/// Menampilkan daftar mata kuliah dengan gambar dari internet.
class HomeTab extends StatelessWidget {
  final UserModel user;
  const HomeTab({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ====================================
          // HEADER GREETING
          // ====================================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
            color: Colors.white,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundImage: AssetImage('assets/profil.jpg'),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hei, ${user.nama.split(' ').first}! 👋',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textDark,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${user.nim}  •  Semester ${user.semester}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppTheme.textGrey,
                        ),
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              'Mata Kuliah',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textDark,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ====================================
          // LIST MATA KULIAH
          // ====================================
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              itemCount: CourseController.mataKuliahList.length,
              itemBuilder: (context, index) {
                final matkul = CourseController.mataKuliahList[index];
                return _CourseCard(matkul: matkul);
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ====================================================
// WIDGET CARD MATA KULIAH (dengan gambar dari internet)
// ====================================================
class _CourseCard extends StatelessWidget {
  final MataKuliahModel matkul;
  const _CourseCard({required this.matkul});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CourseDetailPage(matkul: matkul),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================
            // GAMBAR DARI INTERNET
            // ==========================
            SizedBox(
              height: 140,
              width: double.infinity,
              child: Image.network(
                matkul.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: const Color(0xFFE8E8E8),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.secondary,
                      ),
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
            // INFO MATA KULIAH
            // ==========================
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kode & SKS
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
                      Text(
                        '${matkul.sks} SKS',
                        style: const TextStyle(
                            fontSize: 12, color: AppTheme.textGrey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Nama mata kuliah
                  Text(
                    matkul.nama,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 5),

                  // Dosen
                  Row(
                    children: [
                      const Icon(Icons.person_outline,
                          size: 14, color: AppTheme.textGrey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          matkul.dosen,
                          style: const TextStyle(
                              fontSize: 13, color: AppTheme.textGrey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          size: 13, color: AppTheme.textGrey),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
