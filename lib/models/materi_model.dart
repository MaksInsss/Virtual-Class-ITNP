class MateriModel {
  final String id;
  final String judul;
  final String deskripsi;
  final String fileType; // 'pdf', 'video', 'link'
  final String tanggal;

  const MateriModel({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.fileType,
    required this.tanggal,
  });
}
