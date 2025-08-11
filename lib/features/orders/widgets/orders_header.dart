import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloo_lahma_admin/app/core/dimensions.dart';
import 'package:aloo_lahma_admin/app/core/extensions.dart';
import 'package:aloo_lahma_admin/features/orders/widgets/order_tabs.dart';
import '../../../app/core/app_state.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../data/config/di.dart';
import '../bloc/orders_bloc.dart';

class OrdersHeader extends StatefulWidget {
  const OrdersHeader({super.key});

  @override
  State<OrdersHeader> createState() => _OrdersHeaderState();
}

class _OrdersHeaderState extends State<OrdersHeader> {
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, AppState>(builder: (context, state) {
      return StreamBuilder(
        stream: sl<OrdersBloc>().goingDownStream,
        builder: (context, snapshot) {
          return AnimatedCrossFade(
            crossFadeState: snapshot.data == true
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 400),
            firstChild: SizedBox(width: context.width),
            secondChild: Padding(
              padding: EdgeInsets.only(
                left: Dimensions.PADDING_SIZE_DEFAULT.w,
                right: Dimensions.PADDING_SIZE_DEFAULT.w,
                top: Dimensions.PADDING_SIZE_DEFAULT.h,
                bottom: Dimensions.paddingSizeMini.h,
              ),
              child: Column(
                spacing: Dimensions.paddingSizeExtraSmall.h,
                children: [
                  OrderTabs(),
                  Row(
                    spacing: 8.w,
                    children: [
                      Expanded(
                        child: Text(
                          getTranslated("orders_number"),
                          style: AppTextStyles.w600
                              .copyWith(fontSize: 14, color: Styles.TITLE),
                        ),
                      ),
                      Text(
                        "(${context.read<OrdersBloc>().total ?? "..."}) ${getTranslated("order")}",
                        style: AppTextStyles.w700
                            .copyWith(fontSize: 16, color: Styles.HEADER),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
