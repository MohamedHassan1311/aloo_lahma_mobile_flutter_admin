import 'package:flutter/material.dart';
import 'package:aloo_lahma_admin/app/core/dimensions.dart';
import 'package:aloo_lahma_admin/app/core/text_styles.dart';

import '../app/core/app_core.dart';
import '../app/core/styles.dart';

class DiscountWidget extends StatelessWidget {
  const DiscountWidget({super.key, this.discount, this.isPercentage = true});
  final String? discount;
  final bool isPercentage;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.w),
      decoration: const BoxDecoration(
        color: Styles.RED_COLOR,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          bottomLeft: Radius.circular(4),
        ),
      ),
      child: RichText(
        text: TextSpan(
          text: "-$discount ${isPercentage == true ? "%" : ""} ",
          style: AppTextStyles.w500
              .copyWith(fontSize: 14, color: Styles.WHITE_COLOR),
          children: [
            if (isPercentage != true)
              WidgetSpan(
                  child: AppCore.saudiRiyalSymbol(
                      color: Styles.WHITE_COLOR, size: 16.w)),
          ],
        ),
      ),
    );
  }
}
