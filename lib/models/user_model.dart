class UserModel {
  String username;
  String password;
  String nama;
  String nim;
  String programStudi;
  String universitas;
  int semester;
  String role; // 'mahasiswa' atau 'dosen'
  String? nidn; // khusus dosen
  String? email;

  UserModel({
    required this.username,
    required this.password,
    required this.nama,
    required this.nim,
    required this.programStudi,
    required this.universitas,
    required this.semester,
    required this.role,
    this.nidn,
    this.email,
  });

  bool get isDosen => role == 'dosen';
  bool get isMahasiswa => role == 'mahasiswa';
}
