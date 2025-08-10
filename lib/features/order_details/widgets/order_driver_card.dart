import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../main_models/user_model.dart';
import '../../language/bloc/language_bloc.dart';

class OrderDriverCard extends StatelessWidget {
  const OrderDriverCard({super.key, required this.driver});
  final UserModel driver;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeMini.h),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_SMALL.w,
        vertical: Dimensions.PADDING_SIZE_SMALL.h,
      ),
      decoration: BoxDecoration(
          color: Styles.WHITE_COLOR,
          borderRadius: BorderRadius.circular(12.w),
          border: Border.all(color: Styles.LIGHT_BORDER_COLOR)),
      child: Row(
        spacing: Dimensions.paddingSizeExtraSmall.w,
        children: [
          customContainerSvgIcon(
            imageName: SvgImages.driver,
            color: Styles.PRIMARY_COLOR,
            backGround: Styles.PRIMARY_COLOR.withValues(alpha: 0.1),
            borderColor: Styles.PRIMARY_COLOR.withValues(alpha: 0.1),
            padding: 8.w,
            width: 50.w,
            height: 50.w,
            radius: 100.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                ///Name
                RichText(
                  text: TextSpan(
                      text: getTranslated("driver"),
                      style: AppTextStyles.w500
                          .copyWith(fontSize: 14, color: Styles.HEADER),
                      children: [
                        TextSpan(
                          text: " ${driver.name ?? 'Driver'}",
                          style: AppTextStyles.w700.copyWith(
                              fontSize: 16, color: Styles.PRIMARY_COLOR),
                        ),
                      ]),
                ),
                Text(
                  "${LanguageBloc.instance.isLtr ? "+" : ""}966${driver.mobile ?? ''}${LanguageBloc.instance.isLtr ? "" : "+"}",
                  style: AppTextStyles.w500
                      .copyWith(fontSize: 14, color: Styles.SUBTITLE),
                ),
              ],
            ),
          ),
          customContainerSvgIcon(
            onTap: () => launchUrl(Uri.parse("tel://${driver.mobile}"),
                mode: LaunchMode.externalApplication),
            imageName: SvgImages.phoneCallIcon,
            color: Styles.WHITE_COLOR,
            backGround: Styles.PRIMARY_COLOR,
            borderColor: Styles.PRIMARY_COLOR,
            padding: 8.w,
            width: 40.w,
            height: 40.w,
            radius: 100.w,
          ),
        ],
      ),
    );
  }
}
