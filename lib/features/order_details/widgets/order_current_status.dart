import 'package:flutter/material.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';

class OrderCurrentStatus extends StatelessWidget {
  const OrderCurrentStatus({super.key, this.orderNum, this.status});
  final String? orderNum, status;

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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              "#${orderNum ?? 0}",
              style: AppTextStyles.w500
                  .copyWith(fontSize: 16, color: Styles.DETAILS_COLOR),
            ),
          ),
          // Container(
          //     width: 8.w,
          //     height: 8.w,
          //     margin: EdgeInsets.symmetric(horizontal: 4.w),
          //     decoration: BoxDecoration(
          //       color: Styles.PRIMARY_COLOR,
          //       borderRadius: BorderRadius.circular(2.w),
          //     ),
          //     child: SizedBox()),
          // Text(
          //   status?.capitalize() ?? "",
          //   style: AppTextStyles.w600.copyWith(
          //       fontSize: 14, color: Styles.PRIMARY_COLOR, height: 1.5),
          // ),
        ],
      ),
    );
  }
}
