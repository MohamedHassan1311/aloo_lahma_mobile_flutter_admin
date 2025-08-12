import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:aloo_lahma_admin/app/core/dimensions.dart';
import 'package:aloo_lahma_admin/app/core/extensions.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../app/core/styles.dart';
import '../app/core/text_styles.dart';

class CustomPinCodeField extends StatelessWidget {
  final void Function(String?)? onSave;
  final void Function(String)? onChanged;
  final void Function(String)? onCompleted;
  final TextEditingController? controller;
  final String? Function(String?)? validation;

  const CustomPinCodeField(
      {super.key,
      this.onSave,
      this.validation,
      this.onChanged,
      this.onCompleted,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      validator: validation,
      cursorColor: Styles.PRIMARY_COLOR,
      backgroundColor: Colors.transparent,
      autoDisposeControllers: false,
      autoDismissKeyboard: true,
      enableActiveFill: true,
      autoFocus: true,
      controller: controller,
      enablePinAutofill: true,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
      textStyle: AppTextStyles.w600.copyWith(
        color: Styles.HEADER,
      ),
      pastedTextStyle: AppTextStyles.w600.copyWith(color: Styles.HEADER),
      textInputAction: TextInputAction.done,
      pinTheme: PinTheme(
        borderWidth: 0.5,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
        fieldHeight: 70.h,
        fieldWidth: 70.w,
        fieldOuterPadding: EdgeInsets.symmetric(horizontal: 4.w),
        activeFillColor: Styles.FILL_COLOR,
        activeColor: Styles.PRIMARY_COLOR,
        inactiveColor: Styles.FILL_COLOR,
        inactiveFillColor: Styles.FILL_COLOR,
        selectedFillColor: Styles.FILL_COLOR,
        selectedColor: Styles.PRIMARY_COLOR,
        disabledColor: Styles.ERORR_COLOR,
        errorBorderColor: Styles.ERORR_COLOR,
      ),
      appContext: context,
      length: 4,
      onSaved: onSave,
      onChanged: (v) {
        onChanged?.call(v);
      },
      onCompleted: (v) {
        onCompleted?.call(v);
      },
      errorTextSpace: (context.width - (5 * 50.w)) / 4,
    );
  }
}
