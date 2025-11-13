import 'package:flutter/material.dart';

class ChangePasswordField extends StatelessWidget {
  const ChangePasswordField({
    super.key,
    required this.currentPassController,
    required this.obscureCurrent,
    required this.onPressed,
  });

  final TextEditingController currentPassController;
  final bool obscureCurrent;
  final void Function() onPressed;

  @override
  Widget build(BuildContext ctx) {
    return TextField(
      controller: currentPassController,
      obscureText: obscureCurrent,
      decoration: InputDecoration(
        labelText: "Masukkan kata sandi saat ini",
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(obscureCurrent ? Icons.visibility_off : Icons.visibility),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
