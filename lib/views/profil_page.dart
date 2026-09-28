import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../app_theme.dart';

/// Halaman Profil — informasi user dan tombol logout.
class ProfilPage extends StatelessWidget {
  final UserModel user;
  const ProfilPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final bool mhs = user.isMahasiswa;

    return Scaffold(
      backgroundColor: AppTheme.background,
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ====================================
            // HEADER PROFIL
            // ====================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              color: Colors.white,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/peler.jpg'),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    user.nama,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  // Badge role
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 5),
                    decoration: BoxDecoration(
                      color: mhs
                          ? AppTheme.secondary.withValues(alpha: 0.2)
                          : AppTheme.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      mhs ? '🎓 Mahasiswa' : '👨‍🏫 Dosen',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (user.email != null)
                    Text(
                      user.email!,
                      style: const TextStyle(
                          fontSize: 13, color: AppTheme.textGrey),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ====================================
            // INFO DETAIL
            // ====================================
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  _InfoTile(
                    icon: Icons.badge_outlined,
                    label: mhs ? 'NIM' : 'NIDN',
                    value: mhs ? user.nim : (user.nidn ?? '-'),
                  ),
                  _InfoTile(
                    icon: Icons.school_outlined,
                    label: 'Program Studi',
                    value: user.programStudi,
                  ),
                  _InfoTile(
                    icon: Icons.account_balance_outlined,
                    label: 'Institusi',
                    value: user.universitas,
                  ),
                  if (mhs)
                    _InfoTile(
                      icon: Icons.calendar_month_outlined,
                      label: 'Semester',
                      value: 'Semester ${user.semester}',
                    ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ====================================
            // MENU AKSI
            // ====================================
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.lock_outline,
                        color: AppTheme.primary),
                    title: const Text('Ganti Password'),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 14, color: Colors.grey),
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Fitur ganti password segera hadir')),
                    ),
                  ),
                  const Divider(height: 0, indent: 16),
                  ListTile(
                    leading: const Icon(Icons.info_outline,
                        color: AppTheme.primary),
                    title: const Text('Tentang Aplikasi'),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 14, color: Colors.grey),
                    onTap: () => showAboutDialog(
                      context: context,
                      applicationName: 'Virtual Class ITNP',
                      applicationVersion: '1.0.0',
                      applicationLegalese:
                          '© 2026 Institut Teknologi Negeri Ponorogo',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            Text(
              'Virtual Class ITNP v1.0.0',
              style: TextStyle(
                  color: Colors.grey.shade400, fontSize: 12),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: AppTheme.secondary),
          title: Text(label,
              style: const TextStyle(
                  fontSize: 12, color: AppTheme.textGrey)),
          subtitle: Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppTheme.textDark,
            ),
          ),
        ),
        const Divider(height: 0, indent: 16),
      ],
    );
  }
}
