import 'package:flutter/material.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_images.dart';

class DeliveryDate extends StatelessWidget {
  const DeliveryDate({super.key, this.date, this.time});
  final String? date, time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeMini.h),
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
          vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
      decoration: BoxDecoration(
          color: Styles.WHITE_COLOR,
          borderRadius: BorderRadius.circular(16.w),
          border: Border.all(
            color: Styles.LIGHT_BORDER_COLOR,
          )),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeExtraSmall.w,
            vertical: Dimensions.paddingSizeExtraSmall.h),
        decoration: BoxDecoration(
          color: Styles.SMOKED_WHITE_COLOR,
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Row(
          spacing: Dimensions.paddingSizeMini.w,
          children: [
            customContainerSvgIcon(
              imageName: SvgImages.calendar,
              width: 50.w,
              height: 50.w,
              radius: 100.w,
              backGround: Styles.WHITE_COLOR,
              borderColor: Styles.WHITE_COLOR,
              color: Styles.PRIMARY_COLOR,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4.h,
                children: [
                  Text(
                    getTranslated("delivery_date_time"),
                    style: AppTextStyles.w700
                        .copyWith(fontSize: 16, color: Styles.HEADER),
                  ),
                  Text(
                    "${date ?? "12/4/2025"}\n${time ?? "gsdfs"}",
                    style: AppTextStyles.w500
                        .copyWith(fontSize: 14, color: Styles.TITLE),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
