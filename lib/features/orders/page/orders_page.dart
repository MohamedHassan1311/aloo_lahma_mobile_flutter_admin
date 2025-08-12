import 'package:aloo_lahma_admin/features/orders/bloc/orders_bloc.dart';
import 'package:aloo_lahma_admin/main_models/search_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloo_lahma_admin/main_blocs/user_bloc.dart';
import 'package:aloo_lahma_admin/main_widgets/guest_mode.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/app_state.dart';
import '../../../data/config/di.dart';
import '../widgets/main_app_bar.dart';
import '../widgets/orders_body.dart';
import '../widgets/orders_header.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with AutomaticKeepAliveClientMixin<OrdersPage> {

  @override
  void initState() {
    sl<OrdersBloc>().add(Click(arguments: SearchEngine()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: MainAppBar(),
      body: SafeArea(
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
