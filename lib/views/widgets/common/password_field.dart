import 'package:flutter/material.dart';
import 'package:rektube/views/widgets/common/text_field.dart';

class PasswordField extends StatefulWidget {
  final String? hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  //const PasswordField({super.key});
  const PasswordField({
    super.key,
    this.hintText = "Password",
    required this.controller,
    this.validator,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  //late AnimationController _controller;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return myTextField(
      hintText: widget.hintText,
      controller: widget.controller,
      prefixIcon: Icons.lock,
      suffixIcon: _obscureText ? Icons.visibility : Icons.visibility_off,
      obscureText: _obscureText,
      validator: widget.validator,
      suffixIcontap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
    );
  }
}
