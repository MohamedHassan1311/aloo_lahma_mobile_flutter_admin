import 'package:zurex_admin/app/core/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../components/custom_images.dart';

class TurnButton extends StatelessWidget {
  const TurnButton({
    required this.title,
    required this.icon,
    this.onTap,
    required this.bing,
    required this.isLoading,
    super.key,
  });
  final String title;
  final String icon;
  final bool bing, isLoading;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Styles.WHITE_COLOR,
          border: Border(bottom: BorderSide(color: Styles.LIGHT_BORDER_COLOR))),
      padding: EdgeInsets.symmetric(
          vertical: Dimensions.PADDING_SIZE_SMALL.h,
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customImageIconSVG(
              imageName: icon, height: 22.w, width: 22.w, color: Styles.TITLE),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                title,
                maxLines: 1,
                style: AppTextStyles.w600.copyWith(
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                    color: Styles.TITLE),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          SizedBox(
            height: 10,
            child: Switch(
              value: bing,
              inactiveThumbColor: Styles.WHITE_COLOR,
              inactiveTrackColor: Styles.FILL_COLOR,
              onChanged: (v) {
                onTap?.call();
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
    );
  }
}
