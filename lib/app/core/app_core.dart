import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:toastification/toastification.dart';
import 'package:zurex_admin/app/core/dimensions.dart';
import 'package:zurex_admin/app/core/extensions.dart';
import 'package:zurex_admin/app/core/svg_images.dart';
import 'package:zurex_admin/app/core/text_styles.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zurex_admin/components/custom_images.dart';
import '../../../navigation/custom_navigation.dart';
import '../../data/config/di.dart';
import '../../features/language/bloc/language_bloc.dart';
import '../localization/language_constant.dart';
import 'app_notification.dart';
import 'styles.dart';

class AppCore {
  static showSnackBar({required AppNotification notification}) {
    if (notification.message.isNotEmpty) {
      toastification.show(
        type: ToastificationType.success,
        style: ToastificationStyle.minimal,
        autoCloseDuration: const Duration(seconds: 5),
        title: Text(
          notification.message,
          style: AppTextStyles.w900.copyWith(fontSize: 18, color: Styles.BLACK),
        ),
        // you can also use RichText widget for title and description parameters
        description: RichText(
            text: TextSpan(
          text: notification.message,
          style: AppTextStyles.w400
              .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
        )),
        alignment: sl<LanguageBloc>().selectLocale?.languageCode == "ar"
            ? Alignment.topRight
            : Alignment.topLeft,
        direction: sl<LanguageBloc>().selectLocale?.languageCode == "ar"
            ? TextDirection.rtl
            : TextDirection.ltr,
        animationDuration: const Duration(milliseconds: 300),
        animationBuilder: (context, animation, alignment, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        showIcon: true,
        // show or hide the icon
        primaryColor: Styles.PRIMARY_COLOR,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x07000000),
            blurRadius: 16,
            offset: Offset(0, 16),
            spreadRadius: 0,
          )
        ],
        showProgressBar: true,
        closeOnClick: false,
        pauseOnHover: true,
        dragToClose: true,
        // applyBlurEffect: true,
        callbacks: ToastificationCallbacks(
          onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
          onCloseButtonTap: (toastItem) =>
              print('Toast ${toastItem.id} close button tapped'),
          onAutoCompleteCompleted: (toastItem) =>
              print('Toast ${toastItem.id} auto complete completed'),
          onDismissed: (toastItem) => print('Toast ${toastItem.id} dismissed'),
        ),
      );
    }
    /* Timer(Duration.zero, () {
      CustomNavigator.scaffoldState.currentState!.showSnackBar(
        SnackBar(
          padding: const EdgeInsets.all(0),
          duration: const Duration(seconds: 2),
          behavior: notification.isFloating
              ? SnackBarBehavior.floating
              : SnackBarBehavior.fixed,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(notification.radius),
              side: BorderSide(width: 1, color: notification.borderColor)),
          margin: notification.isFloating ? EdgeInsets.all(24.w) : null,
          onVisible: notification.onVisible,
          content: SizedBox(
            height: notification.withAction ? null : 60.h,
            child: Row(
              children: [
                if (notification.iconName != null)
                  Image.asset(
                    notification.iconName!,
                    height: 20.h,
                    width: 20.w,
                  ),
                if (notification.iconName == null) SizedBox(width: 24.w),
                Expanded(
                  child: Text(
                    notification.message,
                    style: AppTextStyles.w600.copyWith(fontSize: 13),
                  ),
                ),
                if (notification.withAction)
                  notification.action ?? const SizedBox(),
              ],
            ),
          ),
          backgroundColor: notification.backgroundColor,
        ),
      );
    });*/
  }

  static hideSnackBar() {
    CustomNavigator.scaffoldState.currentState!
        .hideCurrentSnackBar(reason: SnackBarClosedReason.remove);
  }

  static Future<String> getAppFilePath() async {
    String? path;
    if (Platform.isAndroid) {
      // path =
      //     '${await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)}/DarElteb';
    } else {
      Directory documents = await getApplicationDocumentsDirectory();
      path = '${documents.path}/DarElteb';
    }

    return path ?? "";
  }

  static String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  static showToast(msg,
      {Color? backGroundColor, Color? textColor, Toast? toastLength}) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: backGroundColor ?? Colors.black.withOpacity(0.5),
        textColor: textColor ?? Styles.WHITE_COLOR,
        fontSize: 16.0);
  }

  successMotionToast(msg,
      {Alignment? position, AnimationType? animationType}) {
    return MotionToast.success(
      title: Text(
        getTranslated("success"),
        style: AppTextStyles.w600.copyWith(fontSize: 13, color: Styles.ACTIVE),
      ),
      description: Text(
        msg,
        style: AppTextStyles.w400.copyWith(fontSize: 11, color: Styles.ACTIVE),
      ),
      height: 70.h,
      width: CustomNavigator.navigatorState.currentContext!.width - 60.w,
      layoutOrientation: TextDirection.ltr,
      animationType: animationType ?? AnimationType.slideInFromTop,
      toastAlignment: position ?? Alignment.topCenter,
    ).show(CustomNavigator.navigatorState.currentContext!);
  }

  errorMotionToast(msg,
      {Alignment? position, AnimationType? animationType}) {
    return MotionToast.error(
      title: Text(
        getTranslated("error"),
        style:
            AppTextStyles.w600.copyWith(fontSize: 13, color: Styles.IN_ACTIVE),
      ),
      description: Text(
        msg,
        style:
            AppTextStyles.w400.copyWith(fontSize: 11, color: Styles.IN_ACTIVE),
      ),
      height: 70.h,
      width: CustomNavigator.navigatorState.currentContext!.width - 60.w,
      layoutOrientation: TextDirection.ltr,
      animationType: animationType ?? AnimationType.slideInFromTop,
      toastAlignment: position ?? Alignment.topCenter,
    ).show(CustomNavigator.navigatorState.currentContext!);
  }

  static bool scrollListener(
      ScrollController controller, int maxPage, int currentPage) {
    double maxScroll = controller.position.maxScrollExtent;
    double currentScroll = controller.position.pixels;
    if (maxScroll == currentScroll && maxScroll != 0.0) {
      log(">>>>>>>>>>>>>>> get into equal scroll");
      log('$maxScroll   $currentScroll');
      if (currentPage < maxPage) {
        log(">>>>>>>>>>>>>>> get into equal scroll True");
        return true;
      } else {
        log(">>>>>>>>>>>>>>> get into equal scroll false");
        return false;
      }
    }
    return false;
  }

  static shareDetails({String? details}) async {
    await Share.share(
      '${dotenv.env['DOMAIN'] ?? ""}$details',
    );
  }

  static saudiRiyalSymbol({Color? color, double? size}) => customImageIconSVG(
      imageName: SvgImages.saudiRiyalSymbol,
      width: size ?? 20.w,
      height: size ?? 20.w,
      color: color);
}
