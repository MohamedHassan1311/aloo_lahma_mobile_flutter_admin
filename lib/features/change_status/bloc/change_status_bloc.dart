import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloo_lahma_admin/components/loading_dialog.dart';
import 'package:aloo_lahma_admin/features/order_details/model/order_details_model.dart';
import 'package:aloo_lahma_admin/main_models/search_engine.dart';
import 'package:aloo_lahma_admin/navigation/custom_navigation.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../app/core/app_core.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_state.dart';
import '../../../../data/error/failures.dart';
import '../../../app/localization/language_constant.dart';
import '../../../data/config/di.dart';
import '../../order_details/enums/order_details_enums.dart';
import '../../orders/bloc/orders_bloc.dart';
import '../../setting/bloc/settings_bloc.dart';
import '../../setting/model/setting_model.dart';
import '../entity/change_status_entity.dart';
import '../repo/change_status_repo.dart';

class ChangeStatusBloc extends Bloc<AppEvent, AppState> {
  final ChangeStatusRepo repo;

  ChangeStatusBloc({required this.repo}) : super(Start()) {
    on<Init>(onInit);
    on<Click>(onClick);
  }

  final formKey = GlobalKey<FormState>();

  String? get userType => repo.userType;

  final changeStatusEntity = BehaviorSubject<ChangeStatusEntity?>();
  Function(ChangeStatusEntity?) get updateChangeStatusEntity =>
      changeStatusEntity.sink.add;
  Stream<ChangeStatusEntity?> get changeStatusEntityStream =>
      changeStatusEntity.stream.asBroadcastStream();

  @override
  close() async {
    changeStatusEntity.close();
    super.close();
  }

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    if (!formKey.currentState!.validate()) return;
    try {
      if (changeStatusEntity.valueOrNull?.receiptType ==
              ReceiptTypes.delivery &&
          changeStatusEntity.valueOrNull?.status?.statusCode ==
              OrderStatuses.deferred &&
          changeStatusEntity.valueOrNull?.deliveryTime == null) {
        return AppCore.showToast(
            getTranslated("you_have_to_select_delivery_time_first"));
      }

      emit(Loading());
      loadingDialog();
      Either<ServerFailure, Response> response =
          await repo.changeStatus(changeStatusEntity.valueOrNull!.toJson());

      CustomNavigator.pop();

      response.fold((fail) {
        AppCore.showToast(fail.error);
        emit(Error());
      }, (success) {
        OrderDetailsModel model =
            OrderDetailsModel.fromJson(success.data["data"]);

        (event.arguments as Function(OrderDetailsModel)).call(model);

        sl<OrdersBloc>().add(Click(arguments: SearchEngine(isUpdate: true)));

        AppCore.showToast(getTranslated("your_order_updated_successfully"));
        emit(Done());
      });
    } catch (e) {
      AppCore.showToast(e.toString());
      CustomNavigator.pop();
      emit(Error());
    }
  }

  bool isReceiptTimeValid({
    required DateTime selectedDate,
    required DateTime
        selectedTime, // expects a DateTime whose hour/minute are the desired time
  }) {
    final SettingModel? setting = sl<SettingsBloc>().model;

    final int hoursBeforeOrder = setting?.hoursBeforeOrder ?? 1;
    final String startTimeStr = setting?.startTime ?? "9:00:00 AM";
    final String endTimeStr = setting?.endTime ?? "8:59:00 PM";

    final now = DateTime.now();

    // Combine the selectedDate's date with the selectedTime's hour/minute
    final receiptDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
      selectedTime.second,
    );

    // Parse store business hours and combine with selected date

    DateTime combineDateWithTimeString(DateTime date, String timeString) {
      final parsedTime = DateFormat('h:mm:ss a').parse(timeString);
      return DateTime(
        date.year,
        date.month,
        date.day,
        parsedTime.hour,
        parsedTime.minute,
        parsedTime.second,
      );
    }

    final startDateTime = combineDateWithTimeString(selectedDate, startTimeStr);
    final endDateTime = combineDateWithTimeString(selectedDate, endTimeStr);

    // Check business hours first
    if (receiptDateTime.isBefore(startDateTime) ||
        receiptDateTime.isAfter(endDateTime)) {
      AppCore.showToast(
        getTranslated(
            "you_have_to_select_delivery_time_within_store_business_hours"),
      );
      return false;
    }

    // Then check minimum lead time
    final earliestAllowed = now.add(Duration(hours: hoursBeforeOrder));
    log("earliestAllowed $earliestAllowed");
    log("receiptDateTime $receiptDateTime");
    log("isValid ${receiptDateTime.isBefore(earliestAllowed)}");
    // if (receiptDateTime.isBefore(earliestAllowed)) {
    //   AppCore.showToast(
    //     "${getTranslated("you_have_to_select_delivery_time_after_at_least")} "
    //     "$hoursBeforeOrder ${getTranslated("hours")}",
    //   );
    //   return false;
    // }

    return true;
  }

  Future<void> onInit(Init event, Emitter<AppState> emit) async {
    OrderDetailsModel order = event.arguments as OrderDetailsModel;
    updateChangeStatusEntity(
      ChangeStatusEntity(
          id: order.id,
          receiptType: order.deliveryType,
          address: order.address,
          cancelReason: TextEditingController()),
    );
    emit(Start());
  }
}
