import 'package:flutter/material.dart';
import '../models/user_model.dart';
// Import login_page.dart bisa dihapus jika tidak digunakan lagi di halaman ini

class BiodataPage extends StatelessWidget {
  final UserModel user;

  const BiodataPage({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PROFIL'),
        // Ubah menjadi true atau hapus baris ini agar tombol kembali otomatis muncul, 
        // atau gunakan leading manual di bawah.

        
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context); // Kembali ke halaman sebelumnya
            },
            icon: const Icon(Icons.arrow_back), 
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/profil.jpg'),
            ),

            const SizedBox(height: 30),

            const Text(
              'BIODATA MAHASISWA',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            biodataItem(
              'Nama',
              user.nama,
              Icons.person,
            ),

            biodataItem(
              'NIM',
              user.nim,
              Icons.badge,
            ),

            biodataItem(
              'Program Studi',
              user.programStudi,
              Icons.school,
            ),

            biodataItem(
              'Universitas',
              user.universitas,
              Icons.account_balance,
            ),

            biodataItem(
              'Semester',
              user.semester.toString(),
              Icons.calendar_month,
            ),
          ],
        ),
      ),
    );
  }

  Widget biodataItem(
    String label,
    String value,
    IconData icon,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon),

        title: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(value),
      ),
    );
  }
}