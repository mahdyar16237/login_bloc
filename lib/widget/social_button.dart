import 'package:flutter/material.dart';
import 'package:login_bloc/pallet.dart';

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
      icon: Icon(icon, size: 25, color: Pallete.whiteColor),
      label: Text(
        label,
        style: const TextStyle(color: Pallete.whiteColor, fontSize: 17),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: horizontalPadding,
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Pallete.borderColor, width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
