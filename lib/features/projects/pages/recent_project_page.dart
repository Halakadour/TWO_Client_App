import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:two_client_app/config/constants/padding_config.dart';
import 'package:two_client_app/config/theme/color.dart';
import 'package:two_client_app/core/functions/bloc_state_handling/app_bloc_state_handling.dart';
import 'package:two_client_app/features/app/bloc/app_bloc.dart';
import 'package:two_client_app/features/home/widgets/filters/project_filter_dialog.dart';
import 'package:two_client_app/core/widgets/buttons/elevated-button/custom_add_navy_button.dart';
import 'package:two_client_app/features/home/widgets/custom_back_icon_with_text.dart';

class RecentprojectPage extends StatefulWidget {
  const RecentprojectPage({super.key});

  @override
  State<RecentprojectPage> createState() => _RecentprojectPageState();
}

class _RecentprojectPageState extends State<RecentprojectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CustomBackIconWithText(text: 'Recent Projects'),
            PaddingConfig.h16,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const ProjectFilterDialog(),
                const SizedBox(width: 10),
                CustomAddNavyButton(text: "New Project", onTap: () {}),
              ],
            ),
            PaddingConfig.h16,
            Expanded(
              child: BlocBuilder<AppBloc, AppState>(
                buildWhen: (previous, current) =>
                    previous.projectListStatus != current.projectListStatus,
                builder: (context, state) {
                  return AppBlocStateHandling().showProjectList(state);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
