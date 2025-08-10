import 'package:flutter/material.dart';

import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../enums/order_details_enums.dart';

class OrderCancelReason extends StatelessWidget {
  const OrderCancelReason({super.key, required this.cancelReason});
  final String cancelReason;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeMini.h),
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_SMALL.w,
          vertical: Dimensions.PADDING_SIZE_SMALL.h),
      decoration: BoxDecoration(
          color: Styles.WHITE_COLOR,
          borderRadius: BorderRadius.circular(16.w),
          border: Border.all(color: Styles.LIGHT_BORDER_COLOR)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///Title
          Row(
            spacing: Dimensions.paddingSizeMini.w,
            children: [
              customImageIconSVG(
                  imageName:
                      SvgImages.orderStatus(OrderStatuses.cancelled.name),
                  color: Styles.PRIMARY_COLOR,
                  width: 24.w,
                  height: 24.w),
              Expanded(
                child: Text(
                  getTranslated("cancelled_reason"),
                  style: AppTextStyles.w700
                      .copyWith(fontSize: 16, color: Styles.HEADER),
                ),
              ),
            ],
          ),
          Divider(height: 24.h, color: Styles.LIGHT_BORDER_COLOR),
          Text(
            cancelReason,
            style: AppTextStyles.w700
                .copyWith(fontSize: 16, color: Styles.SUBTITLE),
          ),
        ],
      ),
    );
  }
}
