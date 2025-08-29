import 'package:flutter/material.dart';
import 'package:two_client_app/config/constants/padding_config.dart';
import 'package:two_client_app/config/paths/text_strings.dart';
import 'package:two_client_app/config/theme/text_style.dart';
import 'package:two_client_app/core/widgets/main_text_field.dart';
import 'package:two_client_app/features/auth/widgets/fetch_pdf_file_container.dart';
import 'package:two_client_app/features/projects/widgets/create-project/custom_choise_chip.dart';

class ProjectRequestStep extends StatefulWidget {
  const ProjectRequestStep({
    super.key,
    required this.formKey,
    required this.selectedProjectType,
    required this.selectedDesription,
    required this.selectedKeyRequirements,
    required this.projectDescriptionController,
    required this.requirementController,
    required this.fileB64,
  });

  final GlobalKey<FormState> formKey;

  final ValueNotifier<String?> selectedProjectType;
  final ValueNotifier<String?> selectedDesription;

  /// الآن صارت لائحة لأنه ممكن يختار أكثر من requirement
  final ValueNotifier<List<String>> selectedKeyRequirements;

  final TextEditingController projectDescriptionController;
  final TextEditingController requirementController;

  final ValueNotifier<String?> fileB64;

  @override
  State<ProjectRequestStep> createState() => _ProjectRequestStepState();
}

class _ProjectRequestStepState extends State<ProjectRequestStep> {
  bool _descriptionVisible = false;
  bool _requirementVisible = false;

  final List<String> description = [
    "Mobile App for Task Management",
    "E-commerce Website",
    "Portfolio Website",
    "Online Booking System",
    "Learning Management System (LMS)",
    "Social Media App",
    "Restaurant Ordering & Delivery App",
    "Fitness Tracking Application",
    "Real Estate Listing Website",
    "Blogging Platform",
    "Event Management App",
    "Customer Support Chatbot",
    "Inventory Management System",
    "Personal Finance & Budgeting App",
    "Online Marketplace Platform",
  ];

  final List<String> keyReq = [
    "Simple UI",
    "Multi-language",
    "Admin Dashboard",
    "User Authentication (Login/Signup)",
    "Secure Payment Integration",
    "Push Notifications",
    "Dark/Light Mode",
    "Fast Performance",
    "Scalable Architecture",
    "Cloud Storage Integration",
    "Data Analytics & Reports",
    "Role-based Access Control",
    "API Integration",
    "Offline Mode Support",
    "Responsive Design (Mobile + Web)",
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PaddingConfig.h16,
          Text("Project Type*", style: AppTextStyle.bodySm()),
          PaddingConfig.h16,

          /// Project Type
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(5, (index) {
              final labels = [
                "Mobile App",
                "Website",
                "System Analysis",
                "Software Testings",
                "Maintain",
              ];
              return ValueListenableBuilder(
                valueListenable: widget.selectedProjectType,
                builder: (context, value, child) => CustomChoiceChip(
                  label: labels[index],
                  selected: widget.selectedProjectType.value == labels[index],
                  onSelected: () =>
                      widget.selectedProjectType.value = labels[index],
                ),
              );
            }),
          ),

          /// Project Description
          PaddingConfig.h24,
          Text("Project Description*", style: AppTextStyle.bodySm()),
          PaddingConfig.h16,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...description.map((label) {
                return ValueListenableBuilder<String?>(
                  valueListenable: widget.selectedDesription,
                  builder: (context, value, child) => CustomChoiceChip(
                    label: label,
                    selected: widget.selectedDesription.value == label,
                    onSelected: () => widget.selectedDesription.value = label,
                  ),
                );
              }),
              CustomChoiceChip(
                label: "+",
                selected: false,
                onSelected: () {
                  setState(() {
                    _descriptionVisible = !_descriptionVisible;
                  });
                },
              ),
            ],
          ),
          PaddingConfig.h16,
          Visibility(
            visible: _descriptionVisible,
            child: MainTextField(
              hint: "",
              controller: widget.projectDescriptionController,
              maxLines: 4,
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return TextStrings.fieldValidation;
                } else {
                  return null;
                }
              },
              onSubmitted: (input) {
                if (input.trim().isNotEmpty) {
                  widget.selectedDesription.value = input.trim();
                  widget.projectDescriptionController.clear();
                  setState(() => _descriptionVisible = false);
                }
              },
            ),
          ),

          /// Key Requirements
          PaddingConfig.h24,
          Text("Key Requirments", style: AppTextStyle.bodySm()),
          PaddingConfig.h16,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...keyReq.map((label) {
                return ValueListenableBuilder<List<String>>(
                  valueListenable: widget.selectedKeyRequirements,
                  builder: (context, value, child) {
                    final isSelected = value.contains(label);
                    return CustomChoiceChip(
                      label: label,
                      selected: isSelected,
                      onSelected: () {
                        if (isSelected) {
                          widget.selectedKeyRequirements.value = List.from(
                            value,
                          )..remove(label);
                        } else {
                          widget.selectedKeyRequirements.value = List.from(
                            value,
                          )..add(label);
                        }
                      },
                    );
                  },
                );
              }),
              CustomChoiceChip(
                label: "+",
                selected: false,
                onSelected: () {
                  setState(() {
                    _requirementVisible = !_requirementVisible;
                  });
                },
              ),
            ],
          ),
          PaddingConfig.h16,
          Visibility(
            visible: _requirementVisible,
            child: MainTextField(
              hint: "Add your requirement",
              controller: widget.requirementController,
              maxLines: 2,
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return TextStrings.fieldValidation;
                } else {
                  return null;
                }
              },
              onSubmitted: (input) {
                if (input.trim().isNotEmpty) {
                  widget.selectedKeyRequirements.value = List.from(
                    widget.selectedKeyRequirements.value,
                  )..add(input.trim());
                  widget.requirementController.clear();
                  setState(() => _requirementVisible = false);
                }
              },
            ),
          ),

          /// Upload document
          PaddingConfig.h24,
          Text("Did you prepare any dacuments ?", style: AppTextStyle.bodySm()),
          PaddingConfig.h16,
          FetchPdfFileContainer(
            fileB64: widget.fileB64.value,
            onUpdate: (newFile) {
              widget.fileB64.value = newFile;
            },
          ),
          PaddingConfig.h24,
        ],
      ),
    );
  }
}
