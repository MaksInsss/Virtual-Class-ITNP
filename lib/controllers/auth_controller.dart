import '../models/user_model.dart';

class AuthController {
  // Data user sementara (dummy)
  final List<UserModel> _users = [
    UserModel(
      username: 'maksima',
      password: 'inss123',
      nama: 'Maksima Insan',
      nim: '250203230404489',
      programStudi: 'S1 Sastra Informatika',
      universitas: 'Institut Teknologi Negeri Ponorogo',
      semester: 3,
      role: 'mahasiswa',
      email: 'maksima@itnp.ac.id',
    ),
    UserModel(
      username: 'dosen',
      password: 'dosen123',
      nama: 'Dr. Budi Bud, M.Kom',
      nim: '-',
      nidn: '0712345678',
      programStudi: 'S1 Sastra Informatika',
      universitas: 'Institut Teknologi Negeri Ponorogo',
      semester: 0,
      role: 'dosen',
      email: 'budi.santoso@itnp.ac.id',
    ),
  ];

  UserModel? _loggedInUser;

  bool login(String username, String password) {
    for (final user in _users) {
      if (user.username == username && user.password == password) {
        _loggedInUser = user;
        return true;
      }
    }
    return false;
  }

  UserModel getUser() => _loggedInUser!;

  
}
