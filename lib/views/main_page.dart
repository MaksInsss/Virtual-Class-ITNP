import 'package:flutter/material.dart';

import '../app_theme.dart';
import '../models/user_model.dart';

import 'home_tab.dart';
import 'home_dosen_tab.dart';
import 'jadwal_page.dart';
import 'notifikasi_page.dart';
import 'profil_page.dart';
import 'login_page.dart';

class MainPage extends StatefulWidget {
  final UserModel user;

  const MainPage({
    super.key,
    required this.user,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // ============================================================
  // INDEX HALAMAN AKTIF
  // ============================================================

  int _currentIndex = 0;

  // ============================================================
  // JUMLAH NOTIFIKASI BELUM DIBACA
  // ============================================================

  int _unreadCount = 0;

  // ============================================================
  // KEY UNTUK MENGAKSES NOTIFIKASI PAGE
  // ============================================================

  final GlobalKey<NotifikasiPageState> _notifikasiKey =
      GlobalKey<NotifikasiPageState>();

  // ============================================================
  // LIST TAB
  // ============================================================

  late final List<Widget> _tabs;

  // ============================================================
  // JUDUL APPBAR
  // ============================================================

  final List<String> _titles = [
    'Virtual Class',
    'Jadwal',
    'Notifikasi',
    'Profil',
  ];

  // ============================================================
  // INIT STATE
  // ============================================================

  @override
  void initState() {
    super.initState();

    // Home berbeda berdasarkan role user.
    final homeWidget = widget.user.isDosen
        ? HomeDosenTab(user: widget.user)
        : HomeTab(user: widget.user);

    _tabs = [
      homeWidget,

      const JadwalPage(),

      NotifikasiPage(
        key: _notifikasiKey,

        // Menerima jumlah unread dari NotifikasiPage.
        onUnreadCountChanged: _updateUnreadCount,
      ),

      ProfilPage(
        user: widget.user,
      ),
    ];
  }

  // ============================================================
  // UPDATE JUMLAH NOTIFIKASI BELUM DIBACA
  // ============================================================

  void _updateUnreadCount(int count) {
    if (!mounted) return;

    setState(() {
      _unreadCount = count;
    });
  }

  // ============================================================
  // GANTI HALAMAN
  // ============================================================

  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Tutup Drawer jika masih terbuka.
    Navigator.pop(context);
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  void _logout() {
    Navigator.pop(context);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text(
            'Apakah Anda yakin ingin logout?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Logout',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        title: _buildAppBarTitle(),

        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        elevation: 2,

        // Tombol "Tandai Semua" hanya muncul
        // ketika sedang berada di halaman Notifikasi
        // dan masih ada notifikasi yang belum dibaca.
        actions: [
          if (_currentIndex == 2 && _unreadCount > 0)
            TextButton(
              onPressed: () {
                _notifikasiKey.currentState?.markAllRead();
              },
              child: const Text(
                'Tandai Semua',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
        ],
      ),

      // ========================================================
      // DRAWER
      // ========================================================

      drawer: Drawer(
        child: Column(
          children: [
            // ==================================================
            // HEADER USER
            // ==================================================

            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: AppTheme.primary,
              ),

              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/peler.jpg'),
              ),

              accountName: Text(
                widget.user.nama,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

             accountEmail: Text(
                widget.user.isDosen
                    ? 'NID: ${widget.user.nidn}'
                    : 'NIM: ${widget.user.nim}',
              ),
            ),

            // ==================================================
            // HOME
            // ==================================================

            ListTile(
              leading: const Icon(
                Icons.home_outlined,
              ),

              title: const Text(
                'Home',
              ),

              selected: _currentIndex == 0,

              onTap: () {
                _changePage(0);
              },
            ),

            // ==================================================
            // JADWAL
            // ==================================================

            ListTile(
              leading: const Icon(
                Icons.schedule_outlined,
              ),

              title: const Text(
                'Jadwal',
              ),

              selected: _currentIndex == 1,

              onTap: () {
                _changePage(1);
              },
            ),

            // ==================================================
            // NOTIFIKASI
            // ==================================================

            ListTile(
              leading: const Icon(
                Icons.notifications_outlined,
              ),

              title: const Text(
                'Notifikasi',
              ),

              selected: _currentIndex == 2,

              // Badge jumlah unread.
              trailing: _unreadCount > 0
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),

                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: Text(
                        '$_unreadCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : null,

              onTap: () {
                _changePage(2);
              },
            ),

            // ==================================================
            // PROFIL
            // ==================================================

            ListTile(
              leading: const Icon(
                Icons.person_outline,
              ),

              title: const Text(
                'Profil',
              ),

              selected: _currentIndex == 3,

              onTap: () {
                _changePage(3);
              },
            ),

            const Spacer(),

            // ==================================================
            // PEMBATAS
            // ==================================================

            const Divider(),

            // ==================================================
            // LOGOUT
            // ==================================================

            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),

              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),

              onTap: _logout,
            ),

            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
    );
  }

  // ============================================================
  // APP BAR TITLE
  // ============================================================

  Widget _buildAppBarTitle() {
    // Jika halaman yang aktif adalah Notifikasi,
    // tampilkan badge jumlah unread.
    if (_currentIndex == 2) {
      return Row(
        children: [
          const Text(
            'Notifikasi',
          ),

          if (_unreadCount > 0) ...[
            const SizedBox(
              width: 8,
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 2,
              ),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),

              child: Text(
                '$_unreadCount',
                style: TextStyle(
                  fontSize: 11,
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      );
    }

    // Untuk halaman selain Notifikasi.
    return Text(
      _titles[_currentIndex],
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}