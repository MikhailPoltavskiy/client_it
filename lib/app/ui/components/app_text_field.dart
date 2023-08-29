import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String labelText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      borderRadius: BorderRadius.circular(16),
      elevation: 50,
      color: Colors.white,
      child: TextFormField(
        obscureText: obscureText,
        validator: emptyValidator,
        maxLines: 1,
        controller: controller,
        decoration: InputDecoration(
          hintText: labelText,
          // labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  String? emptyValidator(String? value) {
    if (value?.isEmpty == true) {
      return 'cannot be empty';
    }
    return null;
  }
}
