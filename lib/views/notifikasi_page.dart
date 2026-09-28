import 'package:flutter/material.dart';

import '../app_theme.dart';

/// Halaman Notifikasi.
///
/// AppBar tidak dibuat di sini karena AppBar utama
/// berada di MainPage.
class NotifikasiPage extends StatefulWidget {
  // Callback untuk mengirim jumlah notifikasi
  // yang belum dibaca ke MainPage.
  final ValueChanged<int>? onUnreadCountChanged;

  const NotifikasiPage({
    super.key,
    this.onUnreadCountChanged,
  });

  @override
  NotifikasiPageState createState() => NotifikasiPageState();
}

// State sengaja dibuat public:
//
// NotifikasiPageState
//
// bukan:
//
// _NotifikasiPageState
//
// supaya MainPage dapat mengakses fungsi
// markAllRead().
class NotifikasiPageState extends State<NotifikasiPage> {
  // ============================================================
  // DATA NOTIFIKASI
  // ============================================================

  final List<Map<String, dynamic>> _notifikasi = [
    {
      'judul': 'Tugas 3 – Studi Kasus',
      'isi':
          'Tugas baru tersedia di Pemrograman Berbasis Objek. Deadline: 24 Sep 2026.',
      'waktu': '2 jam lalu',
      'icon': Icons.assignment_outlined,
      'color': Colors.orange,
      'dibaca': false,
    },
    {
      'judul': 'Perubahan Jadwal UTS',
      'isi':
          'UTS PBO dipindahkan ke 10 Oktober 2026. Pastikan sudah siap!',
      'waktu': '5 jam lalu',
      'icon': Icons.campaign_outlined,
      'color': Colors.blue,
      'dibaca': false,
    },
    {
      'judul': 'Nilai Tugas 2 Keluar',
      'isi':
          'Dosen telah memberikan nilai Tugas 2. Cek tab Nilai di PBO.',
      'waktu': '1 hari lalu',
      'icon': Icons.grade_outlined,
      'color': Colors.green,
      'dibaca': true,
    },
    {
      'judul': 'Kuliah Tamu – Rabu 1 Okt',
      'isi':
          'Kuliah tamu dari praktisi industri. Kehadiran wajib dan dihitung.',
      'waktu': '3 hari lalu',
      'icon': Icons.people_outlined,
      'color': Colors.purple,
      'dibaca': true,
    },
    {
      'judul': 'Materi Pertemuan 3 Tersedia',
      'isi':
          'Video tutorial Pertemuan 3 telah diunggah di Sains Komputasi.',
      'waktu': '5 hari lalu',
      'icon': Icons.folder_outlined,
      'color': Colors.red,
      'dibaca': true,
    },
  ];

  // ============================================================
  // MENGHITUNG UNREAD
  // ============================================================

  int get unreadCount {
    return _notifikasi.where(
      (n) => n['dibaca'] == false,
    ).length;
  }

  // ============================================================
  // INIT STATE
  // ============================================================

  @override
  void initState() {
    super.initState();

    // Kirim jumlah unread pertama kali ke MainPage.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sendUnreadCount();
    });
  }

  // ============================================================
  // KIRIM JUMLAH UNREAD KE MAIN PAGE
  // ============================================================

  void _sendUnreadCount() {
    widget.onUnreadCountChanged?.call(
      unreadCount,
    );
  }

  // ============================================================
  // TANDAI SATU NOTIFIKASI SUDAH DIBACA
  // ============================================================

  void _markAsRead(int index) {
    // Kalau sudah dibaca, tidak perlu melakukan apa-apa.
    if (_notifikasi[index]['dibaca'] == true) {
      return;
    }

    setState(() {
      _notifikasi[index]['dibaca'] = true;
    });

    // Kirim jumlah terbaru ke MainPage.
    _sendUnreadCount();
  }

  // ============================================================
  // TANDAI SEMUA SUDAH DIBACA
  // ============================================================

  void markAllRead() {
    setState(() {
      for (final notif in _notifikasi) {
        notif['dibaca'] = true;
      }
    });

    // Setelah semua dibaca, jumlah unread menjadi 0.
    _sendUnreadCount();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,

      body: _notifikasi.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 64,
                    color: Colors.grey,
                  ),

                  SizedBox(
                    height: 12,
                  ),

                  Text(
                    'Tidak ada notifikasi',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),

              itemCount: _notifikasi.length,

              separatorBuilder: (_, _) {
                return const Divider(
                  height: 0,
                  indent: 72,
                );
              },

              itemBuilder: (context, index) {
                final notif = _notifikasi[index];

                return _NotifTile(
                  notif: notif,

                  onTap: () {
                    _markAsRead(index);
                  },
                );
              },
            ),
    );
  }
}

// ================================================================
// WIDGET ITEM NOTIFIKASI
// ================================================================

class _NotifTile extends StatelessWidget {
  final Map<String, dynamic> notif;
  final VoidCallback onTap;

  const _NotifTile({
    required this.notif,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Status dibaca.
    final bool dibaca = notif['dibaca'] as bool;

    // Warna icon.
    final Color color = notif['color'] as Color;

    return InkWell(
      onTap: onTap,

      child: Container(
        // Notifikasi belum dibaca memiliki
        // background sedikit berbeda.
        color: dibaca
            ? null
            : AppTheme.secondary.withValues(
                alpha: 0.05,
              ),

        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================================================
            // ICON
            // ==================================================

            Container(
              width: 44,
              height: 44,

              decoration: BoxDecoration(
                color: color.withValues(
                  alpha: 0.12,
                ),

                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),

              child: Icon(
                notif['icon'] as IconData,
                color: color,
                size: 22,
              ),
            ),

            const SizedBox(
              width: 12,
            ),

            // ==================================================
            // KONTEN
            // ==================================================

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ============================================
                  // JUDUL
                  // ============================================

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notif['judul'] as String,

                          style: TextStyle(
                            fontWeight: dibaca
                                ? FontWeight.normal
                                : FontWeight.bold,

                            fontSize: 14,
                          ),
                        ),
                      ),

                      // Titik indikator belum dibaca.
                      if (!dibaca)
                        Container(
                          width: 8,
                          height: 8,

                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.primary,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(
                    height: 3,
                  ),

                  // ============================================
                  // ISI
                  // ============================================

                  Text(
                    notif['isi'] as String,

                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textGrey,
                    ),

                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(
                    height: 4,
                  ),

                  // ============================================
                  // WAKTU
                  // ============================================

                  Text(
                    notif['waktu'] as String,

                    style: const TextStyle(
                      fontSize: 11,
                      color: AppTheme.textGrey,
                    ),
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