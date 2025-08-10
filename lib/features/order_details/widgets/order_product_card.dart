import 'package:flutter/material.dart';
import '../../../app/core/app_core.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../../../components/custom_simple_dialog.dart';
import '../model/order_product_model.dart';
import 'order_product_gift_card.dart';

class OrderProductCard extends StatelessWidget {
  const OrderProductCard({super.key, required this.product});
  final OrderProductModel product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (product.gift != null) {
          CustomSimpleDialog.parentSimpleDialog(
              customWidget: OrderProductGiftCard(gift: product.gift));
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeExtraSmall.w,
          vertical: Dimensions.paddingSizeExtraSmall.h,
        ),
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
                color: Colors.black.withValues(alpha: 0.02))
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Dimensions.paddingSizeMini.w,
          children: [
            Stack(children: [
              CustomNetworkImage.containerNewWorkImage(
                image: product.cover ?? '',
                height: 115.w,
                width: 115.w,
                radius: 12.w,
              ),
              if (product.gift != null)
                PositionedDirectional(
                  top: 4.h,
                  start: 4.w,
                  child: customContainerSvgIcon(
                    imageName: SvgImages.gift,
                    color: Styles.PRIMARY_COLOR,
                    backGround: Styles.WHITE_COLOR,
                    borderColor: Styles.WHITE_COLOR,
                    padding: 6.w,
                    width: 35.w,
                    height: 35.w,
                    radius: 100.w,
                  ),
                ),
            ]),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: Dimensions.paddingSizeMini.h,
                children: [
                  Row(
                    spacing: Dimensions.paddingSizeMini.w,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          spacing: Dimensions.paddingSizeMini.w,
                          children: [
                            ///Name
                            Flexible(
                              child: Text(
                                product.name ?? "Item Tile",
                                maxLines: 1,
                                style: AppTextStyles.w600.copyWith(
                                    fontSize: 16, color: Styles.HEADER),
                              ),
                            ),

                            ///Quantity
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 4.h,
                                horizontal: Dimensions.paddingSizeMini.w,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.paddingSizeMini.w),
                                color:
                                    Styles.PRIMARY_COLOR.withValues(alpha: 0.1),
                                border: Border.all(
                                    color: Styles.LIGHT_BORDER_COLOR),
                              ),
                              child: Text(
                                "x${product.quantity}",
                                style: AppTextStyles.w800.copyWith(
                                    fontSize: 14, color: Styles.PRIMARY_COLOR),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  ///Options Details
                  if ((product.items?.length ?? 0) > 0)
                    Text(
                      product.items!
                          .map((x) => "(${x.quantity})${x.name}")
                          .toList()
                          .join(", "),
                      style: AppTextStyles.w400
                          .copyWith(fontSize: 12, color: Styles.DETAILS_COLOR),
                    ),

                  ///Price && Notes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 4.w,
                    children: [
                      ///Notes Details
                      if (product.notes != null)
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              text: "${getTranslated("other_notes")}:\n",
                              style: AppTextStyles.w700
                                  .copyWith(fontSize: 14, color: Styles.HEADER),
                              children: [
                                TextSpan(
                                  text: product.notes ?? 'notes',
                                  style: AppTextStyles.w600.copyWith(
                                      fontSize: 12,
                                      color: Styles.DETAILS_COLOR),
                                ),
                              ],
                            ),
                          ),
                        ),

                      ///Price
                      RichText(
                        text: TextSpan(
                          text: "${product.amount?.toStringAsFixed(2)} ",
                          style: AppTextStyles.w600.copyWith(
                              fontSize: 18, color: Styles.PRIMARY_COLOR),
                          children: [
                            WidgetSpan(
                                child: AppCore.saudiRiyalSymbol(
                                    color: Styles.PRIMARY_COLOR)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
