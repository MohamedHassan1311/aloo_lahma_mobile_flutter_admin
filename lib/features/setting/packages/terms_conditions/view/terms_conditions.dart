import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:aloo_lahma_admin/app/core/app_state.dart';
import 'package:aloo_lahma_admin/app/localization/language_constant.dart';
import '../../../../../app/core/app_event.dart';
import '../../../../../app/core/dimensions.dart';
import '../../../../../app/core/styles.dart';
import '../../../../../components/animated_widget.dart';
import '../../../../../components/custom_app_bar.dart';
import '../../../../../components/custom_loading.dart';
import '../../../../../components/empty_widget.dart';
import '../../../../../data/config/di.dart';
import '../../../../../data/internet_connection/internet_connection.dart';
import '../../../repo/settings_repo.dart';
import '../bloc/terms_conditions_bloc.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated("terms_conditions")),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => TermsConditionsBloc(repo: sl<SettingsRepo>(), internetConnection: sl<InternetConnection>())..add(Click()),
          child: BlocBuilder<TermsConditionsBloc, AppState>(
            builder: (context, state) {
              if (state is Loading) {
                return const CustomLoading();
              }
              if (state is Done) {
                return ListAnimator(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                  ),
                  data: [
                    SizedBox(height: 24.h),
                    HtmlWidget((state.data as String?) ?? "About Association"),
                    SizedBox(height: 24.h),
                  ],
                );
              }
              if (state is Error || state is Empty) {
                return RefreshIndicator(
                  color: Styles.PRIMARY_COLOR,
                  onRefresh: () async {
                    context.read<TermsConditionsBloc>().add(Click());
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: ListAnimator(
                          padding: EdgeInsets.symmetric(
                              vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                          data: [
                            SizedBox(height: 50.h),
                            EmptyState(
                              txt: state is Error
                                  ? getTranslated("something_went_wrong")
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
