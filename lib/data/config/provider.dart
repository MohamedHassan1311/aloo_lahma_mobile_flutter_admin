import 'package:zurex_admin/data/config/di.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:zurex_admin/features/orders/bloc/orders_bloc.dart';


import 'package:zurex_admin/main_blocs/user_bloc.dart';

import '../../app/core/app_event.dart';
import '../../features/auth/logout/bloc/logout_bloc.dart';
import '../../features/language/bloc/language_bloc.dart';
import '../../features/profile/bloc/profile_bloc.dart';
import '../../features/setting/bloc/setting_bloc.dart';
import '../../main_blocs/country_states_bloc.dart';

abstract class ProviderList {
  static List<BlocProvider> providers = [
    BlocProvider<LanguageBloc>(
        create: (_) => di.sl<LanguageBloc>()..add(Init())),
    BlocProvider<CountryStatesBloc>(create: (_) => di.sl<CountryStatesBloc>()),
    BlocProvider<SettingBloc>(create: (_) => di.sl<SettingBloc>()),
    BlocProvider<ProfileBloc>(create: (_) => di.sl<ProfileBloc>()),
    BlocProvider<UserBloc>(create: (_) => di.sl<UserBloc>()),
    ///Orders
    BlocProvider<OrdersBloc>(create: (_) => di.sl<OrdersBloc>()),
    ///Log out
    BlocProvider<LogoutBloc>(create: (_) => di.sl<LogoutBloc>()),
  ];
}
