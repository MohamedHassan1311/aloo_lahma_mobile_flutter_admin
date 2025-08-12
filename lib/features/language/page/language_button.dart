import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/core/app_event.dart';
import '../../../app/core/app_state.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../data/config/di.dart';
import '../../../main_models/search_engine.dart';
import '../../language/bloc/language_bloc.dart';
import '../../orders/bloc/orders_bloc.dart';

class LanguageButton extends StatefulWidget {
  final bool fromWelcome;
  const LanguageButton({super.key, this.fromWelcome = false});

  @override
  State<LanguageButton> createState() => _LanguageButtonState();
}

class _LanguageButtonState extends State<LanguageButton> {
  @override
  void initState() {
    LanguageBloc.instance.add(Init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, AppState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeMini.h),
          padding: EdgeInsets.symmetric(
              vertical: Dimensions.paddingSizeExtraSmall.h,
              horizontal: Dimensions.PADDING_SIZE_SMALL.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.w),
              color: Styles.WHITE_COLOR,
              border: Border.all(color: Styles.LIGHT_BORDER_COLOR)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: Dimensions.PADDING_SIZE_SMALL.w,
            children: [
              customContainerSvgIcon(
                imageName: SvgImages.language,
                padding: 8.w,
                radius: 12.w,
                height: 40.w,
                width: 40.w,
                borderColor: Styles.LIGHT_BORDER_COLOR,
                backGround: Styles.WHITE_COLOR,
                color: Styles.PRIMARY_COLOR,
              ),
              Expanded(
                child: Text(getTranslated("language", context: context),
                    maxLines: 1,
                    style: AppTextStyles.w700.copyWith(
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        color: Styles.HEADER)),
              ),

              ///Toggle Buttons
              StreamBuilder<int>(
                  stream: LanguageBloc.instance.selectIndexStream,
                  builder: (context, snapshot) {
                    return ToggleButtons(
                      direction: Axis.horizontal,
                      isSelected: [
                        (snapshot.data ?? 0) == 0,
                        (snapshot.data ?? 0) == 1,
                      ],
                      onPressed: (index) {
                        LanguageBloc.instance.updateSelectIndex(index);
                        LanguageBloc.instance.add(Update());
                        sl<OrdersBloc>().add(Click(arguments: SearchEngine()));
                      },
                      borderRadius: BorderRadius.circular(8.w),
                      selectedBorderColor: Styles.PRIMARY_COLOR,
                      selectedColor: Styles.WHITE_COLOR,
                      fillColor: Styles.PRIMARY_COLOR,
                      color: Styles.PRIMARY_COLOR,
                      borderColor: Styles.PRIMARY_COLOR,
                      constraints: BoxConstraints(
                        minHeight: 30.w,
                        minWidth: 40.w,
                      ),
                      children: [
                        Text(
                          "En",
                          style: AppTextStyles.w400.copyWith(fontSize: 14),
                        ),
                        Text(
                          "ع",
                          style: AppTextStyles.w400.copyWith(fontSize: 14),
                        ),
                      ],
                    );
                  }),
            ],
          ),
        );
      },
    );
  }
}
