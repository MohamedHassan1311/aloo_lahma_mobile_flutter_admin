import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloo_lahma_admin/navigation/custom_navigation.dart';
import 'package:aloo_lahma_admin/navigation/routes.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/app_state.dart';
import '../../../data/config/di.dart';
import '../../../main_blocs/user_bloc.dart';
import '../../setting/bloc/settings_bloc.dart';
import '../repo/splash_repo.dart';

class SplashBloc extends Bloc<AppEvent, AppState> {
  final SplashRepo repo;
  SplashBloc({required this.repo}) : super(Start()) {
    on<Click>(onClick);
  }

  Future<void> onClick(AppEvent event, Emitter<AppState> emit) async {
    Future.delayed(const Duration(milliseconds: 2500), () async {

      ///Get Settings
      sl<SettingsBloc>().add(Get());

      if (repo.isLogin) {
        UserBloc.instance.add(Click());
      } else {
        if (!kDebugMode) {
          await repo.guestMode();
        }
      }

      if (!repo.isLogin) {
        CustomNavigator.push(Routes.login, clean: true);
      } else {
        CustomNavigator.push(Routes.dashboard, clean: true, arguments: 0);
      }
      repo.setFirstTime();
    });
  }
}
