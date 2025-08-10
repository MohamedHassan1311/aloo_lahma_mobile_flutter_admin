import 'package:aloo_lahma_admin/app/core/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../components/custom_images.dart';

class TurnButton extends StatelessWidget {
  const TurnButton({
    super.key,
    required this.title,
    required this.icon,
    required this.bing,
    required this.isLoading,
    this.onSwitch,
    this.onTap,
  });
  final String title;
  final String icon;
  final bool bing, isLoading;
  final void Function()? onSwitch, onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeMini.h),
        padding: EdgeInsets.symmetric(
            vertical: Dimensions.paddingSizeExtraSmall.h,
            horizontal: Dimensions.PADDING_SIZE_SMALL.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.w),
            color: Styles.WHITE_COLOR,
            border: Border.all(color: Styles.LIGHT_BORDER_COLOR)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: Dimensions.PADDING_SIZE_SMALL.w,
          children: [
            customContainerSvgIcon(
              imageName: icon,
              padding: 8.w,
              radius: 12.w,
              height: 40.w,
              width: 40.w,
              borderColor: Styles.LIGHT_BORDER_COLOR,
              backGround: Styles.WHITE_COLOR,
              color: Styles.PRIMARY_COLOR,
            ),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                style: AppTextStyles.w700.copyWith(
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                    color: Styles.HEADER),
              ),
            ),
            SizedBox(
              height: 10,
              child: Switch(
                value: bing,
                inactiveThumbColor: Styles.WHITE_COLOR,
                inactiveTrackColor: Styles.FILL_COLOR,
                onChanged: (v) {
                  onSwitch?.call();
                },
                trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states) {
                      return bing ? Styles.PRIMARY_COLOR : Styles.FILL_COLOR;
                    }),
                trackOutlineWidth: WidgetStateProperty.resolveWith<double?>(
                        (Set<WidgetState> states) {
                      return 1.0;
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
