import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:zurex_admin/app/core/app_state.dart';
import 'package:zurex_admin/app/core/text_styles.dart';
import 'package:zurex_admin/features/change_status/repo/change_status_repo.dart';
import 'package:zurex_admin/features/order_details/bloc/order_details_bloc.dart';
import 'package:zurex_admin/features/order_details/model/order_details_model.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../data/config/di.dart';
import '../bloc/change_status_bloc.dart';

class OrderDetailsActions extends StatelessWidget {
  const OrderDetailsActions(
      {super.key, required this.id, required this.status});

  final int id;
  final String status;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeStatusBloc(repo: sl<ChangeStatusRepo>()),
      child: BlocBuilder<ChangeStatusBloc, AppState>(
        builder: (context, state) {
          return Column(
            children: [
              if (status == OrderStatus.out_for_delivery.name)
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                      vertical: Dimensions.paddingSizeExtraSmall.w,
                    ),
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
                        getTranslated("delivered"),
                        style: AppTextStyles.w700.copyWith(
                          color: Styles.WHITE_COLOR,
                          fontSize: 16,
                        ),
                      ),
                      onSwipe: () {
                        context.read<ChangeStatusBloc>().add(
                              Click(
                                arguments: {
                                  "id": id,
                                  "status": OrderStatus.delivered.name,
                                  "onSuccess": (v) =>
                                      context.read<OrderDetailsBloc>().add(
                                            Update(arguments: v),
                                          )
                                },
                              ),
                            );
                      },
                    ).animate(onPlay: (c) {
                      c.repeat();
                    }).shimmer(
                        color: Colors.white.withOpacity(0.4),
                        duration: 1500.ms),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
