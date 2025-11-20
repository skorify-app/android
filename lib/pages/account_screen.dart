import 'package:flutter/material.dart';
import 'package:skorify/components/account/change_password_field.dart';
import 'package:skorify/components/account/info_card.dart';
import 'package:skorify/components/account/logout_button.dart';
import 'package:skorify/components/account/info_static_card.dart';
import 'package:skorify/components/account/popup_input.dart';
import 'package:skorify/components/misc/bottom_navbar.dart';
import 'package:skorify/components/misc/top_bar.dart';
import 'package:skorify/handlers/api/account/info.dart';
import 'package:skorify/handlers/api/account/logout.dart';
import 'package:skorify/handlers/classes.dart';
import 'package:skorify/handlers/secure_storage_service.dart';
import 'package:skorify/pages/login_pages.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _SettingPageState();
}

class _SettingPageState extends State<AccountScreen> {
  final SecureStorageService _secureStorage = getStorage();

  int _selectedIndex = 2;
  var fullName = 'Loading...';
  var email = 'Loading...';
  var role = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadAccountInfo();
  }

  void _loadAccountInfo() async {
    String sessionId = await _secureStorage.getSession() ?? '';
    DefaultAPIResult account = await getAccountInfo(sessionId);

    if (account.success) {
      setState(() {
        fullName = account.result['full_name'];
        email = account.result['email'];
        role = account.result['role'];
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushNamed(context, '/homepages');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/activity');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F8),
      appBar: TopBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(71, 0, 0, 0),
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
                backgroundImage: AssetImage('assets/images/avatar.jpeg'),
              ),

              const SizedBox(height: 25),
              InfoCard(
                title: 'Nama',
                value: fullName,
                onTap: () => _showEditNameDialog(context),
              ),
              InfoCard(
                title: 'Email',
                value: email,
                onTap: () => _showEditEmailDialog(context),
              ),
              InfoCard(
                title: 'Kata sandi',
                value: '**********',
                onTap: () => _showEditPasswordDialog(context),
              ),
              InfoStaticCard(title: 'Peran', value: role),

              const SizedBox(height: 30),
              LogoutButton(onPressed: _processLogout),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavbar(
        index: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  // Dialog ubah data pengguna
  void _showEditNameDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController(
      text: fullName,
    );

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
              style: popupStyle,
              onPressed: () {
                setState(() {
                  fullName = nameController.text;
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
              child: popupButtonText,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditEmailDialog(BuildContext context) {
    TextEditingController emailController = TextEditingController(text: email);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: const Text("Ubah Email"),
        content: TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Masukkan email (contoh: user@gmail.com)",
          ),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: popupStyle,
              onPressed: () {
                setState(() {
                  email = emailController.text;
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
              child: popupButtonText,
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
                borderRadius: BorderRadius.circular(15),
              ),
              title: const Text("Ubah Kata Sandi"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ChangePasswordField(
                    currentPassController: currentPassController,
                    obscureCurrent: obscureCurrent,
                    onPressed: () {
                      setStateDialog(() {
                        obscureCurrent = !obscureCurrent;
                      });
                    },
                  ),

                  const SizedBox(height: 12),
                  ChangePasswordField(
                    currentPassController: newPassController,
                    obscureCurrent: obscureNew,
                    onPressed: () {
                      setStateDialog(() {
                        obscureNew = !obscureNew;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                    style: popupStyle,
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text(
                            "Kata sandi berhasil diperbarui!",
                          ),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.all(16),
                        ),
                      );
                    },
                    child: popupButtonText,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _processLogout() async {
    String sessionId = await _secureStorage.getSession() ?? '';
    StringAPIResult result = await logout(sessionId);

    if (result.success) {
      await _secureStorage.deleteSession();
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result.result)));

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    } else {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result.result)));
    }
  }
}
