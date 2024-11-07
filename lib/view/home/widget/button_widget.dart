import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Color color;
  final VoidCallback? onPressed;
  final String title;
  const ButtonWidget({
    super.key,
    required this.color,
    this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: color,
        ),
        onPressed: onPressed,
        child: Text(title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
      ),
    );
  }
}
