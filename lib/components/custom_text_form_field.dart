import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aloo_lahma_admin/app/core/dimensions.dart';
import 'package:aloo_lahma_admin/app/core/extensions.dart';
import 'package:aloo_lahma_admin/app/core/text_styles.dart';
import '../app/core/styles.dart';
import '../app/core/svg_images.dart';
import 'custom_images.dart';

class CustomTextField extends StatefulWidget {
  final TextInputAction keyboardAction;
  final Color? iconColor;
  final TextInputType? inputType;
  final String? hint;
  final String? label;
  final double labelSpace;
  final void Function(String)? onChanged;
  final bool isPassword;
  final void Function(String)? onSubmit;
  final FocusNode? focusNode, nextFocus;
  final FormFieldValidator<String>? validate;
  final int? maxLines;
  final int? minLines;
  final TextEditingController? controller;
  final bool keyboardPadding;
  final bool withLabel;
  final bool readOnly;
  final int? maxLength;
  final bool obscureText;
  final bool? autoFocus;
  final bool? alignLabel;
  final String? errorText;
  final String? initialValue;
  final bool isEnabled;
  final bool? alignLabelWithHint;
  final bool withPadding;
  final GestureTapCallback? onTap;
  final Color? onlyBorderColor;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? formattedType;
  final Function(dynamic)? onTapOutside;
  final double? height;
  final String? sufSvgIcon, sufAssetIcon;
  final String? pAssetIcon, pSvgIcon;
  final Color? pIconColor, sIconColor;
  final Widget? prefixWidget, sufWidget;
  final bool isFillColor;
  final Color? fillColor;
  final double? borderRadius;
  const CustomTextField({
    super.key,
    this.height,
    this.sufSvgIcon,
    this.autofillHints,
    this.borderRadius,
    this.sufAssetIcon,
    this.pAssetIcon,
    this.pSvgIcon,
    this.pIconColor,
    this.sIconColor,
    this.sufWidget,
    this.prefixWidget,
    this.keyboardAction = TextInputAction.next,
    this.inputType,
    this.hint,
    this.alignLabelWithHint = false,
    this.isFillColor = false,
    this.onChanged,
    this.validate,
    this.obscureText = false,
    this.isPassword = false,
    this.readOnly = false,
    this.labelSpace = 8,
    this.maxLines = 1,
    this.minLines = 1,
    this.isEnabled = true,
    this.withPadding = true,
    this.alignLabel = false,
    this.controller,
    this.errorText,
    this.maxLength,
    this.formattedType,
    this.focusNode,
    this.nextFocus,
    this.iconColor,
    this.keyboardPadding = false,
    this.autoFocus,
    this.initialValue,
    this.onSubmit,
    this.onlyBorderColor,
    this.withLabel = true,
    this.label,
    this.onTap,
    this.onTapOutside,
    this.fillColor,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isHidden = true;
  bool _isFocus = false;

  late InputBorder _borders;
  @override
  void initState() {
    _borders = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.w),
      borderSide: const BorderSide(
        style: BorderStyle.solid,
        color: Styles.BORDER_COLOR,
        width: 1,
      ),
    );
    widget.focusNode?.addListener(() {
      _onFocus();
    });
    super.initState();
  }

  void _visibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  _onFocus() {
    if (!mounted) return;
    setState(() {
      _isFocus = widget.focusNode?.hasFocus == true;
    });
  }

  activationColor() {
    return widget.errorText != null
        ? Styles.ERORR_COLOR
        : _isFocus
            ? Styles.PRIMARY_COLOR
            : Styles.HINT_COLOR;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.withPadding ? 8.h : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null && widget.label != null)
            Text(
              widget.label ?? "",
              style: AppTextStyles.w700.copyWith(
                fontSize: 14,
                color: Styles.HEADER,
              ),
            ),
          if (widget.withLabel && widget.label != null)
            SizedBox(height: widget.labelSpace.h),
          SizedBox(
            height: widget.height,
            child: GestureDetector(
              onTap: widget.onTap,
              child: TextFormField(
                autofillHints: widget.autofillHints,
                focusNode: widget.focusNode,
                initialValue: widget.initialValue,
                textInputAction: widget.keyboardAction,
                textAlignVertical: TextAlignVertical.bottom,
                onTap: widget.onTap,
                autofocus: widget.autoFocus ?? false,
                maxLength: widget.maxLength,
                onFieldSubmitted: (v) {
                  widget.onSubmit?.call(v);
                  if (widget.nextFocus != null) {
                    FocusScope.of(context).requestFocus(widget.nextFocus);
                  } else {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
                onEditingComplete: () {
                  if (widget.nextFocus != null) {
                    FocusScope.of(context).requestFocus(widget.nextFocus);
                  } else {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
                enabled: widget.isEnabled,
                readOnly: widget.readOnly,
                obscureText:
                    widget.isPassword == true ? _isHidden : widget.obscureText,
                controller: widget.controller,
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                validator: (v) {
                  return widget.validate?.call(v);
                },
                keyboardType: widget.inputType,
                onChanged: widget.onChanged,
                inputFormatters: widget.inputType == TextInputType.phone
                    ? [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        LengthLimitingTextInputFormatter(9),
                      ]
                    : widget.formattedType ?? [],
                onTapOutside: (v) {
                  widget.onTapOutside?.call(v);
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                style: AppTextStyles.w600.copyWith(
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                  color: Styles.HEADER,
                ),
                scrollPhysics: const BouncingScrollPhysics(),
                scrollPadding: EdgeInsets.only(
                    bottom: widget.keyboardPadding ? context.bottom : 0.0),
                decoration: InputDecoration(
                  isDense: true,
                  counterText: "",
                  counterStyle: AppTextStyles.w400
                      .copyWith(fontSize: 12, color: Styles.HINT_COLOR),
                  prefixIcon: (widget.pAssetIcon != null ||
                          widget.pSvgIcon != null ||
                          widget.prefixWidget != null)
                      ? Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: 16.w, end: 12.h),
                          child: widget.prefixWidget ??
                              (widget.pAssetIcon != null
                                  ? Image.asset(
                                      widget.pAssetIcon!,
                                      height: 20.w,
                                      width: 20.w,
                                      color: widget.pIconColor ??
                                          activationColor(),
                                    )
                                  : widget.pSvgIcon != null
                                      ? customImageIconSVG(
                                          imageName: widget.pSvgIcon!,
                                          color: widget.pIconColor ??
                                              activationColor(),
                                          height: 20.w,
                                          width: 20.w,
                                        )
                                      : const SizedBox()),
                        )
                      : null,
                  suffixIcon: widget.sufWidget ??
                      (widget.sufAssetIcon != null
                          ? Padding(
                              padding: EdgeInsetsDirectional.only(
                                  end: 16.w, start: 12.w),
                              child: Image.asset(
                                widget.sufAssetIcon!,
                                height: 22.h,
                                color: widget.sIconColor ?? activationColor(),
                              ),
                            )
                          : widget.sufSvgIcon != null
                              ? Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: 16.w, end: 12.w),
                                  child: customImageIconSVG(
                                    imageName: widget.sufSvgIcon!,
                                    color:
                                        widget.sIconColor ?? activationColor(),
                                    height: 16.h,
                                  ),
                                )
                              : widget.isPassword == true
                                  ? IconButton(
                                      padding: EdgeInsetsDirectional.only(
                                          start: 16.w, end: 12.w),
                                      onPressed: _visibility,
                                      alignment: Alignment.center,
                                      icon: customImageIconSVG(
                                        imageName: _isHidden
                                            ? SvgImages.hiddenEyeIcon
                                            : SvgImages.eyeIcon,
                                        height: 17.h,
                                        width: 20.w,
                                        color: _isHidden
                                            ? const Color(0xFF8B97A3)
                                            : Styles.PRIMARY_COLOR,
                                      ))
                                  : null),
                  enabled: widget.isEnabled,
                  // labelText: widget.label,
                  hintText: widget.hint ?? '',
                  alignLabelWithHint:
                      widget.alignLabelWithHint ?? widget.alignLabel,
                  disabledBorder: _borders,
                  focusedBorder: _borders.copyWith(
                      borderSide: const BorderSide(
                    width: 1,
                    color: Styles.PRIMARY_COLOR,
                  )),
                  errorBorder: _borders.copyWith(
                      borderSide: const BorderSide(
                    width: 1,
                    color: Styles.ERORR_COLOR,
                  )),
                  enabledBorder: _borders,
                  border: _borders,
                  filled: true,
                  fillColor: widget.isFillColor
                      ? (widget.fillColor ?? Styles.FILL_COLOR)
                      : Colors.white,
                  errorMaxLines: 1,
                  errorText: widget.errorText,
                  errorStyle: AppTextStyles.w600.copyWith(
                    color: Styles.ERORR_COLOR,
                    fontSize: 14,
                  ),
                  labelStyle: const TextStyle(
                      color: Styles.PRIMARY_COLOR,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                  floatingLabelStyle: AppTextStyles.w600
                      .copyWith(color: Styles.PRIMARY_COLOR, fontSize: 16),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintStyle: AppTextStyles.w400.copyWith(
                    color: Styles.HINT_COLOR,
                    fontSize: 14,
                  ),
                  prefixIconConstraints:
                      BoxConstraints(maxHeight: 43.h, maxWidth: 60.w),
                  suffixIconConstraints:
                      BoxConstraints(maxHeight: 43.h, maxWidth: 101.w),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_SMALL.h,
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
