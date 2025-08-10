import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app/core/app_event.dart';
import '../app/core/app_state.dart';
import '../data/config/di.dart';
import '../data/error/failures.dart';
import '../main_models/user_model.dart';
import '../main_repos/user_repo.dart';

class UserBloc extends Bloc<AppEvent, AppState> {
  final UserRepo repo;

  static UserBloc get instance => sl<UserBloc>();

  UserBloc({required this.repo}) : super(Start()) {
    on<Click>(onClick);
    on<Update>(onUpdate);
    on<Delete>(onDelete);
  }

  String? get userType => repo.userType;
  bool get isLogin => repo.isLogIn;
  UserModel? user;

  onClick(Click event, Emitter<AppState> emit) async {
    try {
    emit(Loading());

    Either<ServerFailure, UserModel> response = repo.getUser();

    response.fold((fail) {
      user = null;
      emit(Error());
    }, (success) {
      user = success;
      log("${success.toJson()}");
      emit(Done(model: user));
    });
    } catch (e) {

      emit(Error());
    }
  }

  onUpdate(Update event, Emitter<AppState> emit) async {
    repo.setUserData((event.arguments as UserModel).toJson());
    emit(Done(model: event.arguments as UserModel));
  }

  onDelete(Delete event, Emitter<AppState> emit) async {
    user = null;
    repo.clearUserData();
    emit(Start());
  }
}
