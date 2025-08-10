import 'package:aloo_lahma_admin/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloo_lahma_admin/main_models/search_engine.dart';
import '../../../../../app/core/app_event.dart';
import '../../../../../app/localization/language_constant.dart';
import '../../../../../data/config/di.dart';
import '../../../app/core/app_state.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_loading_text.dart';
import '../../../components/empty_widget.dart';
import '../../../data/internet_connection/internet_connection.dart';
import '../model/faq_model.dart';
import '../bloc/faqs_bloc.dart';
import '../repo/faqs_repo.dart';
import '../widgets/faq_card.dart';

class FaqsPage extends StatelessWidget {
  const FaqsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated("faqs")),
      body: BlocProvider(
        create: (context) => FaqsBloc(
            repo: sl<FaqsRepo>(), internetConnection: sl<InternetConnection>())
          ..add(Click(arguments: SearchEngine())),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT.h),
            Expanded(
              child: BlocBuilder<FaqsBloc, AppState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return ListAnimator(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                      data: List.generate(
                        8,
                        (i) => QuestionCardShimmer(),
                      ),
                    );
                  }
                  if (state is Done) {
                    List<FaqModel> questions = state.list as List<FaqModel>;
                    return Column(
                      children: [
                        Expanded(
                          child: ListAnimator(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                            controller: context.read<FaqsBloc>().controller,
                            data: List.generate(
                              questions.length,
                              (i) =>
                                  FaqCard(index: i + 1, question: questions[i]),
                            ),
                          ),
                        ),
                        CustomLoadingText(loading: state.loading),
                      ],
                    );
                  }
                  if (state is Error || state is Empty) {
                    return RefreshIndicator(
                      color: Styles.PRIMARY_COLOR,
                      onRefresh: () async {
                        context
                            .read<FaqsBloc>()
                            .add(Click(arguments: SearchEngine()));
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
                    return SizedBox();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
