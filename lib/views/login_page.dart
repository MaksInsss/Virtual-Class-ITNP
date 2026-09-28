import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import 'main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final AuthController authController = AuthController();

  bool _obscurePassword = true;

  // =========================
  // LOGIN
  // =========================
  void login() {
    String username = usernameController.text.trim();
    String password = passwordController.text;

    bool berhasil = authController.login(
      username,
      password,
    );

    if (berhasil) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(
            user: authController.getUser(),
          ),
        ),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username atau password salah!'),
        ),
      );
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBDBDBD),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),

              child: Container(
                padding: const EdgeInsets.fromLTRB(
                  42,
                  45,
                  42,
                  35,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),

                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    // =================================
                    // LOGO
                    // =================================
                    Image.asset(
                      'assets/ITNP_logo.png',
                      width: 150,
                      height: 150,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(height: 15),

                    // =================================
                    // JUDUL
                    // =================================
                    const Text(
                      'Virtual Class',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF6600),
                      ),
                    ),

                    const SizedBox(height: 2),

                    const Text(
                      'INSTITUT TEKNOLOGI NEGERI PONOROGO',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF555555),
                        letterSpacing: 0.3,
                      ),
                    ),

                    const SizedBox(height: 35),

                    // =================================
                    // USERNAME
                    // =================================
                    TextField(
                      controller: usernameController,

                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFE8F0FE),

                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xFFFFBE32),
                        ),

                        hintText: 'Username',

                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFCCCCCC),
                          ),
                        ),

                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFCCCCCC),
                            width: 1.5,
                          ),
                        ),

                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFFBE32),
                            width: 2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // =================================
                    // PASSWORD
                    // =================================
                    TextField(
                      controller: passwordController,

                      obscureText: _obscurePassword,

                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xFFE8F0FE),

                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Color(0xFFFFBE32),
                        ),

                        hintText: 'Password',

                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),

                          onPressed: () {
                            setState(() {
                              _obscurePassword =
                                  !_obscurePassword;
                            });
                          },
                        ),

                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFCCCCCC),
                          ),
                        ),

                        enabledBorder:
                            const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFCCCCCC),
                            width: 1.5,
                          ),
                        ),

                        focusedBorder:
                            const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFFBE32),
                            width: 2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    // =================================
                    // TOMBOL LOGIN
                    // =================================
                    SizedBox(
                      width: 165,
                      height: 46,

                      child: ElevatedButton(
                        onPressed: login,

                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFFFBE32),

                          foregroundColor: Colors.white,

                          elevation: 4,

                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(2),
                          ),
                        ),

                        child: const Text(
                          'Masuk',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 23),

                    // =================================
                    // LUPA PASSWORD
                    // =================================
                    TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Fitur lupa kata sandi belum tersedia.',
                            ),
                          ),
                        );
                      },

                      child: const Text(
                        'Lupa kata sandi?',
                        style: TextStyle(
                          color: Color(0xFFFF9800),
                          fontSize: 14,
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // =================================
                    // GARIS
                    // =================================
                    const Divider(
                      color: Color(0xFFCCCCCC),
                      thickness: 1,
                    ),

                    const SizedBox(height: 18),

                    // =================================
                    // FOOTER
                    // =================================
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,

                      children: [

                        TextButton(
                          onPressed: () {},

                          child: const Text(
                            'Bahasa Indonesia (id)',
                            style: TextStyle(
                              color: Color(0xFFFF9800),
                              fontSize: 14,
                            ),
                          ),
                        ),

                        Container(
                          height: 25,
                          width: 1,
                          color: Colors.grey,

                          margin:
                              const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                        ),

                        TextButton(
                          onPressed: () {},

                          child: const Text(
                            'Pemberitahuan kuki',
                            style: TextStyle(
                              color: Color(0xFFFF9800),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}