import 'package:flutter/material.dart';
import '../../controllers/course_controller.dart';
import '../../models/materi_model.dart';
import '../../app_theme.dart';

/// Tab Materi — menampilkan daftar file materi kuliah.
class MateriTab extends StatelessWidget {
  final String courseId;
  final bool isDosen;

  const MateriTab({super.key, required this.courseId, this.isDosen = false});

  IconData _getIcon(String type) {
    switch (type) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'video':
        return Icons.play_circle_filled;
      case 'link':
        return Icons.link;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color _getColor(String type) {
    switch (type) {
      case 'pdf':
        return Colors.red;
      case 'video':
        return Colors.blue;
      case 'link':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _getLabel(String type) {
    switch (type) {
      case 'pdf':
        return 'PDF';
      case 'video':
        return 'VIDEO';
      case 'link':
        return 'LINK';
      default:
        return 'FILE';
    }
  }

  @override
  Widget build(BuildContext context) {
    final materiList = CourseController.getMateri(courseId);

    return Scaffold(
      backgroundColor: AppTheme.background,
      floatingActionButton: isDosen
          ? FloatingActionButton.extended(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur tambah materi segera hadir')),
              ),
              backgroundColor: AppTheme.secondary,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text('Tambah Materi',
                  style: TextStyle(color: Colors.white)),
            )
          : null,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: materiList.length,
        itemBuilder: (context, index) {
          final materi = materiList[index];
          return _MateriCard(materi: materi, getIcon: _getIcon, getColor: _getColor, getLabel: _getLabel);
        },
      ),
    );
  }
}

class _MateriCard extends StatelessWidget {
  final MateriModel materi;
  final IconData Function(String) getIcon;
  final Color Function(String) getColor;
  final String Function(String) getLabel;

  const _MateriCard({
    required this.materi,
    required this.getIcon,
    required this.getColor,
    required this.getLabel,
  });

  @override
  Widget build(BuildContext context) {
    final color = getColor(materi.fileType);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(getIcon(materi.fileType), color: color, size: 24),
        ),
        title: Text(
          materi.judul,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 3),
            Text(materi.deskripsi,
                style: const TextStyle(fontSize: 12, color: AppTheme.textGrey)),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    getLabel(materi.fileType),
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: color),
                  ),
                ),
                const SizedBox(width: 8),
                Text(materi.tanggal,
                    style: const TextStyle(
                        fontSize: 11, color: AppTheme.textGrey)),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.download_outlined, color: AppTheme.primary),
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Membuka: ${materi.judul}')),
          ),
        ),
        isThreeLine: true,
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Membuka: ${materi.judul}')),
        ),
      ),
    );
  }
}
