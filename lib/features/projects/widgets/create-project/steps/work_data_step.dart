import 'package:flutter/material.dart';
import 'package:two_client_app/config/constants/padding_config.dart';
import 'package:two_client_app/config/paths/text_strings.dart';
import 'package:two_client_app/config/theme/text_style.dart';
import 'package:two_client_app/core/widgets/main_text_field.dart';
import 'package:two_client_app/features/projects/widgets/create-project/custom_choise_chip.dart';

class WorkDataStep extends StatelessWidget {
  const WorkDataStep({
    super.key,
    required this.formKey,
    required this.selectedCooperationType,
    required this.dateController,
  });
  final GlobalKey<FormState> formKey;
  final ValueNotifier<String?> selectedCooperationType;
  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PaddingConfig.h16,
          // Cooperation Type
          Text("Cooperation Type*", style: AppTextStyle.bodySm()),
          PaddingConfig.h16,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(4, (index) {
              final labels = [
                "Analysis Only",
                "Development Only",
                "Complete project development and management",
                "Test Only",
              ];
              return ValueListenableBuilder(
                valueListenable: selectedCooperationType,
                builder: (context, value, child) => CustomChoiceChip(
                  label: labels[index],
                  selected: selectedCooperationType.value == labels[index],
                  onSelected: () =>
                      selectedCooperationType.value = labels[index],
                ),
              );
            }),
          ),
          PaddingConfig.h16,
          // Date
          Text(
            "When can we contract you?\nPlease specify day and time",
            style: AppTextStyle.bodySm(),
          ),
          PaddingConfig.h8,
          MainTextField(
            hint: "",
            controller: dateController,
            validator: (input) {
              if (input == null || input.trim().isEmpty) {
                return TextStrings.fieldValidation;
              } else {
                return null;
              }
            },
          ),
          PaddingConfig.h16,
        ],
      ),
    );
  }
}
