import 'package:aloo_lahma_admin/app/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/core/app_event.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_bottom_sheet.dart';
import '../../../components/custom_button.dart';
import '../../change_status/view/change_order_status_view.dart';
import '../../change_status/widgets/driver_order_action.dart';
import '../../profile/enums/user_types_enum.dart';
import '../bloc/order_details_bloc.dart';
import '../enums/order_details_enums.dart';
import '../model/order_details_model.dart';

class OrderDetailsActions extends StatelessWidget {
  const OrderDetailsActions({super.key, required this.model});
  final OrderDetailsModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Order Actions
        if (context.read<OrderDetailsBloc>().userType == UserType.admin.name &&
            model.availableStatus != null &&
            model.availableStatus!.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
              vertical: Dimensions.paddingSizeExtraSmall.h,
            ),
            child: CustomButton(
              text: getTranslated("change_order_status"),
              onTap: () => CustomBottomSheet.show(
                  height: context.height * 0.7,
                  label: getTranslated("change_order_status"),
                  widget: ChangeOrderStatusView(
                    model: model,
                    onSuccess: (v) => context
                        .read<OrderDetailsBloc>()
                        .add(Click(arguments: model.id)),
                  )),
            ),
          ),

        ///Driver Action
        if (context.read<OrderDetailsBloc>().userType == UserType.driver.name &&
            model.currentStatus == OrderStatuses.outForDelivery)
          DriverOrderAction(
            model: model,
            onSuccess: (v) =>
                context.read<OrderDetailsBloc>().add(Update(arguments: model.id)),
          ),
      ],
    );
  }
}
