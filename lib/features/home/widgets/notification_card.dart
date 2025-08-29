import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:two_client_app/config/constants/padding_config.dart';
import 'package:two_client_app/config/theme/color.dart';
import 'package:two_client_app/config/theme/text_style.dart';
import 'package:two_client_app/core/functions/helper_functions.dart';
import 'package:two_client_app/core/network/enums.dart';
import 'package:two_client_app/core/widgets/container/dynamic_status_container.dart';
import 'package:two_client_app/features/app/bloc/app_bloc.dart';
import 'package:two_client_app/features/app/data/models/single-models/notification_model.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notificationModel});
  final NotificationModel notificationModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: AppColors.fontLightColor.withOpacity(0.4),
      color: AppColors.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: AppColors.blue2.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    "P",
                    style: AppTextStyle.headerMd(color: AppColors.blue2),
                  ),
                ),
                PaddingConfig.w16,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Project Update",
                              style: AppTextStyle.bodyLg(),
                            ),
                          ],
                        ),
                        PaddingConfig.w32,
                        Text(
                          HelperFunctions.getTimeAgo(
                            notificationModel.project.updatedAt,
                          ),
                          style: AppTextStyle.bodySm(
                            color: AppColors.fontLightColor,
                          ),
                        ),
                      ],
                    ),
                    PaddingConfig.h8,
                    Row(
                      children: [
                        Text(
                          "Project Updated to :",
                          style: AppTextStyle.bodySm(),
                        ),
                        PaddingConfig.w32,
                        DynamicStatusContainer(
                          status: notificationModel.project.status,
                        ),
                      ],
                    ),
                    PaddingConfig.h8,
                    if (notificationModel.message.trim().isNotEmpty)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Message : ",
                            style: AppTextStyle.bodyMd(
                              color: AppColors.fontDarkColor,
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              notificationModel.message,
                              overflow: TextOverflow.fade,
                              style: AppTextStyle.bodySm(),
                            ),
                          ),
                        ],
                      ),
                    PaddingConfig.h8,
                  ],
                ),
              ],
            ),
            PaddingConfig.h16,
            Divider(color: AppColors.gray2, thickness: 0.7),
            BlocListener<AppBloc, AppState>(
              listenWhen: (previous, current) =>
                  previous.notificationStatus != current.notificationStatus,
              listener: (context, state) {
                if (state.notificationStatus == CasualStatus.success) {
                  context.read<AppBloc>().add(GetUnreadNotificationEvent());
                }
              },
              child: GestureDetector(
                onTap: () => context.read<AppBloc>().add(
                  GetNotificationEvent(id: notificationModel.id),
                ),
                child: Row(
                  children: [
                    PaddingConfig.w8,
                    Icon(Iconsax.eye),
                    PaddingConfig.w8,
                    Text("Mark as read", style: AppTextStyle.bodySm()),
                  ],
                ),
              ),
            ),
            PaddingConfig.h8,
          ],
        ),
      ),
    );
  }
}
