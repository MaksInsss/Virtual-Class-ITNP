import '../models/mata_kuliah_model.dart';
import '../models/materi_model.dart';
import '../models/tugas_model.dart';
import '../models/pengumuman_model.dart';
import '../models/nilai_model.dart';

class CourseController {
  // Daftar mata kuliah dengan gambar dari Unsplash
  static const List<MataKuliahModel> mataKuliahList = [
    MataKuliahModel(
      id: 'pbo',
      nama: 'Pemrograman Berbasis Objek',
      kode: 'TI-301',
      dosen: 'Dr. Budi Bud, M.Kom',
      sks: 3,
      imageUrl:
          'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=600&q=80',
      deskripsi:
          'Mempelajari konsep OOP menggunakan Java dan Dart meliputi class, inheritance, polymorphism, dan encapsulation.',
    ),
    MataKuliahModel(
      id: 'pbp',
      nama: 'Pemrograman Berbasis Platform',
      kode: 'TI-302',
      dosen: 'Rizky Aditya, S.T., M.T.',
      sks: 3,
      imageUrl:
          'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=600&q=80',
      deskripsi:
          'Pengembangan aplikasi mobile menggunakan Flutter dan Dart untuk platform Android dan iOS.',
    ),
    MataKuliahModel(
      id: 'sainskomp',
      nama: 'Sains Komputasi',
      kode: 'TI-303',
      dosen: 'Prof. Siti Rahayu, Ph.D.',
      sks: 3,
      imageUrl:
          'https://images.unsplash.com/photo-1635070041078-e363dbe005cb?w=600&q=80',
      deskripsi:
          'Penerapan metode komputasi untuk memecahkan masalah sains menggunakan Python dan algoritma numerik.',
    ),
    MataKuliahModel(
      id: 'strdata',
      nama: 'Struktur Data',
      kode: 'TI-304',
      dosen: 'Ahmad Fauzi, M.Cs.',
      sks: 3,
      imageUrl:
          'https://images.unsplash.com/photo-1544197150-b99a580bb7a8?w=600&q=80',
      deskripsi:
          'Mempelajari struktur data linier dan non-linier: array, linked list, stack, queue, tree, dan graph.',
    ),
    MataKuliahModel(
      id: 'jarkom',
      nama: 'Jaringan Komputer',
      kode: 'TI-305',
      dosen: 'Dewi Kusuma, M.T.',
      sks: 3,
      imageUrl:
          'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=600&q=80',
      deskripsi:
          'Dasar-dasar jaringan komputer, protokol TCP/IP, routing, dan keamanan jaringan.',
    ),
  ];

  // Daftar mata kuliah yang diampu oleh dosen (berdasarkan username dosen)
  static List<MataKuliahModel> getMatkulDosen(String namaDosen) {
    final filtered =
        mataKuliahList.where((mk) => mk.dosen == namaDosen).toList();
    // Jika tidak ada yang cocok, tampilkan 2 pertama sebagai demo
    return filtered.isEmpty ? mataKuliahList.take(2).toList() : filtered;
  }

  // =============================================
  // DATA MATERI
  // =============================================
  static List<MateriModel> getMateri(String courseId) {
    return [
      MateriModel(
        id: '1',
        judul: 'Pertemuan 1 – Pengantar Mata Kuliah',
        deskripsi: 'Pengenalan mata kuliah, kontrak perkuliahan, dan overview materi.',
        fileType: 'pdf',
        tanggal: '3 Sep 2026',
      ),
      MateriModel(
        id: '2',
        judul: 'Pertemuan 2 – Dasar-Dasar Teori',
        deskripsi: 'Materi dasar dan fondasi teori yang akan digunakan sepanjang semester.',
        fileType: 'pdf',
        tanggal: '10 Sep 2026',
      ),
      MateriModel(
        id: '3',
        judul: 'Pertemuan 3 – Praktikum Hands-On',
        deskripsi: 'Video tutorial step-by-step praktikum minggu ketiga.',
        fileType: 'video',
        tanggal: '17 Sep 2026',
      ),
      MateriModel(
        id: '4',
        judul: 'Referensi & Dokumentasi Tambahan',
        deskripsi: 'Kumpulan link dokumentasi resmi dan referensi online.',
        fileType: 'link',
        tanggal: '20 Sep 2026',
      ),

      MateriModel(
        id: '5',
        judul: 'Referensi & Dokumentasi Tambahan',
        deskripsi: 'Kumpulan link dokumentasi resmi dan referensi online.',
        fileType: 'link',
        tanggal: '20 Sep 2026',
      ),
    ];
  }

  // =============================================
  // DATA TUGAS
  // =============================================
  static List<TugasModel> getTugas(String courseId) {
    return [
      TugasModel(
        id: '1',
        judul: 'Tugas 1 – Laporan Pendahuluan',
        deskripsi: 'Buat laporan singkat tentang topik pertemuan 1 (min. 3 halaman).',
        deadline: '10 Sep 2026',
        sudahDikumpulkan: true,
        nilai: 85,
      ),
      TugasModel(
        id: '2',
        judul: 'Tugas 2 – Implementasi Konsep',
        deskripsi: 'Implementasikan konsep yang dipelajari pada pertemuan 2.',
        deadline: '17 Sep 2026',
        sudahDikumpulkan: true,
        nilai: 90,
      ),
      TugasModel(
        id: '3',
        judul: 'Tugas 3 – Studi Kasus',
        deskripsi: 'Analisis studi kasus terkait materi pertemuan 3 (kelompok 2 orang).',
        deadline: '24 Sep 2026',
        sudahDikumpulkan: false,
      ),
      TugasModel(
        id: '4',
        judul: 'Tugas 4 – Mini Project',
        deskripsi: 'Buat mini project sesuai ketentuan yang telah diberikan.',
        deadline: '1 Okt 2026',
        sudahDikumpulkan: false,
      ),
    ];
  }

  // =============================================
  // DATA PENGUMUMAN
  // =============================================
  static List<PengumumanModel> getPengumuman(String courseId) {
    return [
      PengumumanModel(
        id: '1',
        judul: 'Perubahan Jadwal UTS',
        isi: 'UTS akan dilaksanakan pada tanggal 10 Oktober 2026. Materi yang diujikan adalah pertemuan 1–7. Harap mempersiapkan diri dengan baik.',
        tanggal: '22 Sep 2026',
        dosen: 'Dosen Pengampu',
      ),
      PengumumanModel(
        id: '2',
        judul: 'Tugas 3 – Perpanjangan Deadline',
        isi: 'Batas waktu pengumpulan Tugas 3 diperpanjang hingga 26 September 2026 pukul 23:59 WIB. Tidak ada perpanjangan lebih lanjut.',
        tanggal: '20 Sep 2026',
        dosen: 'Dosen Pengampu',
      ),
      PengumumanModel(
        id: '3',
        judul: 'Kuliah Tamu dari Industri',
        isi: 'Akan ada kuliah tamu dari praktisi industri pada Rabu, 1 Oktober 2026. Kehadiran wajib dan dihitung sebagai nilai kehadiran tambahan.',
        tanggal: '15 Sep 2026',
        dosen: 'Dosen Pengampu',
      ),
    ];
  }

  // =============================================
  // DATA NILAI
  // =============================================
  static List<NilaiModel> getNilai(String courseId) {
    return [
      NilaiModel(komponen: 'Tugas 1', nilai: 85, bobot: 10),
      NilaiModel(komponen: 'Tugas 2', nilai: 90, bobot: 10),
      NilaiModel(komponen: 'Tugas 3', nilai: 0, bobot: 10),
      NilaiModel(komponen: 'Kehadiran', nilai: 90, bobot: 10),
      NilaiModel(komponen: 'UTS', nilai: 0, bobot: 30),
      NilaiModel(komponen: 'UAS', nilai: 0, bobot: 30),
    ];
  }
}
