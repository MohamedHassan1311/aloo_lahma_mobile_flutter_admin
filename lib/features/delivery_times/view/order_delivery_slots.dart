import 'package:aloo_lahma_admin/app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/core/app_state.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/images.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../../../components/grid_list_animator.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../bloc/order_delivery_times_bloc.dart';
import '../model/order_schedule_model.dart';

class OrderDeliverySlots extends StatelessWidget {
  const OrderDeliverySlots({super.key, this.selectedSlot, this.onSelect});
  final OrderScheduleModel? selectedSlot;
  final Function(OrderScheduleModel)? onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: Dimensions.paddingSizeMini.h),
          child: Text(
            getTranslated("delivery_time"),
            style: AppTextStyles.w700.copyWith(
              fontSize: 14,
              color: Styles.HEADER,
            ),
          ),
        ),
        BlocBuilder<OrderDeliveryTimesBloc, AppState>(
          builder: (context, state) {
            if (state is Done) {
              List<OrderScheduleModel> list =
                  state.list as List<OrderScheduleModel>;
              return GridListAnimatorWidget(
                aspectRatio: 1,
                columnCount: 3,
                items: List.generate(
                  list.length,
                  (i) => _OrderScheduleCard(
                    model: list[i],
                    isSelected: list[i].id == selectedSlot?.id,
                    onSelect: (v) => onSelect?.call(v),
                  ),
                ),
              );
            }
            if (state is Loading) {
              return GridListAnimatorWidget(
                aspectRatio: 1,
                columnCount: 3,
                items: List.generate(
                    4,
                    (i) => CustomShimmerContainer(
                          height: 60.h,
                          width: context.width,
                          radius: 12.w,
                        )),
              );
            }
            if (state is Empty) {
              return Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                      vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                  margin: EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeMini.h),
                  decoration: BoxDecoration(
                      color: Styles.PENDING.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.w)),
                  child: Text(
                    getTranslated("there_is_no_available_delivery_times"),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.w500.copyWith(
                      fontSize: 18,
                      color: Styles.PENDING,
                    ),
                  ),
                ),
              );
            }
            if (state is Error) {
              return Center(
                child: Container(
                  width: context.width,
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                      vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                  margin: EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeMini.h),
                  decoration: BoxDecoration(
                      color: Styles.ERORR_COLOR.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.w)),
                  child: Text(
                    state.message ?? getTranslated("something_went_wrong"),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.w500.copyWith(
                      fontSize: 18,
                      color: Styles.ERORR_COLOR,
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                      vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                  margin: EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeMini.h),
                  decoration: BoxDecoration(
                      color: Styles.PRIMARY_COLOR.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.w)),
                  child: Text(
                    getTranslated("please_select_delivery_date"),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.w500.copyWith(
                      fontSize: 18,
                      color: Styles.PRIMARY_COLOR,
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class _OrderScheduleCard extends StatelessWidget {
  const _OrderScheduleCard(
      {required this.model, required this.isSelected, required this.onSelect});
  final OrderScheduleModel model;
  final bool isSelected;
  final Function(OrderScheduleModel) onSelect;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelect.call(model),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeMini.w,
            vertical: Dimensions.paddingSizeMini.h),
        decoration: BoxDecoration(
            border: Border.all(
              color: isSelected
                  ? Styles.PRIMARY_COLOR.withValues(alpha: 0.15)
                  : Styles.HINT_COLOR,
            ),
            color: isSelected
                ? Styles.PRIMARY_COLOR.withValues(alpha: 0.15)
                : Styles.WHITE_COLOR,
            borderRadius: BorderRadius.circular(12.w)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customImageIcon(imageName: Images.time, width: 18.w, height: 18.w),
            SizedBox(height: 4.h),
            Text(
              model.name ?? "",
              textAlign: TextAlign.center,
              style: AppTextStyles.w500.copyWith(
                fontSize: 14,
                color: Styles.HEADER,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
