import 'package:flutter/material.dart';
import 'package:aloo_lahma_admin/app/core/dimensions.dart';
import '../../../app/core/app_core.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../components/custom_network_image.dart';
import '../../../main_widgets/discount_widget.dart';
import '../main_models/purchased_product_model.dart';

class PurchasedProductCard extends StatelessWidget {
  const PurchasedProductCard({super.key, required this.item});
  final PurchasedProductModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.w),
        color: Colors.white,
        border: Border.all(
          color: Styles.LIGHT_BORDER_COLOR,
        ),
        boxShadow: [
          BoxShadow(
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(1, 1),
              color: Colors.black.withOpacity(0.02))
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                CustomNetworkImage.containerNewWorkImage(
                  height: 100.h,
                  width: double.infinity,
                  radius: 12.w,
                  image: item.image ?? "",
                ),
                if (item.discount != null && item.discount != 0)
                  Positioned(
                    top: 12,
                    right: 1,
                    child: DiscountWidget(
                      discount: "${item.discount ?? 0}",
                      isPercentage:
                          item.discountType == DiscountType.percentage.name,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///Name
                            Text(
                              item.name ?? "Item Tile",
                              style: AppTextStyles.w600.copyWith(
                                  fontSize: 16, color: Styles.HEADER),
                            ),

                            ///Price
                            RichText(
                              text: TextSpan(
                                text:
                                    "${item.totalPrice?.toStringAsFixed(2)} ",
                                style: AppTextStyles.w600.copyWith(
                                    fontSize: 18,
                                    color: Styles.PRIMARY_COLOR),
                                children: [
                                  WidgetSpan(
                                      child: AppCore.saudiRiyalSymbol(
                                          color: Styles.PRIMARY_COLOR)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: Dimensions.paddingSizeExtraSmall.w.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4.h,
                          horizontal: Dimensions.paddingSizeMini.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Dimensions.paddingSizeMini.w),
                          color: Colors.white,
                          border: Border.all(
                            color: Styles.LIGHT_BORDER_COLOR,
                          ),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(1, 1),
                                color: Colors.black.withOpacity(0.02))
                          ],
                        ),
                        child: Text(
                          "x${item.quantity}",
                          style: AppTextStyles.w600.copyWith(
                              fontSize: 16, color: Styles.PRIMARY_COLOR),
                        ),
                      ),
                    ],
                  ),
                  if ((item.options?.length ?? 0) > 0)
                    Divider(color: Styles.LIGHT_BORDER_COLOR, height: 16.h),
                  ...List.generate(
                    item.options?.length ?? 0,
                    (i) => Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Styles.GREEN,
                                  size: 14,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.w),
                                    child: Text(
                                      "${item.options?[i].name ?? ""}:  ",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.w400.copyWith(
                                          fontSize: 14, color: Styles.TITLE),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                    width: Dimensions
                                        .PADDING_SIZE_EXTRA_LARGE.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: List.generate(
                                      item.options?[i].items?.length ?? 0,
                                      (x) => Text(
                                        "-(${item.options?[i].items?[x].quantity ?? ""}) ${item.options?[i].items?[x].name ?? ""} ",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.w400.copyWith(
                                            fontSize: 12,
                                            color: Styles.DETAILS_COLOR),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
