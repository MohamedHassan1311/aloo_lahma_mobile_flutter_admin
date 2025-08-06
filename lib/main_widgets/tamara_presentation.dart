import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zurex_admin/app/core/app_strings.dart';
import 'package:zurex_admin/app/core/dimensions.dart';
import 'package:zurex_admin/app/core/images.dart';
import 'package:zurex_admin/components/custom_images.dart';

import '../app/core/app_core.dart';
import '../app/core/styles.dart';
import '../app/core/text_styles.dart';
import '../app/localization/language_constant.dart';
import '../navigation/custom_navigation.dart';
import '../navigation/routes.dart';

class TamaraPresentation extends StatelessWidget {
  const TamaraPresentation({super.key, this.price});
  final double? price;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => CustomNavigator.push(Routes.inAppWebView,
          arguments: AppStrings.tamaraUrl(price)),
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
          vertical: Dimensions.paddingSizeMini.h,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeExtraSmall.w,
          vertical: Dimensions.paddingSizeExtraSmall.h,
        ),
        decoration: BoxDecoration(
          color: Styles.WHITE_COLOR,
          border: Border.all(
            color: Styles.LIGHT_BORDER_COLOR,
          ),
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Row(
          children: [
            customImageIcon(
              imageName: Images.tamaraBadge,
              width: 70.w,
              height: 40.h,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: RichText(
                text: TextSpan(
                    text: getTranslated("tamara_tittle", context: context),
                    style: AppTextStyles.w500
                        .copyWith(fontSize: 14, color: Styles.TITLE),
                    children: [
                      TextSpan(
                        text: " ${((price ?? 0) / 3).toStringAsFixed(2)} ",
                        style: AppTextStyles.w600.copyWith(
                            fontSize: 14, color: Styles.PRIMARY_COLOR),
                      ),
                      WidgetSpan(
                          child: AppCore.saudiRiyalSymbol(
                              color: Styles.PRIMARY_COLOR)),
                      TextSpan(
                        text:
                            "  ${getTranslated("without_fees_or_interest_compatible_with_islamic_law", context: context)} ",
                        style: AppTextStyles.w500
                            .copyWith(fontSize: 14, color: Styles.TITLE),
                      ),
                      TextSpan(
                          text: getTranslated("for_more_details"),
                          style: AppTextStyles.w500.copyWith(
                              fontSize: 14,
                              color: Styles.PRIMARY_COLOR,
                              decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              CustomNavigator.push(Routes.inAppWebView,
                                  arguments: AppStrings.tamaraUrl(price));
                            }),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
