import 'package:aloo_lahma_admin/app/core/extensions.dart';
import 'package:flutter/material.dart';

import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../model/order_product_model.dart';

class OrderProductGiftCard extends StatelessWidget {
  const OrderProductGiftCard({super.key, this.gift});
  final ProductModel? gift;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: Dimensions.PADDING_SIZE_DEFAULT.h,
        children: [
          Text(
            getTranslated("gift_details"),
            style: AppTextStyles.w700
                .copyWith(fontSize: 22, color: Styles.PRIMARY_COLOR),
          ),
          Container(
            margin:
                EdgeInsets.symmetric(vertical: Dimensions.paddingSizeMini.h),
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_SMALL.w,
              vertical: Dimensions.PADDING_SIZE_SMALL.h,
            ),
            decoration: BoxDecoration(
                color: Styles.WHITE_COLOR,
                borderRadius: BorderRadius.circular(12.w),
                border: Border.all(color: Styles.LIGHT_BORDER_COLOR)),
            child: Row(
              spacing: Dimensions.paddingSizeExtraSmall.w,
              children: [
                CustomNetworkImage.containerNewWorkImage(
                  image: gift?.cover ?? '',
                  width: 80.w,
                  height: 80.h,
                  radius: 16.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: Dimensions.paddingSizeMini.h,
                    children: [
                      ///Name
                      RichText(
                        text: TextSpan(
                            text: gift?.name ?? 'Product',
                            style: AppTextStyles.w700
                                .copyWith(fontSize: 16, color: Styles.HEADER),
                            children: [
                              ///Weight Desc
                              if (gift?.weightDesc != null)
                                TextSpan(
                                  text: gift?.weightDesc ?? '',
                                  style: AppTextStyles.w500.copyWith(
                                      fontSize: 14,
                                      color: Styles.PRIMARY_COLOR),
                                ),
                            ]),
                      ),
                    ],
                  ),
                ),
                customContainerSvgIcon(
                  imageName: SvgImages.gift,
                  color: Styles.WHITE_COLOR,
                  backGround: Styles.PRIMARY_COLOR,
                  borderColor: Styles.PRIMARY_COLOR,
                  padding: 8.w,
                  width: 40.w,
                  height: 40.w,
                  radius: 100.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
