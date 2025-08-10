import 'package:aloo_lahma_admin/app/core/extensions.dart';
import 'package:flutter/material.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../model/order_product_model.dart';
import 'order_product_card.dart';

class OrderProducts extends StatefulWidget {
  const OrderProducts({super.key, required this.items});
  final List<OrderProductModel> items;

  @override
  State<OrderProducts> createState() => _OrderProductsState();
}

class _OrderProductsState extends State<OrderProducts> {
  bool _isExpanded = true;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    getTranslated("products"),
                    style: AppTextStyles.w700
                        .copyWith(fontSize: 16, color: Styles.HEADER),
                  ),
                ),
                SizedBox(width: Dimensions.paddingSizeMini.w),
                AnimatedRotation(
                  duration: const Duration(milliseconds: 450),
                  turns: _isExpanded ? 0.5 : 0,
                  child: Icon(Icons.keyboard_arrow_up_outlined,
                      size: 24, color: Styles.HEADER),
                ),
              ],
            ),
          ),
          AnimatedCrossFade(
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 400),
            firstChild: SizedBox(height: 0, width: context.width),
            secondChild: Column(
              children: [
                Divider(
                  height: Dimensions.PADDING_SIZE_DEFAULT.h,
                  color: Styles.LIGHT_BORDER_COLOR,
                ),
                ...List.generate(
                  widget.items.length,
                  (i) => OrderProductCard(product: widget.items[i]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
