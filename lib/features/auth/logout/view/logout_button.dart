import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloo_lahma_admin/app/core/app_state.dart';
import 'package:aloo_lahma_admin/navigation/custom_navigation.dart';
import 'package:aloo_lahma_admin/navigation/routes.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/dimensions.dart';
import '../../../../app/core/styles.dart';
import '../../../../app/core/svg_images.dart';
import '../../../../app/core/text_styles.dart';
import '../../../../app/localization/language_constant.dart';
import '../../../../components/custom_images.dart';
import '../../../../data/config/di.dart';
import '../bloc/logout_bloc.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogoutBloc, AppState>(
      builder: (context, state) {
        return InkWell(
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            if (sl<LogoutBloc>().isLogin) {
              sl<LogoutBloc>().add(Click());
            } else {
              CustomNavigator.push(Routes.login);
            }
          },
          child: Container(
            margin:
            EdgeInsets.symmetric(vertical: Dimensions.paddingSizeMini.h),
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeExtraSmall.h,
                horizontal: Dimensions.PADDING_SIZE_SMALL.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.w),
                color: Styles.WHITE_COLOR,
                border: Border.all(color: Styles.LIGHT_BORDER_COLOR)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: Dimensions.PADDING_SIZE_SMALL.w,
              children: [
                customContainerSvgIcon(
                    imageName: sl<LogoutBloc>().isLogin
                        ? SvgImages.logout
                        : SvgImages.login,
                    padding: 8.w,
                    radius: 12.w,
                    height: 40.w,
                    width: 40.w,
                    borderColor: Styles.LIGHT_BORDER_COLOR,
                    backGround: Styles.WHITE_COLOR,
                    color: sl<LogoutBloc>().isLogin
                        ? Styles.ERORR_COLOR
                        : Styles.ACTIVE),
                // state is Loading
                //     ? const SpinKitThreeBounce(
                //         color: Styles.ERORR_COLOR, size: 25)
                //     :
                Flexible(
                  child: Text(
                      getTranslated(
                          sl<LogoutBloc>().isLogin ? "logout" : "login",
                          context: context),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.w700.copyWith(
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis,
                          color: sl<LogoutBloc>().isLogin
                              ? Styles.ERORR_COLOR
                              : Styles.ACTIVE)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
