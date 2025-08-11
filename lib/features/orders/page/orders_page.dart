import 'package:aloo_lahma_admin/features/orders/bloc/orders_bloc.dart';
import 'package:aloo_lahma_admin/features/orders/repo/orders_repo.dart';
import 'package:aloo_lahma_admin/main_models/search_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloo_lahma_admin/main_blocs/user_bloc.dart';
import 'package:aloo_lahma_admin/main_widgets/guest_mode.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/app_state.dart';
import '../../../data/config/di.dart';
import '../../../data/internet_connection/internet_connection.dart';
import '../widgets/main_app_bar.dart';
import '../widgets/orders_body.dart';
import '../widgets/orders_header.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => OrdersBloc(
              repo: sl<OrdersRepo>(),
              internetConnection: sl<InternetConnection>())
            ..add(Click(arguments: SearchEngine())),
          child: BlocBuilder<UserBloc, AppState>(
            builder: (context, state) {
              return sl<UserBloc>().isLogin
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OrdersHeader(),
                        OrdersBody(),
                      ],
                    )
                  : GuestMode();
            },
          ),
        ),
      ),
    );
  }
}
