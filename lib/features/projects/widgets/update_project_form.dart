import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:two_client_app/config/constants/padding_config.dart';
import 'package:two_client_app/config/paths/text_strings.dart';
import 'package:two_client_app/config/theme/color.dart';
import 'package:two_client_app/config/theme/text_style.dart';
import 'package:two_client_app/core/functions/bloc_state_handling/app_bloc_state_handling.dart';
import 'package:two_client_app/core/widgets/buttons/elevated-button/main_gray_button.dart';
import 'package:two_client_app/core/widgets/buttons/elevated-button/main_green_button.dart';
import 'package:two_client_app/core/widgets/container/custom_rounder_container.dart';
import 'package:two_client_app/core/widgets/dialogs/forget_some_thing_dialog.dart';
import 'package:two_client_app/core/widgets/main_text_field.dart';
import 'package:two_client_app/features/app/bloc/app_bloc.dart';
import 'package:two_client_app/features/app/data/models/single-models/project_model.dart';

class UpdateProjectForm extends StatefulWidget {
  const UpdateProjectForm({super.key, required this.project});
  final ProjectModel project;

  @override
  State<UpdateProjectForm> createState() => _UpdateProjectFormState();
}

class _UpdateProjectFormState extends State<UpdateProjectForm> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _descriptionController;
  late final TextEditingController _requiredmentController;
  String? projectType;
  String? cooperationType;
  String? visibility;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _descriptionController = TextEditingController(
      text: widget.project.projectDescription,
    );
    _requiredmentController = TextEditingController(
      text: widget.project.requirements.join("\n"),
    );
    projectType = widget.project.projectType;
    cooperationType = widget.project.cooperationType;
    visibility = widget.project.private == 0 ? "Public" : "Private";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        spacing: 12,
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PaddingConfig.h16,
                // Project Desription
                Text("Project description", style: AppTextStyle.bodyXs()),
                PaddingConfig.h8,
                MainTextField(
                  fillColor: AppColors.gray1,
                  hint: "Project description",
                  height: 100,
                  maxLines: 10,
                  controller: _descriptionController,
                  validator: (p0) {
                    if (p0 != null) {
                      return null;
                    } else {
                      return TextStrings.fieldValidation;
                    }
                  },
                ),
                PaddingConfig.h16,
                // Project Requirdment
                Text("Project Requirdment", style: AppTextStyle.bodyXs()),
                PaddingConfig.h8,
                MainTextField(
                  fillColor: AppColors.gray1,
                  hint: "Project Requirdment",
                  height: 100,
                  maxLines: 10,
                  controller: _requiredmentController,
                  validator: (p0) {
                    if (p0 != null) {
                      return null;
                    } else {
                      return TextStrings.fieldValidation;
                    }
                  },
                ),
                PaddingConfig.h16,
                // Project Type
                Text("Project Type", style: AppTextStyle.bodySm()),
                PaddingConfig.h16,
                CustomRounderContainer(
                  backgroundColor: AppColors.gray1,
                  showBorder: false,
                  child: Wrap(
                    children: [
                      _buildRadioForProjectType("Mobile App", "Mobile App"),
                      PaddingConfig.w24,
                      _buildRadioForProjectType("Website", "Website"),
                      PaddingConfig.w24,
                      _buildRadioForProjectType("Maintain", "Maintain"),
                      PaddingConfig.w24,
                      _buildRadioForProjectType(
                        "Software Testing",
                        "Software Testing",
                      ),
                      PaddingConfig.w24,
                      _buildRadioForProjectType(
                        "System Analysis",
                        "System Analysis",
                      ),
                      PaddingConfig.w24,
                    ],
                  ),
                ),
                PaddingConfig.h24,
                // Coopertion Type
                Text("Coopertion Type", style: AppTextStyle.bodySm()),
                PaddingConfig.h16,
                CustomRounderContainer(
                  backgroundColor: AppColors.gray1,
                  showBorder: false,
                  child: Wrap(
                    children: [
                      _buildRadioForCoopertion(
                        "Analysis only",
                        "Analysis only",
                      ),
                      PaddingConfig.w24,
                      _buildRadioForCoopertion(
                        "Development only",
                        "Development only",
                      ),
                      PaddingConfig.w24,
                      _buildRadioForCoopertion(
                        "Complete project development and management",
                        "Complete project development and management",
                      ),
                      PaddingConfig.w24,
                      _buildRadioForCoopertion("Test only", "Test only"),
                      PaddingConfig.w24,
                    ],
                  ),
                ),
                PaddingConfig.h24,
                // Visibilty
                Text("Visibilty", style: AppTextStyle.bodySm()),
                PaddingConfig.h16,
                CustomRounderContainer(
                  backgroundColor: AppColors.gray1,
                  showBorder: false,
                  child: Row(
                    children: [
                      _buildRadioForVisibilty("Private", "Private"),
                      PaddingConfig.w24,
                      _buildRadioForVisibilty("Public", "Public"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          PaddingConfig.h24,
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlocListener<AppBloc, AppState>(
                listenWhen: (previous, current) =>
                    previous.updateProjectStatus != current.updateProjectStatus,
                listener: (context, state) {
                  AppBlocStateHandling().updateProject(state, context);
                },
                child: MainGreenButton(
                  text: "Save",
                  onpressed: () {
                    if (projectType == null) {
                      forgetSomeThingDialog(context, "The Project Type");
                    } else if (cooperationType == null) {
                      forgetSomeThingDialog(context, "The cooperation Type");
                    } else if (visibility == null) {
                      forgetSomeThingDialog(context, "The cooperation Type");
                    } else {
                      context.read<AppBloc>().add(
                        UpdateProjectEvent(
                          projectId: widget.project.id,
                          projectType: projectType!,
                          projectDescription: _descriptionController.text,
                          document: null,
                          requirements: _requiredmentController.text.split(
                            '\n',
                          ),
                          cooperationType: cooperationType!,
                          contactTime: widget.project.contactTime,
                          visibility:
                              (visibility!.toLowerCase().contains("pub"))
                              ? 0
                              : 1,
                        ),
                      );
                    }
                  },
                ),
              ),
              PaddingConfig.h8,
              MainGrayButton(text: "Cancel", onpressed: () => context.pop()),
            ],
          ),
          PaddingConfig.h16,
        ],
      ),
    );
  }

  /// build radio buttons list for project type chooses
  Widget _buildRadioForProjectType(String value, String label) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: projectType,
          activeColor: AppColors.blue2,
          onChanged: (String? newValue) {
            setState(() {
              projectType = newValue;
            });
          },
        ),
        Text(label, style: AppTextStyle.bodySm()),
      ],
    );
  }

  /// build radio buttons list for Coopertion Type chooses
  Widget _buildRadioForCoopertion(String value, String label) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: cooperationType,
          activeColor: AppColors.blue2,
          onChanged: (String? newValue) {
            setState(() {
              cooperationType = newValue;
            });
          },
        ),
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: AppTextStyle.bodySm(),
            overflow: TextOverflow.fade,
          ),
        ),
      ],
    );
  }

  /// build radio buttons list for visibilty chooses
  Widget _buildRadioForVisibilty(String value, String label) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: visibility,
          activeColor: AppColors.blue2,
          onChanged: (String? newValue) {
            setState(() {
              visibility = newValue;
            });
          },
        ),
        Text(label, style: AppTextStyle.bodySm()),
      ],
    );
  }
}
