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
import '../../../data/config/di.dart';
import '../../order_details/enums/order_details_enums.dart';
import '../../order_details/model/order_details_model.dart';
import '../../order_details/model/order_status_model.dart';
import '../bloc/change_status_bloc.dart';
import '../repo/change_status_repo.dart';

class DriverOrderAction extends StatelessWidget {
  const DriverOrderAction(
      {super.key, required this.model, required this.onSuccess});
  final OrderDetailsModel model;
  final Function(OrderDetailsModel) onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeStatusBloc(repo: sl<ChangeStatusRepo>())
        ..add(Init(arguments: model)),
      child: BlocBuilder<ChangeStatusBloc, AppState>(builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
              vertical: Dimensions.paddingSizeExtraSmall.h),
          child: SwipeButton(
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
            onSwipe: () {
              context
                  .read<ChangeStatusBloc>()
                  .changeStatusEntity
                  .valueOrNull
                  ?.copyWith(
                      status: OrderStatusModel(
                    statusCode: OrderStatuses.completed,
                    status: getTranslated("completed"),
                    value: 5,
                  ));
              context.read<ChangeStatusBloc>().add(Click(arguments: onSuccess));
            },
          ).animate(onPlay: (c) {
            c.repeat();
          }).shimmer(
              color: Colors.white.withValues(alpha: 0.4), duration: 1500.ms),
        );
      }),
    );
  }
}
