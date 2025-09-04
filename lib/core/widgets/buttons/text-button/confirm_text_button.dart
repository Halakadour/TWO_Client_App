import 'package:flutter/material.dart';
import 'package:two_client_app/config/theme/color.dart';
import 'package:two_client_app/config/theme/text_style.dart';

class ConfirmTextButton extends StatelessWidget {
  const ConfirmTextButton({super.key, required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        "Confirm",
        style: AppTextStyle.buttonStyle(color: AppColors.blue2),
      ),
    );
  }
}
