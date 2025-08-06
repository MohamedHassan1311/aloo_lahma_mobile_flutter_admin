import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zurex_admin/app/core/dimensions.dart';
import 'package:zurex_admin/components/custom_app_bar.dart';
import 'package:zurex_admin/features/language/bloc/language_bloc.dart';
import 'package:zurex_admin/features/language/page/language_button_icon.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_state.dart';
import '../../../../data/config/di.dart';
import '../../../../main_widgets/text_of_agree_terms.dart';
import '../bloc/login_bloc.dart';
import '../repo/login_repo.dart';
import '../widgets/login_body.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(repo: sl<LoginRepo>())..add(Remember()),
      child: Scaffold(
        appBar: CustomAppBar(
          withBack: false,
          actionChild: LanguageButtonIcon(),
          actionWidth: 80.w,
        ),
        body: SafeArea(
          child: BlocBuilder<LanguageBloc, AppState>(
            builder: (context, state) {
              return Column(
                children: [
                  LoginBody(),
                  const TextOfAgreeTerms(fromWelcomeScreen: false),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
