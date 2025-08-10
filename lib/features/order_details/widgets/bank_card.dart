import 'package:flutter/material.dart';

import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_network_image.dart';
import '../../language/bloc/language_bloc.dart';
import '../model/payment_model.dart';

class BankCard extends StatelessWidget {
  const BankCard(
      {super.key,
      required this.model,
       this.isSelected = false,
       this.onSelect});
  final PaymentMethodModel model;
  final bool isSelected;
  final Function()? onSelect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelect?.call(),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeMini.w,
            vertical: Dimensions.paddingSizeMini.h),
        decoration: BoxDecoration(
            border: Border.all(
              color: isSelected
                  ? Styles.PRIMARY_COLOR.withValues(alpha: 0.15)
                  : Styles.LIGHT_BORDER_COLOR,
            ),
            color: isSelected
                ? Styles.PRIMARY_COLOR.withValues(alpha: 0.15)
                : Styles.WHITE_COLOR,
            borderRadius: BorderRadius.circular(12.w)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 4.h,
          children: [
            CustomNetworkImage.containerNewWorkImage(
                image: model.image ?? '',
                width: (model.iban != null) ? 100.w : 50.w,
                height: 50.w,
                fit: BoxFit.contain),
            Text(
              LanguageBloc.instance.isLtr
                  ? model.nameEn ?? ""
                  : model.nameAr ?? "",
              textAlign: TextAlign.center,
              style: AppTextStyles.w600.copyWith(
                fontSize: 14,
                color: Styles.TITLE,
              ),
            ),
            if (model.accountNumber != null)
              Text(
                "${getTranslated("account_number")}: ${model.accountNumber ?? ''}",
                textAlign: TextAlign.center,
                style: AppTextStyles.w600.copyWith(
                  fontSize: 14,
                  color: Styles.TITLE,
                ),
              ),
            if (model.iban != null)
              Text(
                "${getTranslated("iban")}: ${model.iban ?? ''}",
                textAlign: TextAlign.center,
                style: AppTextStyles.w600.copyWith(
                  fontSize: 14,
                  color: Styles.SUBTITLE,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
