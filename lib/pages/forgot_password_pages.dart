import 'package:flutter/material.dart';

class ForgotPasswordPages extends StatefulWidget {
  const ForgotPasswordPages({super.key});

  @override
  State<ForgotPasswordPages> createState() => _ForgotPasswordPagesState();
}

class _ForgotPasswordPagesState extends State<ForgotPasswordPages> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool agreeTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Bagian atas
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 60),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/register-background.png"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "Lupa Kata Sandi",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    "Masukkan email terdaftar untuk mengatur ulang kata sandi Anda",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 17 ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Form input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  buildTextField(
                    controller: nameController,
                    hint: "Email Terdaftar",
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 20),
                  buildTextField(
                    controller: emailController,
                    hint: "kata Sandi Baru",
                    icon: Icons.key,
                  ),
                  const SizedBox(height: 20),
                  buildTextField(
                    controller: passwordController,
                    hint: "konfirmasi Kata Sandi Baru",
                    icon: Icons.key,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Checkbox(
                        value: agreeTerms,
                        activeColor: Colors.blueAccent,
                        onChanged: (value) {
                          setState(() {
                            agreeTerms = value ?? false;
                          });
                        },
                      ),
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            text: 'Saya setuju dengan ',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                            children: [
                              TextSpan(
                                text: 'Syarat & Ketentuan',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(text: ' yang berlaku.'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF001F3F),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (!agreeTerms) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Harap setujui syarat & ketentuan.'),
                            ),
                          );
                          return;
                        }
                        // TODO: aksi daftar
                      },
                      child: const Text(
                        "KONFIRMASI",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade200,
        prefixIcon: Icon(icon, color: Colors.grey),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
