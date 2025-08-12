import 'package:flutter/material.dart';

import '../../../app/localization/language_constant.dart';
import '../../../components/custom_text_form_field.dart';

class OrderCancelledReason extends StatelessWidget {
  const OrderCancelledReason({super.key, this.controller, this.validate});
  final TextEditingController? controller;
  final String? Function(String?)? validate;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      label: getTranslated("cancel_reason"),
      hint: getTranslated("enter_cancel_reason"),
      focusNode: FocusNode(),
      inputType: TextInputType.text,
      keyboardAction: TextInputAction.done,
      maxLines: 4,
      minLines: 4,
      validate: validate,
    );
  }
}
