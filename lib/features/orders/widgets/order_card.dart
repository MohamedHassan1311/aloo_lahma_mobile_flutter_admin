import 'package:aloo_lahma_admin/features/profile/enums/user_types_enum.dart';
import 'package:aloo_lahma_admin/main_blocs/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:aloo_lahma_admin/app/core/extensions.dart';
import 'package:aloo_lahma_admin/app/core/text_styles.dart';
import 'package:aloo_lahma_admin/app/localization/language_constant.dart';
import 'package:aloo_lahma_admin/features/orders/model/orders_model.dart';
import 'package:aloo_lahma_admin/navigation/custom_navigation.dart';
import 'package:aloo_lahma_admin/navigation/routes.dart';

import '../../../app/core/app_core.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../order_details/enums/order_details_enums.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () =>
          CustomNavigator.push(Routes.orderDetails, arguments: order.id ?? 0),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
            vertical: Dimensions.paddingSizeExtraSmall.h),
        margin:
            EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.w),
            border: Border.all(color: Styles.LIGHT_BORDER_COLOR),
            color: Styles.WHITE_COLOR,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                offset: Offset(1, 1),
                blurRadius: 10,
                spreadRadius: 1,
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: Dimensions.paddingSizeExtraSmall.w,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ID: ${order.orderNum ?? 0000}",
                        style: AppTextStyles.w500.copyWith(
                            fontSize: 14, color: Styles.DETAILS_COLOR),
                      ),
                      Row(
                        spacing: 4.w,
                        children: [
                          Container(
                              width: 8.w,
                              height: 8.w,
                              decoration: BoxDecoration(
                                color: Styles.PRIMARY_COLOR,
                                borderRadius: BorderRadius.circular(2.w),
                              ),
                              child: SizedBox()),
                          Expanded(
                            child: Text(
                              order.status?.capitalize() ?? "",
                              style: AppTextStyles.w600.copyWith(
                                  fontSize: 14,
                                  color: Styles.PRIMARY_COLOR,
                                  height: 1.5),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => CustomNavigator.push(Routes.orderDetails,
                      arguments: order.id ?? 0),
                  child: Row(
                    children: [
                      Text(
                        "${getTranslated("see_details")} ",
                        style: AppTextStyles.w500
                            .copyWith(fontSize: 14, color: Styles.ACCENT_COLOR),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                        color: Styles.ACCENT_COLOR,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(color: Styles.LIGHT_BORDER_COLOR, height: 24.h),
            Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4.h,
                  children: [
                    ///Delivery Type
                    if (UserBloc.instance.userType == UserType.admin.name)
                      RichText(
                        text: TextSpan(
                          text: "${getTranslated("receipt_type")}: ",
                          style: AppTextStyles.w400
                              .copyWith(fontSize: 14, color: Styles.SUBTITLE),
                          children: [
                            TextSpan(
                              text:
                                  getTranslated(order.deliveryType?.name ?? ''),
                              style: AppTextStyles.w600
                                  .copyWith(fontSize: 14, color: Styles.HEADER),
                            ),
                          ],
                        ),
                      ),

                    ///Delivery date
                    RichText(
                      text: TextSpan(
                        text: "${getTranslated("delivery_date")}: ",
                        style: AppTextStyles.w400
                            .copyWith(fontSize: 14, color: Styles.SUBTITLE),
                        children: [
                          TextSpan(
                            text: order.deliveryDay
                                ?.dateFormat(format: "d-MMM-yyyy"),
                            style: AppTextStyles.w600
                                .copyWith(fontSize: 14, color: Styles.HEADER),
                          ),
                        ],
                      ),
                    ),

                    ///Delivery Time
                    RichText(
                      text: TextSpan(
                        text: "${getTranslated("delivery_time")}: ",
                        style: AppTextStyles.w400
                            .copyWith(fontSize: 14, color: Styles.SUBTITLE),
                        children: [
                          TextSpan(
                            text: order.deliveryType == ReceiptTypes.delivery
                                ? order.deliveryTime?.name
                                : order.timeReceipt ?? '',
                            style: AppTextStyles.w600
                                .copyWith(fontSize: 14, color: Styles.HEADER),
                          ),
                        ],
                      ),
                    ),

                    ///Pay Type
                    RichText(
                      text: TextSpan(
                        text: "${getTranslated("pay_type")}: ",
                        style: AppTextStyles.w400
                            .copyWith(fontSize: 14, color: Styles.SUBTITLE),
                        children: [
                          TextSpan(
                            text: order.payType?.translatedCode ?? '',
                            style: AppTextStyles.w600
                                .copyWith(fontSize: 14, color: Styles.HEADER),
                          ),
                        ],
                      ),
                    ),

                    ///Total
                    RichText(
                      text: TextSpan(
                        text: "${(order.amount ?? 0).toStringAsFixed(2)}  ",
                        style: AppTextStyles.w600
                            .copyWith(fontSize: 14, color: Styles.TITLE),
                        children: [
                          WidgetSpan(
                              child: AppCore.saudiRiyalSymbol(
                                  color: Styles.HEADER)),
                        ],
                      ),
                    ),

                    ///Created At
                    Text(
                      (order.createdAt ?? DateTime.now())
                          .dateFormat(format: "d MMM yyyy hh:mm aa"),
                      style: AppTextStyles.w500
                          .copyWith(fontSize: 14, color: Styles.PRIMARY_COLOR),
                    ),
                  ],
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
