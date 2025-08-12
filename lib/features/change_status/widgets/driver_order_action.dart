import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';

import '../../../app/core/app_event.dart';
import '../../../app/core/app_state.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../bloc/change_status_bloc.dart';

class DriverOrderAction extends StatelessWidget {
  const DriverOrderAction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangeStatusBloc, AppState>(builder: (context, state) {
      return SwipeButton(
        thumbPadding: EdgeInsets.all(4.w),
        borderRadius: BorderRadius.circular(12.w),
        thumb: Icon(
          Icons.arrow_forward,
          color: Styles.PRIMARY_COLOR,
          size: 24,
        ),
        activeTrackColor: Styles.PRIMARY_COLOR,
        activeThumbColor: Styles.WHITE_COLOR,
        inactiveThumbColor: Styles.WHITE_COLOR,
        inactiveTrackColor: Styles.GREEN,
        enabled: state is! Loading && state is! Done,
        elevationThumb: 2,
        elevationTrack: 2,
        height: 60,
        child: Text(
          getTranslated("completed"),
          style: AppTextStyles.w700.copyWith(
            color: Styles.WHITE_COLOR,
            fontSize: 16,
          ),
        ),
        onSwipe: () => context.read<ChangeStatusBloc>().add(Click()),
      ).animate(onPlay: (c) {
        c.repeat();
      }).shimmer(
          color: Colors.white.withValues(alpha: 0.4), duration: 1500.ms);
    });
  }
}
