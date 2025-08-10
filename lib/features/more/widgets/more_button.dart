import 'package:aloo_lahma_admin/app/core/dimensions.dart';
import 'package:flutter/material.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../components/custom_images.dart';

class MoreButton extends StatelessWidget {
  const MoreButton(
      {required this.title,
        required this.icon,
        this.onTap,
        this.action,
        this.iconColor,
        super.key});

  final String title;
  final String icon;
  final void Function()? onTap;
  final Widget? action;
  final Color? iconColor;

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
              color: iconColor??Styles.PRIMARY_COLOR,
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
            SizedBox(width: 12.w),
            action ??
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: Styles.HEADER,
                )
          ],
        ),
      ),
    );
  }
}
