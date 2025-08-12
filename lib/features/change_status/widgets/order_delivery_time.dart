import 'package:aloo_lahma_admin/app/core/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../app/core/app_core.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/validation.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_bottom_sheet.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../data/config/di.dart';
import '../../../helpers/date_time_picker.dart';
import '../../setting/bloc/settings_bloc.dart';


class OrderDeliveryTime extends StatelessWidget {
  const OrderDeliveryTime({super.key, this.deliveryDate, this.receiptTime, this.onSelect});
  final DateTime? deliveryDate;
  final DateTime? receiptTime;
  final Function(DateTime)? onSelect;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      fillColor: Styles.SMOKED_WHITE_COLOR,
      isFillColor: true,
      onTap: () {
        if (deliveryDate != null) {
          CustomBottomSheet.general(
            widget: DateTimePicker(
              mode: CupertinoDatePickerMode.time,
              startDateTime: receiptTime ?? DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      (DateTime.now().hour +
                          (sl<SettingsBloc>().model?.hoursBeforeOrder ??
                              3))),
              minDateTime: DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                (DateTime.now().hour + (sl<SettingsBloc>().model?.hoursBeforeOrder ?? 3)),
              ),
              valueChanged: (v) =>onSelect?.call(v),
              label: getTranslated("delivery_date"),
            ),
          );
        } else {
          AppCore.showToast(
              getTranslated("you_have_to_select_delivery_date_first"));
        }
      },
      readOnly: true,
      controller: TextEditingController(text: receiptTime?.dateFormat(format: "hh:mm a")),
      label: getTranslated("delivery_time"),
      hint: getTranslated("select_delivery_time"),
      validate: (v) => Validations.field(receiptTime?.dateFormat(format: "hh:mm a"),
          fieldName: getTranslated("select_delivery_time")),
      pSvgIcon: SvgImages.clock,
      sufWidget: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        child: Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 24,
          color: Styles.HINT_COLOR,
        ),
      ),
    );
  }
}
