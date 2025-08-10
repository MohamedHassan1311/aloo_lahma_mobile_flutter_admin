import 'package:flutter/material.dart';
import 'package:aloo_lahma_admin/app/core/dimensions.dart';

import '../../../../app/core/styles.dart';
import '../../../../app/core/text_styles.dart';
import '../../../../app/localization/language_constant.dart';

class RememberMe extends StatelessWidget {
  const RememberMe({super.key, this.check = false, required this.onChange});
  final bool check;
  final Function(bool) onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: check,
          onChanged: (v) => onChange(!check),
          activeColor: Styles.PRIMARY_COLOR,
          side: BorderSide(color: Styles.PRIMARY_COLOR),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        Expanded(
          child: Text(
            getTranslated("remember_me"),
            maxLines: 1,
            style: AppTextStyles.w500.copyWith(
                fontSize: 13,
                overflow: TextOverflow.ellipsis,
                color: check ? Styles.PRIMARY_COLOR : Styles.TITLE),
          ),
        ),
      ],
    );
  }
}
