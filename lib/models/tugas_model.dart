class TugasModel {
  final String id;
  final String judul;
  final String deskripsi;
  final String deadline;
  final bool sudahDikumpulkan;
  final int? nilai;

  const TugasModel({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.deadline,
    required this.sudahDikumpulkan,
    this.nilai,
  });
}
