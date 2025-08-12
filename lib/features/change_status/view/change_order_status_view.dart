import 'package:aloo_lahma_admin/features/change_status/widgets/order_schedule.dart';
import 'package:aloo_lahma_admin/features/drivers/view/drivers_selection.dart';
import 'package:aloo_lahma_admin/features/order_details/model/order_details_model.dart';
import 'package:aloo_lahma_admin/features/profile/enums/user_types_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloo_lahma_admin/app/core/app_state.dart';
import 'package:aloo_lahma_admin/features/change_status/repo/change_status_repo.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/dimensions.dart';
import '../../../components/animated_widget.dart';
import '../../../data/config/di.dart';
import '../../order_details/enums/order_details_enums.dart';
import '../bloc/change_status_bloc.dart';
import '../entity/change_status_entity.dart';
import '../widgets/driver_order_action.dart';
import '../widgets/order_status_selection_input.dart';

class ChangeOrderStatusView extends StatelessWidget {
  const ChangeOrderStatusView({super.key, required this.model});

  final OrderDetailsModel model;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BlocProvider(
        create: (context) => ChangeStatusBloc(repo: sl<ChangeStatusRepo>())..add(Init(arguments: model)),
        child: BlocBuilder<ChangeStatusBloc, AppState>(
          builder: (context, state) {
            return StreamBuilder<ChangeStatusEntity?>(
                stream:
                context.read<ChangeStatusBloc>().changeStatusEntityStream,
                builder: (context, snapshot) {
                  return Form(
                    key: context.read<ChangeStatusBloc>().formKey,
                    child: ListAnimator(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                      ),
                      data: [
                        ///Driver Action
                        if (context.read<ChangeStatusBloc>().userType == UserType.driver.name &&
                            model.statusCode == OrderStatuses.outForDelivery)
                          DriverOrderAction(),

                        ///Driver Actions
                        if (context.read<ChangeStatusBloc>().userType == UserType.admin.name) ...[
                          ///Order Status
                          OrderStatusSelectionInput(
                            initialValue: snapshot.data?.status,
                            availableStatus: model.availableStatus??[],
                            onConfirm: (v) => context
                                .read<ChangeStatusBloc>()
                                .updateChangeStatusEntity(
                                    snapshot.data?.copyWith(status: v)),
                          ),


                          if (snapshot.data?.status?.statusCode == OrderStatuses.outForDelivery)
                            DriversSelection(
                              initialSelection: snapshot.data?.driver,
                              onSelect: (v) => context
                                  .read<ChangeStatusBloc>()
                                  .updateChangeStatusEntity(
                                      snapshot.data?.copyWith(driver: v)),
                            ),


                          if (snapshot.data?.status?.statusCode == OrderStatuses.deferred)
                            OrderSchedule(),
                        ]
                      ],
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
