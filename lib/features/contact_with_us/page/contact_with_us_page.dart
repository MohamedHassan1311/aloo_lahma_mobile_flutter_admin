import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloo_lahma_admin/features/contact_with_us/bloc/contact_with_us_bloc.dart';
import 'package:aloo_lahma_admin/features/contact_with_us/repo/contact_with_us_repo.dart';
import 'package:aloo_lahma_admin/app/core/dimensions.dart';
import '../../../app/core/app_state.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_app_bar.dart';
import '../../../data/config/di.dart';
import '../widgets/contact_with_us_action.dart';
import '../widgets/contact_with_us_body.dart';
import '../widgets/contact_with_us_header.dart';

class ContactWithUsPage extends StatelessWidget {
  const ContactWithUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactWithUsBloc(repo: sl<ContactWithUsRepo>()),
      child: Scaffold(
        appBar: CustomAppBar(
          title: getTranslated("contact_with_us"),
        ),
        body: SafeArea(
          child: BlocBuilder<ContactWithUsBloc, AppState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListAnimator(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                      data: [
                        ContactWithUsHeader(),
                        ContactWithUsBody(),
                        ContactWithUsAction(),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
