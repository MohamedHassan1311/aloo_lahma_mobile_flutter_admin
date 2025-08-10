import 'package:flutter/cupertino.dart';
import 'package:aloo_lahma_admin/app/core/extensions.dart';
import '../../../../app/core/dimensions.dart';
import '../../../../app/core/styles.dart';
import '../../../../app/core/svg_images.dart';
import '../../../../app/core/text_styles.dart';
import '../../../../app/localization/language_constant.dart';
import '../../../../components/custom_images.dart';
import '../../../profile/enums/user_types_enum.dart';

class ChooseUserType extends StatelessWidget {
  const ChooseUserType({super.key, required this.type, required this.onChange});
  final UserType type;
  final Function(UserType) onChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: CupertinoSlidingSegmentedControl<UserType>(
        groupValue: type,
        onValueChanged: (UserType? value) {
          if (value != null) {
            onChange.call(value);
          }
        },
        thumbColor: Styles.PRIMARY_COLOR,
        backgroundColor: Styles.PRIMARY_COLOR.withValues(alpha: 0.08),
        children: Map.fromIterable(
          [UserType.admin, UserType.driver],
          key: (item) => item as UserType,
          value: (item) {
            final userType = item as UserType;
            final isSelected = userType == type;

            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  vertical: Dimensions.PADDING_SIZE_SMALL.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  customImageIconSVG(
                    imageName: userType == UserType.driver
                        ? SvgImages.driver
                        : SvgImages.user,
                    width: 20.w,
                    height: 20.w,
                    color: isSelected ? Styles.WHITE_COLOR : Styles.DISABLED,
                  ),
                  SizedBox(width: 12.w),
                  Flexible(
                    child: Text(
                      getTranslated(userType.name),
                      maxLines: 1,
                      style: AppTextStyles.w600.copyWith(
                        fontSize: 14,
                        color:
                            isSelected ? Styles.WHITE_COLOR : Styles.DISABLED,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
