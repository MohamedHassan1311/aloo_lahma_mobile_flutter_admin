import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../data/config/di.dart';
import '../../features/language/bloc/language_bloc.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  Color get toColor {
    String colorStr = this;
    colorStr = "FF$colorStr";
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw const FormatException(
            "An error occurred when converting a color");
      }
    }
    return Color(val);
  }

  String hiddenNumber() {
    return this[length - 2] + this[length - 1] + "*" * (length - 2);
  }
}

extension DateExtention on DateTime {
  String dateFormat({required String format, String? lang}) {
    return DateFormat(format, sl<LanguageBloc>().selectLocale!.languageCode)
        .format(this);
  }

  String arTimeFormat() {
    return DateFormat("hh,mm aa").format(this);
  }
}

extension DefaultFormat on DateTime {
  String defaultFormat() {
    return DateFormat("d MMM yyyy").format(this);
  }

  String defaultFormat2() {
    return DateFormat("d/M/yyyy").format(this);
  }
}

extension ConvertDigits on String {
  String convertDigits() {
    const english = [
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
    ];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    String result = this;
    for (int i = 0; i < arabic.length; i++) {
      result = result.replaceAll(arabic[i], english[i]);
    }
    return result;
  }
}

extension MediaQueryValues on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  double get toPadding => MediaQuery.of(this).viewPadding.top;

  double get bottom => MediaQuery.of(this).viewInsets.bottom;
}
