import 'package:zurex_admin/app/core/dimensions.dart';
import 'package:zurex_admin/app/core/extensions.dart';
import 'package:flutter/material.dart';
import '../app/core/styles.dart';
import '../app/core/text_styles.dart';
import 'lottie_file.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget? aIcon, bIcon;
  final String? text;
  final double? textSize;
  final Color? textColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final double? radius;
  final bool isLoading;
  final bool isActive;
  final bool withBorderColor;
  final bool withShadow;
  final double? space;

  const CustomButton({
    super.key,
    this.aIcon,
    this.bIcon,
    this.onTap,
    this.isActive = true,
    this.radius,
    this.height,
    this.isLoading = false,
    this.textColor,
    this.backgroundColor = Styles.PRIMARY_COLOR,
    this.borderColor,
    this.width,
    this.textSize,
    this.withBorderColor = false,
    this.withShadow = false,
    this.text,
    this.space,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          if (onTap != null && !isLoading && isActive) {
            onTap?.call();
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutBack,
          width: !isLoading ? width ?? context.width : 100,
          height: height ?? 50.h,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: (onTap == null || !isActive)
                ? Styles.LIGHT_BORDER_COLOR
                : backgroundColor,
            boxShadow: withShadow
                ? [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(1, 1))
                  ]
                : null,
            border: Border.all(
                color: withBorderColor
                    ? borderColor ?? Styles.PRIMARY_COLOR
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(radius ?? 15),
            gradient: backgroundColor != null
                ? null
                : const LinearGradient(
                    colors: Styles.kBackgroundGradient,
                  ),
          ),
          child: Center(
            child: isLoading
                ? LottieFile.asset("loading", height: height)
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (aIcon != null) ...[
                        aIcon!,
                        SizedBox(width: space ?? 12.w),
                      ],
                      if (text != null)
                        Flexible(
                          child: Text(
                            text ?? "",
                            style: AppTextStyles.w700.copyWith(
                              fontSize: textSize ?? 16,
                              height: 1,
                              overflow: TextOverflow.ellipsis,
                              color: textColor ?? Styles.WHITE_COLOR,
                            ),
                          ),
                        ),
                      if (bIcon != null) ...[
                        SizedBox(width: space ?? 12.w),
                        bIcon!,
                      ],
                    ],
                  ),
          ),
        ));
  }
}
