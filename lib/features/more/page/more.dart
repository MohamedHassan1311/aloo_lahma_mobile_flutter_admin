import 'package:aloo_lahma_admin/app/core/dimensions.dart';
import 'package:aloo_lahma_admin/app/localization/language_constant.dart';
import 'package:aloo_lahma_admin/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloo_lahma_admin/app/core/app_state.dart';
import 'package:aloo_lahma_admin/components/animated_widget.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/svg_images.dart';
import '../../../data/config/di.dart';
import '../../../main_blocs/user_bloc.dart';
import '../../../navigation/custom_navigation.dart';
import '../../../navigation/routes.dart';
import '../../auth/logout/view/logout_button.dart';
import '../../language/bloc/language_bloc.dart';
import '../../language/page/language_button.dart';
import '../../notifications/bloc/turn_notification_bloc.dart';
import '../../notifications/repo/notifications_repo.dart';
import '../../profile/bloc/profile_bloc.dart';
import '../widgets/more_button.dart';
import '../widgets/profile_card.dart';
import '../widgets/turn_button.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  void initState() {
    ///To Update Balance
    if (sl<ProfileBloc>().isLogin) {
      sl<ProfileBloc>().add(Get());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LanguageBloc, AppState>(
        builder: (context, state) {
          return Stack(
            children: [
              CustomAppBar(withBack: false),
              SafeArea(
                child: Column(
                  children: [
                    ///Profile Card
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Dimensions.PADDING_SIZE_EXTRA_LARGE.h),
                        child: const ProfileCard(),
                      ),
                    ),

                    ///Body
                    Expanded(
                      child: BlocBuilder<UserBloc, AppState>(
                        builder: (context, state) {
                          return ListAnimator(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                            data: [
                              ///Buttons
                              if (UserBloc.instance.isLogin) ...[
                                ///Edit Profile
                                MoreButton(
                                  title: getTranslated("edit_profile",
                                      context: context),
                                  icon: SvgImages.edit,
                                  onTap: () =>
                                      CustomNavigator.push(Routes.editProfile),
                                ),

                                ///Notifications
                                BlocProvider(
                                  create: (context) => TurnNotificationsBloc(
                                      repo: sl<NotificationsRepo>()),
                                  child: BlocBuilder<TurnNotificationsBloc,
                                      AppState>(
                                    builder: (context, state) {
                                      return TurnButton(
                                        onTap: () => CustomNavigator.push(
                                            Routes.notifications),
                                        title: getTranslated("notifications",
                                            context: context),
                                        icon: SvgImages.notification,
                                        bing: context
                                            .read<TurnNotificationsBloc>()
                                            .isTurnOn,
                                        onSwitch: () {
                                          context
                                              .read<TurnNotificationsBloc>()
                                              .add(Turn());
                                        },
                                        isLoading: state is Loading,
                                      );
                                    },
                                  ),
                                ),

                                ///Change Password
                                MoreButton(
                                  title: getTranslated("change_password",
                                      context: context),
                                  icon: SvgImages.lockIcon,
                                  onTap: () => CustomNavigator.push(
                                      Routes.changePassword),
                                ),
                              ],

                              ///Language
                              const LanguageButton(),

                              ///Contact With Us
                              MoreButton(
                                title: getTranslated("contact_with_us",
                                    context: context),
                                icon: SvgImages.contactWithUs,
                                onTap: () =>
                                    CustomNavigator.push(Routes.contactWithUs),
                              ),

                              ///About the App
                              MoreButton(
                                title: getTranslated("about_the_app",
                                    context: context),
                                icon: SvgImages.aboutUs,
                                onTap: () =>
                                    CustomNavigator.push(Routes.aboutUs),
                              ),

                              ///Terms && Conditions
                              MoreButton(
                                title: getTranslated("terms_conditions",
                                    context: context),
                                icon: SvgImages.terms,
                                onTap: () => CustomNavigator.push(Routes.terms),
                              ),

                              ///Privacy && Policy
                              MoreButton(
                                title: getTranslated("privacy_policy",
                                    context: context),
                                icon: SvgImages.lockIcon,
                                onTap: () =>
                                    CustomNavigator.push(Routes.privacy),
                              ),

                              ///FAQS
                              MoreButton(
                                title: getTranslated("faqs", context: context),
                                icon: SvgImages.faqs,
                                onTap: () => CustomNavigator.push(Routes.faqs),
                              ),

                              const LogOutButton(),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
