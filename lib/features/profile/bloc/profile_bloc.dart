import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_state.dart';
import '../../../../data/error/failures.dart';
import '../../../main_blocs/user_bloc.dart';
import '../repo/profile_repo.dart';

class ProfileBloc extends Bloc<AppEvent, AppState> {
  final ProfileRepo repo;

  ProfileBloc({required this.repo}) : super(Start()) {
    on<Get>(onGetData);
  }

  bool get isLogin => repo.isLogin;
  String? get userType => repo.userType;

  Future<void> onGetData(Get event, Emitter<AppState> emit) async {
    try {
      emit(Loading());
      Either<ServerFailure, Response> response = await repo.getProfile();

      response.fold((fail) {
        emit(Error());
      }, (success) {
        UserBloc.instance.add(Click());
        emit(Done());
      });
    } catch (e) {
      emit(Error());
    }
  }
}
