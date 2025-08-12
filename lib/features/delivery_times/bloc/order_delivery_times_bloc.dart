import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_state.dart';
import '../../../../data/error/failures.dart';
import '../../../components/loading_dialog.dart';
import '../../../navigation/custom_navigation.dart';
import '../model/order_schedule_model.dart';
import '../repo/order_delivery_times_repo.dart';

class OrderDeliveryTimesBloc extends Bloc<AppEvent, AppState> {
  final OrderDeliveryTimesRepo repo;

  OrderDeliveryTimesBloc({required this.repo}) : super(Start()) {
    on<Click>(onClick);
  }

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    try {
      loadingDialog();
      emit(Loading());

      Either<ServerFailure, Response> response =
          await repo.getOrderDeliveryTimes(event.arguments);
      CustomNavigator.pop();

      response.fold((fail) {
        emit(Error(message: fail.error));
      }, (success) {
        if (success.data != null && success.data["data"] != null) {
          List<OrderScheduleModel> list = List<OrderScheduleModel>.from(
              success.data["data"].map((e) => OrderScheduleModel.fromJson(e)));
          if (list.isNotEmpty) {
            emit(Done(list: list, loading: false));
          } else {
            emit(Empty());
          }
        } else {
          emit(Empty());
        }
      });
    } catch (e) {
      CustomNavigator.pop();
      emit(Error());
    }
  }
}
