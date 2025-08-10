import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloo_lahma_admin/app/core/extensions.dart';
import 'package:aloo_lahma_admin/features/orders/bloc/orders_bloc.dart';
import 'package:aloo_lahma_admin/main_models/search_engine.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/app_state.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../data/config/di.dart';
import '../enums/order_main_status_enum.dart';

class OrderTabs extends StatelessWidget {
  const OrderTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, AppState>(
      builder: (context, state) {
        return StreamBuilder<OrderMainStatus>(
            stream: sl<OrdersBloc>().selectTabStream,
            builder: (context, snapshot) {
              return SizedBox(
                width: context.width,
                child: CupertinoSlidingSegmentedControl<OrderMainStatus>(
                  groupValue: snapshot.data,
                  onValueChanged: (v) {
                    if (state is! Loading && v != null) {
                      sl<OrdersBloc>().updateSelectTab(v);
                      sl<OrdersBloc>().add(Click(arguments: SearchEngine()));
                    }
                  },
                  thumbColor: Styles.PRIMARY_COLOR,
                  backgroundColor: Styles.PRIMARY_COLOR.withValues(alpha: 0.08),
                  children: Map.fromIterable(
                    OrderMainStatus.values,
                    key: (item) => item as OrderMainStatus,
                    value: (item) {
                      final isSelected =
                          (item as OrderMainStatus) == snapshot.data;
                      return _TabButton(
                        orderStatus: item,
                        isSelect: isSelected,
                      );
                    },
                  ),
                ),
              );
            });
      },
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({required this.orderStatus, this.isSelect = false});

  final OrderMainStatus orderStatus;
  final bool isSelect;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeMini.w,
          vertical: Dimensions.paddingSizeExtraSmall.h),
      child: Text(
        getTranslated(orderStatus.name),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: AppTextStyles.w600.copyWith(
            fontSize: 16, color: isSelect ? Styles.WHITE_COLOR : Styles.HEADER),
      ),
    );
  }
}
