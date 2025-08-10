import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloo_lahma_admin/components/loading_dialog.dart';
import 'package:aloo_lahma_admin/features/order_details/model/order_details_model.dart';
import 'package:aloo_lahma_admin/main_models/search_engine.dart';
import 'package:aloo_lahma_admin/navigation/custom_navigation.dart';
import '../../../../app/core/app_core.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_state.dart';
import '../../../../data/error/failures.dart';
import '../../../app/localization/language_constant.dart';
import '../../../data/config/di.dart';
import '../../orders/bloc/orders_bloc.dart';
import '../repo/change_status_repo.dart';

class ChangeStatusBloc extends Bloc<AppEvent, AppState> {
  final ChangeStatusRepo repo;

  ChangeStatusBloc({required this.repo}) : super(Start()) {
    on<Click>(onClick);
  }

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    try {
      emit(Loading());
      loadingDialog();
      Either<ServerFailure, Response> response =
          await repo.changeStatus(event.arguments as Map<String, dynamic>);

      CustomNavigator.pop();

      response.fold((fail) {
        AppCore.showToast(fail.error);
        emit(Error());
      }, (success) {
        OrderDetailsModel model = OrderDetailsModel.fromJson(success.data["data"]);

        (event.arguments as Map)["onSuccess"].call(model);

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
}
