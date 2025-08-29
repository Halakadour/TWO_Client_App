import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_client_app/config/constants/padding_config.dart';
import 'package:two_client_app/config/theme/color.dart';
import 'package:two_client_app/features/projects/widgets/custom_icon_with_text.dart';

class CustomContractDetailsColumn extends StatelessWidget {
  const CustomContractDetailsColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomIconWithText(
          color: AppColors.black,
          icon: Iconsax.document_text_1,
          text: 'Contract',
        ),
        PaddingConfig.h16,
        CustomIconWithText(
          color: AppColors.black,
          icon: Iconsax.clipboard_tick,
          text: 'CM Approvment',
        ),
        PaddingConfig.h16,
        CustomIconWithText(
          color: AppColors.black,
          icon: Iconsax.clipboard_tick,
          text: 'PM Approvment',
        ),
        PaddingConfig.h16,
        CustomIconWithText(
          color: AppColors.black,
          icon: Iconsax.tick_square,
          text: 'Status',
        ),
        PaddingConfig.h16,
        CustomIconWithText(
          color: AppColors.black,
          icon: Iconsax.edit,
          text: 'Need Edit ?',
        ),
        PaddingConfig.h16,
        CustomIconWithText(
          color: AppColors.black,
          icon: Iconsax.signpost,
          text: 'Admin Sign',
        ),
        PaddingConfig.h16,
        CustomIconWithText(
          color: AppColors.black,
          icon: Iconsax.document_text_1,
          text: 'Edit Request',
        ),
      ],
    );
  }
}
