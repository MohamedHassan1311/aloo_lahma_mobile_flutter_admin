import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloo_lahma_admin/features/language/bloc/language_bloc.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_state.dart';
import '../../../../app/core/dimensions.dart';
import '../../../../components/animated_widget.dart';
import '../../../../data/config/di.dart';
import '../../../../main_widgets/text_of_agree_terms.dart';
import '../../../profile/enums/user_types_enum.dart';
import '../bloc/login_bloc.dart';
import '../repo/login_repo.dart';
import '../widgets/choose_user_type.dart';
import '../widgets/login_body.dart';
import '../widgets/login_header.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(repo: sl<LoginRepo>())..add(Remember()),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<LanguageBloc, AppState>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: BlocBuilder<LoginBloc, AppState>(
                      builder: (context, state) {
                        return ListAnimator(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                          data: [
                            const LoginHeader(),
                            StreamBuilder<UserType>(
                                stream:
                                    context.read<LoginBloc>().userTypeStream,
                                builder: (context, snapshot) {
                                  return ChooseUserType(
                                    type: context
                                        .read<LoginBloc>()
                                        .userType
                                        .value,
                                    onChange: context
                                        .read<LoginBloc>()
                                        .updateUserType,
                                  );
                                }),
                            const LoginBody(),
                          ],
                        );
                      },
                    ),
                  ),
                  const TextOfAgreeTerms(fromWelcomeScreen: false)
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
