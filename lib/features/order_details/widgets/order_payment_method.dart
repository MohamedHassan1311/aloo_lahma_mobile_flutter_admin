import 'package:aloo_lahma_admin/app/core/extensions.dart';
import 'package:flutter/cupertino.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/images.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';
import '../model/payment_model.dart';
import 'bank_card.dart';

class OrderPaymentMethod extends StatelessWidget {
  const OrderPaymentMethod(
      {super.key, this.payment, this.bank, this.bankTransfer});
  final PaymentModel? payment;
  final PaymentMethodModel? bank;
  final String? bankTransfer;

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
        spacing: Dimensions.PADDING_SIZE_SMALL.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: Dimensions.paddingSizeMini.w,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: RichText(
                    text: TextSpan(
                        text: getTranslated("paid_from"),
                        style: AppTextStyles.w600.copyWith(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          color: Styles.HEADER,
                        ),
                        children: [
                          TextSpan(
                            text: " ${payment?.translatedCode ?? "name"}",
                            style: AppTextStyles.w700.copyWith(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              color: Styles.PRIMARY_COLOR,
                            ),
                          )
                        ]),
                  ),
                ),
              ),
              paymentImage(payment?.code ?? ""),
            ],
          ),
          if (bank != null)
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
              child: BankCard(model: bank!),
            ),
          if (bankTransfer != null) ...[
            Text(
              getTranslated("bank_transfer_image"),
              style: AppTextStyles.w700.copyWith(
                fontSize: 14,
                color: Styles.HEADER,
              ),
            ),
            CustomNetworkImage.containerNewWorkImage(
              image: bankTransfer!,
              height: 100.h,
              width: context.width,
              fit: BoxFit.contain,
            )
          ]
        ],
      ),
    );
  }

  paymentImage(String code) {
    switch (code) {
      case "electronic":
        return customImageIcon(
          imageName: Images.myFatorah,
          width: 95.w,
          height: 40.w,
        );
      case "bank":
        return customImageIconSVG(
          imageName: SvgImages.bank,
          width: 30.w,
          height: 30.w,
        );
      case "wallet":
        return customImageIconSVG(
          imageName: SvgImages.wallet,
          width: 50.w,
          height: 50.w,
        );
      case "cash_on_delivery":
        return customImageIcon(
          imageName: Images.cashOnDelivery,
          width: 40.w,
          height: 40.w,
        );
      case "tamara":
        return customImageIcon(
          imageName: Images.tamaraBadge,
          width: 70.w,
          height: 30.h,
        );
      case "tabby":
        return customImageIcon(
          imageName: Images.tabbyBadge,
          width: 70.w,
          height: 30.h,
        );

      default:
        return customImageIcon(
          imageName: Images.cashOnDelivery,
          width: 40.w,
          height: 40.w,
        );
    }
  }
}
