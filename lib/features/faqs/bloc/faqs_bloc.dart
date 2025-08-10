import 'dart:convert';
import 'dart:developer';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:aloo_lahma_admin/features/faqs/model/faq_model.dart';
import '../../../../../app/core/app_core.dart';
import '../../../../../app/core/app_event.dart';
import '../../../../../app/core/app_state.dart';
import '../../../../../data/error/failures.dart';
import '../../../data/internet_connection/internet_connection.dart';
import '../../../main_models/search_engine.dart';
import '../repo/faqs_repo.dart';

class FaqsBloc extends HydratedBloc<AppEvent, AppState> {
  final FaqsRepo repo;
  final InternetConnection internetConnection;

  FaqsBloc({required this.internetConnection, required this.repo})
      : super(Start()) {
    controller = ScrollController();
    customScroll();
    on<Click>(onClick);
  }

  late ScrollController controller;
  late SearchEngine _engine;

  customScroll() {
    controller.addListener(() {
      bool scroll = AppCore.scrollListener(
          controller, _engine.maxPages, _engine.currentPage!);
      if (scroll) {
        // _engine.updateCurrentPage(_engine.currentPage!);
        add(Click(arguments: _engine));
      }
    });
  }

  List<FaqModel>? _model;

  @override
  close() async {
    super.close();
    controller.dispose();
  }

  Future<void> onClick(Click event, Emitter<AppState> emit) async {
    try {
      _engine = event.arguments as SearchEngine;
      if (_engine.currentPage == 0) {
        _model = [];
        if (!_engine.isUpdate) {
          emit(Loading());
        }
      } else {
        emit(Done(list: _model, loading: true));
      }

      Either<ServerFailure, Response> response = await repo.getFaqs(_engine);

      response.fold((fail) {
        emit(Error());
      }, (success) {
        FaqsModel? res = FaqsModel.fromJson(success.data);

        if (_engine.currentPage == 0) {
          _model?.clear();
        }

        if (res.data != null && res.data!.isNotEmpty) {
          for (var faq in res.data!) {
            _model?.removeWhere((e) => e.id == faq.id);
            _model?.add(faq);
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
      log("Exception $e");
      emit(Error());
    }
  }

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    try {
      if (json['state'] == "Start") {
        return Loading();
      }
      if (json['state'] == "Error") {
        return Error();
      }
      if (json['state'] == "Loading") {
        return Loading();
      }
      if (json['state'] == "Done") {
        return Done(
          list: List<FaqModel>.from(
              jsonDecode(json['list']).map((e) => FaqModel.fromJson(e))),
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
