import 'package:zurex_admin/app/core/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../app/core/app_core.dart';
import '../features/order_details/model/order_details_model.dart';

class BillDetails extends StatelessWidget {
  const BillDetails({super.key, this.bill, this.decoration});
  final BillModel? bill;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
          vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
      decoration: decoration ?? const BoxDecoration(color:Color(0xFFF5FBFF)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslated("receipt_details"),
            style:
                AppTextStyles.w700.copyWith(fontSize: 16, color: Styles.HEADER),
          ),
          SizedBox(height: 8.h),

          ///Sub Total
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    getTranslated("sub_total"),
                    style: AppTextStyles.w600
                        .copyWith(fontSize: 14, color: Styles.HEADER),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "${(bill?.subTotal ?? 0).toStringAsFixed(2)}  ",
                    style: AppTextStyles.w500
                        .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
                    children: [
                      WidgetSpan(
                          child: AppCore.saudiRiyalSymbol(
                              color: Styles.DETAILS_COLOR, size: 16.w)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          ///Discount
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    getTranslated("discount"),
                    // "${getTranslated("discount")}(${priceDetails?.couponPercentage ?? 0}%)",
                    style: AppTextStyles.w600
                        .copyWith(fontSize: 14, color: Styles.HEADER),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "${(bill?.discount ?? 0).toStringAsFixed(2)}  ",
                    style: AppTextStyles.w500
                        .copyWith(fontSize: 14, color: Styles.IN_ACTIVE),
                    children: [
                      WidgetSpan(
                          child: AppCore.saudiRiyalSymbol(
                              color: Styles.IN_ACTIVE, size: 16.w)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          ///Tax
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "${getTranslated("tax")}(${bill?.taxPercentage ?? 0}%)",
                    style: AppTextStyles.w600
                        .copyWith(fontSize: 14, color: Styles.HEADER),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "${(bill?.tax ?? 0).toStringAsFixed(2)}  ",
                    style: AppTextStyles.w500
                        .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
                    children: [
                      WidgetSpan(
                          child: AppCore.saudiRiyalSymbol(
                              color: Styles.DETAILS_COLOR, size: 16.w)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          ///fees
          if (bill?.fees != 0 || bill?.fees != null)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${getTranslated("fees")}(${bill?.feesPercentage ?? 0}%)",
                          style: AppTextStyles.w600
                              .copyWith(fontSize: 14, color: Styles.HEADER),
                        ),
                        Text(
                          "(${getTranslated("fees_desc")})",
                          style: AppTextStyles.w400.copyWith(
                              fontSize: 10, color: Styles.DETAILS_COLOR),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "${(bill?.fees ?? 0).toStringAsFixed(2)}  ",
                      style: AppTextStyles.w500
                          .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
                      children: [
                        WidgetSpan(
                            child: AppCore.saudiRiyalSymbol(
                                color: Styles.DETAILS_COLOR, size: 16.w)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ///Total
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    getTranslated("total"),
                    style: AppTextStyles.w600
                        .copyWith(fontSize: 16, color: Styles.TITLE),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "${(bill?.totalPrice ?? 0).toStringAsFixed(2)}  ",
                    style: AppTextStyles.w600
                        .copyWith(fontSize: 16, color: Styles.ACTIVE),
                    children: [
                      WidgetSpan(
                          child:
                              AppCore.saudiRiyalSymbol(color: Styles.ACTIVE)),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
