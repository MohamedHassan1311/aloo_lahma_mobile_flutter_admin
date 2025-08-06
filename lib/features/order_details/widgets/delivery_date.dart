import 'package:flutter/material.dart';
import 'package:zurex_admin/app/core/svg_images.dart';
import 'package:zurex_admin/components/custom_images.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              customImageIconSVG(
                  imageName: SvgImages.calendar,
                  color: Styles.HEADER,
                  width: 18.w,
                  height: 18.w),
              SizedBox(width: Dimensions.paddingSizeMini.w),
              Expanded(
                child: Text(
                  getTranslated("delivery_date_time"),
                  style: AppTextStyles.w700
                      .copyWith(fontSize: 16, color: Styles.HEADER),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.paddingSizeMini.h),
          Text(
            "$date - $time",
            style:
                AppTextStyles.w500.copyWith(fontSize: 14, color: Styles.TITLE),
          ),
        ],
      ),
    );
  }
}
