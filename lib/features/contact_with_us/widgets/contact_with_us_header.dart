import 'package:flutter/widgets.dart';

import '../../../../app/core/dimensions.dart';
import '../../../../app/core/styles.dart';
import '../../../../app/core/text_styles.dart';
import '../../../../app/localization/language_constant.dart';

class ContactWithUsHeader extends StatelessWidget {
  const ContactWithUsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          getTranslated("contact_with_us_header"),
          textAlign: TextAlign.start,
          style:
              AppTextStyles.w700.copyWith(fontSize: 22, color: Styles.HEADER),
        ),
        SizedBox(height: Dimensions.PADDING_SIZE_LARGE.h),
      ],
    );
  }
}
