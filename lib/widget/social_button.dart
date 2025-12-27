import 'package:flutter/material.dart';
import 'package:login_bloc/colors.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final double horizontalPadding;
  const SocialButton({
    Key? key,
    required this.icon,
    required this.label,
    this.horizontalPadding = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 25, color: colors.whiteColor),
      label: Text(
        label,
        style: const TextStyle(color: colors.whiteColor, fontSize: 17),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: horizontalPadding,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: colors.borderColor, width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
