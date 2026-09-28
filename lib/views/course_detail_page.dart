import 'package:flutter/material.dart';

import '../models/mata_kuliah_model.dart';
import '../app_theme.dart';

import 'tabs/materi_tab.dart';
import 'tabs/tugas_tab.dart';
import 'tabs/pengumuman_tab.dart';
import 'tabs/nilai_tab.dart';

/// Halaman Detail Mata Kuliah.
///
/// Mahasiswa:
/// - Materi
/// - Tugas
/// - Pengumuman
/// - Nilai
///
/// Dosen:
/// - Materi
/// - Tugas
/// - Pengumuman
class CourseDetailPage extends StatelessWidget {
  final MataKuliahModel matkul;

  // Menentukan apakah user adalah dosen.
  final bool isDosen;

  const CourseDetailPage({
    super.key,
    required this.matkul,
    this.isDosen = false,
  });

  @override
  Widget build(BuildContext context) {
    // ============================================================
    // DAFTAR TAB
    // ============================================================

    final List<Tab> tabs = [
      const Tab(
        text: 'Materi',
      ),

      const Tab(
        text: 'Tugas',
      ),

      const Tab(
        text: 'Pengumuman',
      ),

      // Nilai hanya ditampilkan untuk mahasiswa.
      if (!isDosen)
        const Tab(
          text: 'Nilai',
        ),
    ];

    // ============================================================
    // JUMLAH TAB
    // ============================================================

    final int tabLength = tabs.length;

    // ============================================================
    // HALAMAN TAB
    // ============================================================

    final List<Widget> tabPages = [
      MateriTab(
        courseId: matkul.id,
        isDosen: isDosen,
      ),

      TugasTab(
        courseId: matkul.id,
        isDosen: isDosen,
      ),

      PengumumanTab(
        courseId: matkul.id,
        isDosen: isDosen,
      ),

      // Nilai hanya dibuat untuk mahasiswa.
      if (!isDosen)
        NilaiTab(
          courseId: matkul.id,
          isDosen: isDosen,
        ),
    ];

    // ============================================================
    // DEFAULT TAB CONTROLLER
    // ============================================================

    return DefaultTabController(
      length: tabLength,

      child: Scaffold(
        backgroundColor: AppTheme.background,

        body: NestedScrollView(
          headerSliverBuilder: (
            BuildContext context,
            bool innerBoxIsScrolled,
          ) {
            return [
              // ==================================================
              // SLIVER APP BAR
              // ==================================================

              SliverAppBar(
                expandedHeight: 230,

                pinned: true,

                backgroundColor: AppTheme.secondary,

                foregroundColor: Colors.white,

                // ==================================================
                // FLEXIBLE SPACE
                // ==================================================

                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.only(
                    left: 55,
                    bottom: 60,
                    right: 16,
                  ),

                  title: Text(
                    matkul.nama,

                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),

                    maxLines: 2,

                    overflow: TextOverflow.ellipsis,
                  ),

                  // ==================================================
                  // BACKGROUND GAMBAR
                  // ==================================================

                  background: Stack(
                    fit: StackFit.expand,

                    children: [
                      // Gambar mata kuliah dari internet.
                      Image.network(
                        matkul.imageUrl,

                        fit: BoxFit.cover,

                        errorBuilder: (_, _, _) {
                          return Container(
                            color: AppTheme.secondary,
                          );
                        },
                      ),

                      // ==================================================
                      // GRADIENT
                      // ==================================================

                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,

                            end: Alignment.bottomCenter,

                            colors: [
                              Colors.transparent,

                              Colors.black.withValues(
                                alpha: 0.65,
                              ),
                            ],

                            stops: const [
                              0.4,
                              1.0,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ==================================================
                // TAB BAR
                // ==================================================

                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(
                    48,
                  ),

                  child: Container(
                    color: Colors.white.withValues(
                      alpha: 0.1,
                    ),

                    child: TabBar(
                      indicatorColor: Colors.white,

                      indicatorWeight: 3,

                      labelColor: Colors.white,

                      unselectedLabelColor: Colors.white70,

                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),

                      // Menggunakan daftar tab dinamis.
                      tabs: tabs,
                    ),
                  ),
                ),
              ),
            ];
          },

          // ========================================================
          // ISI TAB
          // ========================================================

          body: TabBarView(
            children: tabPages,
          ),
        ),
      ),
    );
  }
}

