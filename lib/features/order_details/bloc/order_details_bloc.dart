import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zurex_admin/features/order_details/repo/order_details_repo.dart';

import '../../../../../app/core/app_core.dart';
import '../../../../../app/core/app_event.dart';
import '../../../../../app/core/app_notification.dart';
import '../../../../../app/core/app_state.dart';
import '../../../../../app/core/styles.dart';
import '../../../../../data/error/failures.dart';
import '../model/order_details_model.dart';

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
        AppCore.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.red));
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
      AppCore.showSnackBar(
          notification: AppNotification(
        message: e.toString(),
        backgroundColor: Styles.IN_ACTIVE,
        borderColor: Styles.RED_COLOR,
      ));
      emit(Error());
    }
  }

  Future<void> onUpdate(Update event, Emitter<AppState> emit) async {
    emit(Done(model: event.arguments as OrderDetailsModel));
  }
}
