import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../app/core/app_event.dart';
import '../../../../../app/core/app_state.dart';
import '../../../../../data/error/failures.dart';
import '../model/order_details_model.dart';
import '../repo/order_details_repo.dart';

class OrderDetailsBloc extends Bloc<AppEvent, AppState> {
  final OrderDetailsRepo repo;

  OrderDetailsBloc({required this.repo}) : super(Start()) {
    on<Click>(onClick);
    on<Update>(onUpdate);
  }

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    try {
      emit(Loading());

      Either<ServerFailure, Response> response =
          await repo.getOrderDetails(event.arguments as int);

      response.fold((fail) {
        emit(Error());
      }, (success) {
        if (success.data["data"] != null) {
          OrderDetailsModel? res =
              OrderDetailsModel.fromJson(success.data["data"]);
          emit(Done(model: res));
        } else {
          emit(Error());
        }
      });
    } catch (e) {
      emit(Error());
    }
  }

  Future<void> onUpdate(Update event, Emitter<AppState> emit) async {
    emit(Done(model: event.arguments as OrderDetailsModel));
  }
}
