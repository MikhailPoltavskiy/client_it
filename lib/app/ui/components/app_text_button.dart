import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.textButton,
    this.backgroundColor = Colors.blueAccent,
  });

  final VoidCallback onPressed;
  final String textButton;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          elevation: MaterialStateProperty.all<double>(50),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(
              color: Colors.black,
            ),
          )),
          fixedSize: MaterialStateProperty.all<Size>(
            const Size(double.maxFinite, 40),
          )),
      child: Text(textButton),
    );
  }
}
