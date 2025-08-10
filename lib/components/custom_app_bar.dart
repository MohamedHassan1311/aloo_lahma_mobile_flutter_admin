import 'package:flutter/material.dart';
import 'package:aloo_lahma_admin/app/core/dimensions.dart';
import 'package:aloo_lahma_admin/app/core/extensions.dart';
import '../../navigation/custom_navigation.dart';
import '../app/core/styles.dart';
import '../app/core/text_styles.dart';
import 'custom_back_icon.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? actionChild;
  final bool withBack;
  final bool withHPadding;
  final bool withVPadding;
  final double? height;
  final double? actionPadding;
  final bool withSafeArea;
  final Color? backColor;
  final double? actionWidth;

  const CustomAppBar(
      {super.key,
        this.title,
        this.height,
        this.backColor,
        this.withHPadding = true,
        this.withVPadding = true,
        this.withBack = true,
        this.withSafeArea = true,
        this.actionWidth,
        this.actionPadding,
        this.actionChild});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: withHPadding ? Dimensions.PADDING_SIZE_DEFAULT.w : 0,
        vertical: withVPadding ? Dimensions.PADDING_SIZE_DEFAULT.h : 0,
      ),
      child: SafeArea(
        top: withSafeArea,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            withBack && CustomNavigator.navigatorState.currentState!.canPop()
                ? CustomBackIcon()
                : SizedBox(width: actionWidth ?? 50.w),
            const Expanded(child: SizedBox()),
            Text(
              title ?? "",
              style: AppTextStyles.w700
                  .copyWith(color: Styles.PRIMARY_COLOR, fontSize: 20),
            ),
            const Expanded(child: SizedBox()),
            SizedBox(
              height: actionWidth ?? 50.w,
              width: actionWidth ?? 50.w,
              child: Padding(
                padding: EdgeInsets.all(actionPadding ?? 12.w),
                child: actionChild,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(
      CustomNavigator.navigatorState.currentContext!.width, height ?? 100.h);
}
