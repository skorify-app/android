import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:skorify/components/account/change_password_field.dart';
import 'package:skorify/components/account/info_card.dart';
import 'package:skorify/components/account/logout_button.dart';
import 'package:skorify/components/account/info_static_card.dart';
import 'package:skorify/components/account/popup_input.dart';
import 'package:skorify/components/misc/bottom_navbar.dart';
import 'package:skorify/components/misc/top_bar.dart';
import 'package:skorify/handlers/api/account/info.dart';
import 'package:skorify/handlers/api/account/logout.dart';
import 'package:skorify/handlers/api/account/update.dart';
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
  final box = Hive.box('storageBox');

  int _selectedIndex = 2;
  var fullName = 'Loading...';
  var email = 'Loading...';
  var role = 'Loading...';
  late String sessionId;

  @override
  void initState() {
    super.initState();
    _loadAccountInfo();
  }

  void _loadAccountInfo() async {
    sessionId = await _secureStorage.get('session') ?? '';
    if (sessionId.isEmpty) {
      if (!mounted) return;
      Navigator.pushNamed(context, '/homepage');
      return;
    }

    String savedFullName = await box.get('full_name') ?? fullName;
    String savedEmail = await box.get('email') ?? email;
    String savedRole = await box.get('role') ?? role;

    setState(() {
      fullName = savedFullName;
      email = savedEmail;
      role = savedRole;
    });

    DefaultAPIResult account = await getAccountInfo(sessionId);
    if (account.success) {
      String resFullName = account.result['full_name'];
      // If the full name is updated
      if (resFullName != savedFullName) {
        await box.put('full_name', resFullName);
        setState(() {
          fullName = resFullName;
        });
      }

      String resEmail = account.result['email'];
      if (resEmail != savedEmail) {
        await box.put('email', resEmail);
        setState(() {
          email = resEmail;
        });
      }

      String resRole = account.result['role'];
      if (resRole != savedRole) {
        await box.put('role', resRole);
        setState(() {
          role = resRole;
        });
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushNamed(context, '/homepage');
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
                _processUpdate({'fullName': nameController.text}, 'full_name');
                Navigator.pop(context);
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
            hintText: "Masukkan email",
          ),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: popupStyle,
              onPressed: () {
                _processUpdate({'email': emailController.text}, 'email');
                Navigator.pop(context);
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
                    label: 'Kata sandi sekarang',
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
                    label: 'Kata sandi baru',
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
                      _processUpdate({
                        'currentPassword': currentPassController.text,
                        'newPassword': newPassController.text,
                      }, 'password');
                      Navigator.pop(context);
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

  void _processUpdate(Map<String, String> data, String label) async {
    EmptyAPIResult result = await update(sessionId, data);

    if (result.success) {
      if (!mounted) return;

      String labelName = '';
      if (label == 'full_name') {
        labelName = 'nama lengkap';
        String dataResult = data['full_name'] ?? '';
        box.put('full_name', dataResult);

        setState(() {
          fullName = dataResult;
        });
      } else if (label == 'email') {
        labelName = 'alamat email';
        String dataResult = data['email'] ?? '';
        box.put('email', dataResult);

        setState(() {
          email = dataResult;
        });
      } else if (label == 'password') {
        labelName = 'kata sandi';
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Berhasil mengubah $labelName.')));
    } else {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result.error)));
    }
  }

  void _processLogout() async {
    StringAPIResult result = await logout(sessionId);

    if (result.success) {
      await _secureStorage.delete('session');
      await box.delete('full_name');
      await box.delete('role');

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
