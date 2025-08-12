import 'dart:convert';

import 'package:aloo_lahma_admin/main_models/user_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../../app/core/app_core.dart';
import '../../../../../app/core/app_event.dart';
import '../../../../../app/core/app_state.dart';
import '../../../../../data/error/failures.dart';
import '../../../../../main_models/search_engine.dart';
import '../../../data/internet_connection/internet_connection.dart';
import '../model/drivers_model.dart';
import '../repo/drivers_repo.dart';

class DriversBloc extends HydratedBloc<AppEvent, AppState> {
  final DriversRepo repo;
  final InternetConnection internetConnection;

  DriversBloc({required this.repo, required this.internetConnection})
      : super(Start()) {
    searchTEC = TextEditingController();
    controller = ScrollController();
    customScroll(controller);
    on<Click>(onClick);
  }

  TextEditingController? searchTEC;

  late ScrollController controller;
  late SearchEngine _engine;
  List<UserModel>? _model;

  customScroll(ScrollController controller) {
    controller.addListener(() {
      bool scroll = AppCore.scrollListener(
          controller, _engine.maxPages, _engine.currentPage!);
      if (scroll) {
        add(Click(arguments: _engine));
      }
    });
  }

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    if (await internetConnection.updateConnectivityStatus()) {
      try {
        _engine = event.arguments as SearchEngine;
        if (_engine.currentPage == 0) {
          _model = [];
          if (!_engine.isUpdate) {
            emit(Loading());
          }
        } else {
          emit(Done(data: _model, loading: true));
        }

        Either<ServerFailure, Response> response =
            await repo.getDrivers(_engine);

        response.fold((fail) {
          emit(Error());
        }, (success) {
          DriversModel? res = DriversModel.fromJson(success.data);

          if (_engine.currentPage == 0) {
            _model?.clear();
          }

          if (res.data != null && res.data!.isNotEmpty) {
            for (var item in res.data!) {
              _model?.removeWhere((e) => e.id == item.id);
              _model?.add(item);
            }
          }

          _engine.maxPages = res.meta?.pagesCount ?? 1;
          _engine.updateCurrentPage(res.meta?.currentPage ?? 1);
          if (_model != null && _model!.isNotEmpty) {
            emit(Done(list: _model, loading: false));
          } else {
            emit(Empty());
          }
        });
      } catch (e) {
        emit(Error());
      }
    }
  }

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    try {
      if (json['state'] == "Start") {
        return Start();
      }
      if (json['state'] == "Error") {
        return Error();
      }
      if (json['state'] == "Loading") {
        return Loading();
      }
      if (json['state'] == "Done") {
        return Done(
          list: List<UserModel>.from(
              jsonDecode(json['list']).map((e) => UserModel.fromJson(e))),
          loading: jsonDecode(json['loading']) as bool,
        );
      }
      return Loading();
    } catch (e) {
      return Error();
    }
  }

  @override
  Map<String, dynamic>? toJson(AppState? state) => state?.toJson();
}

enum OrderMainStatus { current, completed }
