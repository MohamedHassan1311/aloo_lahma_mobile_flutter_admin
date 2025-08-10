import 'package:aloo_lahma_admin/app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/app_state.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/images.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../bloc/notifications_bloc.dart';
import '../enum/notification_target_enum.dart';
import '../model/notifications_model.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    this.notification,
    this.withBorder = true,
  });

  final NotificationModel? notification;
  final bool withBorder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsBloc, AppState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
            vertical: Dimensions.paddingSizeMini.h,
          ),
          child: InkWell(
            onTap: () {
              if (notification?.target != null &&
                  notification?.target?.name == NotificationTarget.order) {
                CustomNavigator.push(Routes.orderDetails,
                    arguments: notification?.target?.id);
              }

              if (notification?.isRead != true) {
                context
                    .read<NotificationsBloc>()
                    .add(Read(arguments: notification?.id ?? ""));
              }
            },
            child: Container(
              width: context.width,
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL.w,
                  vertical: Dimensions.PADDING_SIZE_SMALL.h),
              decoration: BoxDecoration(
                  color: notification?.isRead == true
                      ? Styles.WHITE_COLOR
                      : Styles.PRIMARY_COLOR.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Styles.LIGHT_BORDER_COLOR)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8.h,
                children: [
                  customContainerImage(
                    backGroundColor: notification?.isRead != true
                        ? Styles.WHITE_COLOR
                        : Styles.PRIMARY_COLOR.withValues(alpha: 0.1),
                    imageName: Images.logo,
                    color: Styles.PRIMARY_COLOR,
                    radius: 100,
                    width: 50,
                    height: 50,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 2.h,
                      children: [
                        Text(
                          notification?.title ?? "Notification Title",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.w500
                              .copyWith(fontSize: 14, color: Styles.HEADER),
                        ),
                        ReadMoreText(
                          notification?.body ?? "Notification Message",
                          style: AppTextStyles.w500
                              .copyWith(fontSize: 12, color: Styles.TITLE),
                          trimLines: 2,
                          colorClickableText: Colors.pink,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: getTranslated("show_more"),
                          trimExpandedText: getTranslated("show_less"),
                          textAlign: TextAlign.start,
                          moreStyle: AppTextStyles.w600.copyWith(
                              fontSize: 14, color: Styles.PRIMARY_COLOR),
                          lessStyle: AppTextStyles.w600.copyWith(
                              fontSize: 14, color: Styles.PRIMARY_COLOR),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 2.h,
                    children: [
                      Text(
                        notification?.createdAt
                                ?.dateFormat(format: "d/M/yyyy") ??
                            "",
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppTextStyles.w600
                            .copyWith(fontSize: 12, color: Styles.TITLE),
                      ),
                      Text(
                        notification?.createdAt?.dateFormat(format: "h:m a") ??
                            "",
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppTextStyles.w400
                            .copyWith(fontSize: 12, color: Styles.SUBTITLE),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
