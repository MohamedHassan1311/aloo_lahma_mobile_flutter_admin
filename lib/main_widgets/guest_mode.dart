import 'package:zurex_admin/app/core/dimensions.dart';
import 'package:zurex_admin/app/core/extensions.dart';
import 'package:zurex_admin/app/core/images.dart';
import 'package:zurex_admin/app/localization/language_constant.dart';
import 'package:zurex_admin/components/animated_widget.dart';
import 'package:zurex_admin/components/custom_button.dart';
import 'package:flutter/material.dart';
import '../app/core/styles.dart';
import '../app/core/text_styles.dart';
import '../components/custom_images.dart';
import '../navigation/custom_navigation.dart';
import '../navigation/routes.dart';

class GuestMode extends StatelessWidget {
  const GuestMode({super.key, this.width, this.height});
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListAnimator(
        customPadding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
            vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
        data: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE.h),
              child: customContainerImage(
                  imageName: Images.logo,
                  width: context.width * 0.6,
                  height: context.width * 0.3.h,
                  backGroundColor: Colors.transparent),
            ),
          ),
          Center(
            child: Text(getTranslated("guest_mode_title"),
                textAlign: TextAlign.center,
                style: AppTextStyles.w600
                    .copyWith(fontSize: 18, color: Styles.HEADER)),
          ),
          SizedBox(height: Dimensions.paddingSizeExtraSmall.h),
          Center(
            child: Text(getTranslated("guest_mode_description"),
                textAlign: TextAlign.center,
                style: AppTextStyles.w400
                    .copyWith(fontSize: 16, color: Styles.DETAILS_COLOR)),
          ),
          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE.h),
          CustomButton(
            text: getTranslated("login"),
            onTap: () => CustomNavigator.push(Routes.login, clean: true),
          ),
        ],
      ),
    );
  }
}
