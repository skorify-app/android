import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  int _selectedIndex = 2; // default di tab "Akun"

  // ✅ Tambahkan variabel penyimpanan data pengguna
  String userName = "Hyung Jaehyun";
  String userEmail = "hyunghyung@gmail.com";
  String userPassword = "***********";

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigasi berdasarkan item
    if (index == 0) {
      Navigator.pushNamed(context, '/homepages');
    } else if (index == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Fitur Aktivitas belum tersedia"),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(
            'assets/images/logo.png',
          height: 20,
          width: 20,
          ),
        ),

          title: const Text(
            "Skorify",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration( // <-- Perbaikan di sini
              image: DecorationImage(
                image: AssetImage("assets/images/home-background.png"), // Pastikan path ini benar
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20), // 🔹 radius main body
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 50,
                // ✅ Catatan: Pastikan path gambar di sini benar dan gambarnya sesuai
                backgroundImage: AssetImage('assets/images/avatar.jpeg'), 
              ),
              const SizedBox(height: 25),

              _buildInfoCard(
                title: "Nama",
                value: userName,
                onTap: () => _showEditNameDialog(context),
              ),
              _buildInfoCard(
                title: "Email",
                value: userEmail,
                onTap: () => _showEditEmailDialog(context),
              ),
              _buildInfoCard(
                title: "Kata sandi",
                value: userPassword,
                onTap: () => _showEditPasswordDialog(context),
              ),
              _buildStaticCard(
                title: "Peran",
                value: "Peserta",
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF002C50),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "KELUAR",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // ✅ Bottom Navigation Bar dengan radius
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF001D39),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Beranda",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.checklist),
              label: "Aktivitas",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Akun",
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  // ==============================
  // 🟦 Dialog ubah data pengguna
  // ==============================

  void _showEditNameDialog(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: userName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Ubah Nama"),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF001D39),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // 🔹 radius 10
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              onPressed: () {
                setState(() {
                  userName = nameController.text;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Nama berhasil diperbarui!"),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.all(16),
                  ),
                );
              },
              child: const Text(
                "SIMPAN",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditEmailDialog(BuildContext context) {
    TextEditingController emailController =
        TextEditingController(text: userEmail);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Ubah Email"),
        content: TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress, // ✅ agar format email
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Masukkan email (contoh: user@gmail.com)",
          ),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF001D39),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // 🔹 radius 10
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              onPressed: () {
                setState(() {
                  userEmail = emailController.text;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Email berhasil diperbarui!"),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.all(16),
                  ),
                );
              },
              child: const Text(
                "SIMPAN",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditPasswordDialog(BuildContext context) {
    TextEditingController currentPassController = TextEditingController();
    TextEditingController newPassController = TextEditingController();
    bool obscureCurrent = true;
    bool obscureNew = true;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: const Text("Ubah Kata Sandi"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: currentPassController,
                    obscureText: obscureCurrent,
                    decoration: InputDecoration(
                      labelText: "Masukkan kata sandi saat ini",
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureCurrent
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setStateDialog(() {
                            obscureCurrent = !obscureCurrent;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: newPassController,
                    obscureText: obscureNew,
                    decoration: InputDecoration(
                      labelText: "Masukkan kata sandi baru",
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureNew
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setStateDialog(() {
                            obscureNew = !obscureNew;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF001D39),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                    ),
                    onPressed: () {
                      setState(() {
                        userPassword = newPassController.text;
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              const Text("Kata sandi berhasil diperbarui!"),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.all(16),
                        ),
                      );
                    },
                    child: const Text(
                      "SIMPAN",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ==============================
  // 🟩 Kartu info
  // ==============================

  Widget _buildInfoCard({
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "$title : $value",
                style: const TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildStaticCard({required String title, required String value}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)
        ],
      ),
      child: Text(
        "$title : $value",
        style: const TextStyle(fontSize: 15, color: Colors.black87),
      ),
    );
  }
}