import 'package:aloo_lahma_admin/app/core/dimensions.dart';
import 'package:aloo_lahma_admin/features/order_details/model/order_status_model.dart';
import 'package:flutter/material.dart';

import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/validation.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_bottom_sheet.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../navigation/custom_navigation.dart';
import 'order_status_selection_view.dart';

class OrderStatusSelectionInput extends StatelessWidget {
  const OrderStatusSelectionInput(
      {super.key,
      this.initialValue,
      required this.onConfirm,
      required this.availableStatus});
  final OrderStatusModel? initialValue;
  final Function(OrderStatusModel) onConfirm;
  final List<OrderStatusModel> availableStatus;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      readOnly: true,
      onTap: () => CustomBottomSheet.show(
          label: getTranslated("select_order_status"),
          widget: OrderStatusSelectionView(
            initialValue: initialValue,
            onConfirm: onConfirm,
            list: availableStatus,
          ),
          onConfirm: () => CustomNavigator.pop()),
      controller: TextEditingController(text: initialValue?.status),
      label: getTranslated("order_status"),
      hint: getTranslated("select_order_status"),
      pSvgIcon: SvgImages.status,
      validate: (v) => Validations.field(initialValue?.statusCode?.name,
          fieldName: getTranslated("order_status")),
      sufWidget: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        child: Icon(
          Icons.keyboard_arrow_down_outlined,
          color: Styles.DETAILS_COLOR,
          size: 24,
        ),
      ),
    );
  }
}
