import 'package:aloo_lahma_admin/app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloo_lahma_admin/app/core/app_state.dart';
import 'package:aloo_lahma_admin/app/core/dimensions.dart';
import 'package:aloo_lahma_admin/app/core/styles.dart';
import 'package:aloo_lahma_admin/app/core/svg_images.dart';
import 'package:aloo_lahma_admin/app/localization/language_constant.dart';
import 'package:aloo_lahma_admin/components/custom_images.dart';
import 'package:aloo_lahma_admin/components/shimmer/custom_shimmer.dart';
import 'package:aloo_lahma_admin/features/maps/bloc/map_bloc.dart';
import 'package:aloo_lahma_admin/features/maps/repo/maps_repo.dart';
import 'package:aloo_lahma_admin/main_blocs/user_bloc.dart';
import 'package:aloo_lahma_admin/navigation/custom_navigation.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/text_styles.dart';
import '../../../components/custom_bottom_sheet.dart';
import '../../../components/marquee_widget.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/guest_mode.dart';
import '../../../main_widgets/profile_image_widget.dart';
import '../../../navigation/routes.dart';
import '../../maps/models/location_model.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, AppState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Styles.PRIMARY_COLOR.withOpacity(0.28),
                Color(0XFFFFF6F1).withOpacity(0.2),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
            vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
          ),
          child: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: Dimensions.PADDING_SIZE_SMALL.w,
              children: [
                ///Profile Image Widget
                ProfileImageWidget(
                  withEdit: false,
                  radius: 30.w,
                  image: UserBloc.instance.user?.profileImage,
                ),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    if (UserBloc.instance.isLogin) {
                      CustomNavigator.push(Routes.editProfile);
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4.h,
                    children: [
                      ///Guest
                      Text(
                        "${getTranslated("welcome", context: context)}${UserBloc.instance.user?.name ?? "Guest"}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.w700
                            .copyWith(fontSize: 18, color: Styles.HEADER),
                      ),

                      ///Current Location
                      BlocProvider(
                        create: (context) =>
                            MapBloc(repo: sl<MapsRepo>())..add(Init()),
                        child: BlocBuilder<MapBloc, AppState>(
                          builder: (context, state) {
                            if (state is Done) {
                              LocationModel model =
                                  state.model as LocationModel;
                              return Row(
                                children: [
                                  customImageIconSVG(
                                      width: 20,
                                      height: 20,
                                      color: Styles.DETAILS_COLOR,
                                      imageName: SvgImages.location),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: MarqueeWidget(
                                      child: Text(
                                        model.address ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.w400.copyWith(
                                            fontSize: 14,
                                            color: Styles.DETAILS_COLOR),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Row(
                                children: [
                                  customImageIconSVG(
                                      width: 20,
                                      height: 20,
                                      color: Styles.PRIMARY_COLOR,
                                      imageName: SvgImages.location),
                                  SizedBox(width: 8.w),
                                  CustomShimmerText(width: 120.w),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )),
                customContainerSvgIcon(
                  onTap: () {
                    if (UserBloc.instance.isLogin) {
                      CustomNavigator.push(Routes.notifications);
                    } else {
                      CustomBottomSheet.show(widget: const GuestMode());
                    }
                  },
                  imageName: SvgImages.notification,
                  color: Styles.PRIMARY_COLOR,
                  backGround: Styles.PRIMARY_COLOR.withValues(alpha: 0.08),
                  borderColor: Styles.PRIMARY_COLOR.withValues(alpha: 0.08),
                  width: 50.w,
                  height: 50.w,
                  padding: 12.w,
                  radius: 8.w,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize =>
      Size(CustomNavigator.navigatorState.currentContext!.width, 100.h);
}
