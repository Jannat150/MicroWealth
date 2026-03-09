import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 12,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
