import 'package:flutter/material.dart';
import '../app_theme.dart';

/// Halaman Jadwal Kuliah — jadwal per hari dalam seminggu.
class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  // Mulai dari hari ini (0=Senin, 4=Jumat, weekend → Senin)
  int _selectedDay = () {
    final d = DateTime.now().weekday - 1;
    return d > 4 ? 0 : d;
  }();

  final List<String> _hari = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat'];

  final Map<int, List<Map<String, String>>> _jadwal = {
    0: [
      {
        'matkul': 'Pemrograman Berbasis Objek',
        'jam': '07.30 - 10.00',
        'ruangan': 'Lab Komputer A',
        'dosen': 'Dr. Budi Santoso, M.Kom',
        'kode': 'TI-301',
      },
      {
        'matkul': 'Struktur Data',
        'jam': '13.00 - 15.30',
        'ruangan': 'Ruang 201',
        'dosen': 'Ahmad Fauzi, M.Cs.',
        'kode': 'TI-304',
      },
    ],
    1: [
      {
        'matkul': 'Pemrograman Berbasis Platform',
        'jam': '07.30 - 10.00',
        'ruangan': 'Lab Komputer B',
        'dosen': 'Rizky Aditya, S.T., M.T.',
        'kode': 'TI-302',
      },
    ],
    2: [
      {
        'matkul': 'Sains Komputasi',
        'jam': '10.00 - 12.30',
        'ruangan': 'Ruang 301',
        'dosen': 'Prof. Siti Rahayu, Ph.D.',
        'kode': 'TI-303',
      },
      {
        'matkul': 'Jaringan Komputer',
        'jam': '13.00 - 15.30',
        'ruangan': 'Lab Jaringan',
        'dosen': 'Dewi Kusuma, M.T.',
        'kode': 'TI-305',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final jadwalHariIni = _jadwal[_selectedDay] ?? [];

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Column(
        children: [
          // ==================================
          // PEMILIH HARI
          // ==================================
          Container(
            color: Colors.white,
            padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                final isSelected = index == _selectedDay;
                return GestureDetector(
                  onTap: () => setState(() => _selectedDay = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 60,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.secondary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _hari[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : AppTheme.textDark,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 6),

          // ==================================
          // LIST JADWAL / KOSONG
          // ==================================
          Expanded(
            child: jadwalHariIni.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.event_available,
                            size: 64, color: Colors.grey),
                        SizedBox(height: 14),
                        Text(
                          'Tidak ada kuliah hari ini 🎉',
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: jadwalHariIni.length,
                    itemBuilder: (context, index) {
                      final j = jadwalHariIni[index];
                      return _JadwalCard(jadwal: j);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _JadwalCard extends StatelessWidget {
  final Map<String, String> jadwal;
  const _JadwalCard({required this.jadwal});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Waktu
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.secondary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                jadwal['jam']!.replaceFirst(' - ', '\n'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primary,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jadwal['matkul']!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.room,
                          size: 13, color: AppTheme.textGrey),
                      const SizedBox(width: 4),
                      Text(jadwal['ruangan']!,
                          style: const TextStyle(
                              fontSize: 12, color: AppTheme.textGrey)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(Icons.person_outline,
                          size: 13, color: AppTheme.textGrey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          jadwal['dosen']!,
                          style: const TextStyle(
                              fontSize: 12, color: AppTheme.textGrey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Kode
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                jadwal['kode']!,
                style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
