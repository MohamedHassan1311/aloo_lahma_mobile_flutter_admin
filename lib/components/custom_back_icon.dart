import 'dart:io';
import 'package:flutter/material.dart';
import 'package:aloo_lahma_admin/app/core/dimensions.dart';
import '../app/core/styles.dart';
import '../data/config/di.dart';
import '../features/language/bloc/language_bloc.dart';
import '../navigation/custom_navigation.dart';

class CustomBackIcon extends StatelessWidget {
  const CustomBackIcon({super.key, this.onTap});
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: () => onTap?.call() ?? CustomNavigator.pop(),
      icon: Container(
        width: 50.w,
        height: 50.w,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
            border: Border.all(color: Styles.BORDER_COLOR),
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.w)),
        child: Transform.translate(
          offset: Platform.isIOS
              ? Offset(sl<LanguageBloc>().isLtr ? 3.w : -3.w, 0)
              : Offset(0, 0),
          child: Icon(
            Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            size: 22,
            color: Styles.HEADER,
          ),
        ),
      ),
    );
  }
}
