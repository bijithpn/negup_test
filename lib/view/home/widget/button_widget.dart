import 'package:flutter/material.dart';
import 'package:negup_test/core/constants/constants.dart';

class ButtonWidget extends StatelessWidget {
  final Color color;
  final VoidCallback? onPressed;
  final Size? minimumSize;
  final String title;
  final TextStyle? titleStyle;
  const ButtonWidget({
    super.key,
    required this.color,
    this.onPressed,
    required this.title,
    this.titleStyle,
    this.minimumSize = const Size(double.infinity, 60),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: minimumSize,
            backgroundColor: color,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: onPressed,
        child: Text(title,
            style: titleStyle ??
                Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColor.white,
                      fontWeight: FontWeight.bold,
                    )),
      ),
    );
  }
}
