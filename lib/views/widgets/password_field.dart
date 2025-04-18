import 'package:flutter/material.dart';
import 'package:rektube/views/widgets/text_field.dart';

class PasswordField extends StatefulWidget {
  final String? hintText;
  final TextEditingController controller;
  //const PasswordField({super.key});
  const PasswordField({super.key, this.hintText, required this.controller});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      //duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return myTextField(
      hintText: widget.hintText,
      controller: widget.controller,
      prefixIcon: Icons.lock,
      suffixIcon: _obscureText ? Icons.visibility : Icons.visibility_off,
      obscureText: _obscureText,
      suffixIcontap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
    );
  }
}
