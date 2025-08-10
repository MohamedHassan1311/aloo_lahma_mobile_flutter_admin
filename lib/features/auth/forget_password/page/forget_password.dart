import 'package:country_codes/country_codes.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloo_lahma_admin/app/core/dimensions.dart';
import 'package:aloo_lahma_admin/components/custom_app_bar.dart';
import 'package:aloo_lahma_admin/features/auth/forget_password/bloc/forget_password_bloc.dart';
import 'package:aloo_lahma_admin/features/auth/forget_password/repo/forget_password_repo.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/app_state.dart';
import '../../../../app/core/styles.dart';
import '../../../../app/core/svg_images.dart' show SvgImages;
import '../../../../app/core/text_styles.dart';
import '../../../../app/core/validation.dart';
import '../../../../app/localization/language_constant.dart';
import '../../../../components/animated_widget.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_text_form_field.dart';
import '../../../../data/config/di.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key, required this.userType});
  final String userType;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordBloc(repo: sl<ForgetPasswordRepo>()),
      child: BlocBuilder<ForgetPasswordBloc, AppState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const CustomAppBar(),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ListAnimator(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                        vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
                    data: [
                      Text(
                        getTranslated("forget_password_header"),
                        style: AppTextStyles.w800.copyWith(
                            fontSize: 32, color: Styles.PRIMARY_COLOR),
                      ),
                      SizedBox(height: Dimensions.paddingSizeMini.h),
                      Text(
                        getTranslated("forget_password_description"),
                        style: AppTextStyles.w400.copyWith(
                            fontSize: 16, color: Styles.DETAILS_COLOR),
                      ),
                      SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT.h),
                      Form(
                        key: context.read<ForgetPasswordBloc>().formKey,
                        child: CustomTextField(
                          controller:
                              context.read<ForgetPasswordBloc>().phoneTEC,
                          autofillHints: const [
                            AutofillHints.telephoneNumber,
                            AutofillHints.username,
                          ],
                          label: getTranslated("phone"),
                          hint: getTranslated("enter_your_phone"),
                          inputType: TextInputType.phone,
                          validate: Validations.phone,
                          pSvgIcon: SvgImages.phone,
                          maxLength: 9,
                          sufWidget: Container(
                            height: 200,
                            margin: EdgeInsetsDirectional.only(end: 1.5.w),
                            padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                              vertical: Dimensions.PADDING_SIZE_SMALL.h,
                            ),
                            decoration: BoxDecoration(
                                color: Styles.FILL_COLOR,
                                borderRadius: BorderRadius.circular(8.w)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CountryFlag.fromCountryCode(
                                  "SA",
                                  height: 18,
                                  width: 24,
                                  shape: const RoundedRectangle(5),
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  CountryCodes.detailsForLocale(
                                        Locale.fromSubtags(countryCode: "SA"),
                                      ).dialCode ??
                                      "+966",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: AppTextStyles.w700.copyWith(
                                      fontSize: 14,
                                      height: 1,
                                      color: Styles.HEADER),
                                ),
                              ],
                            ),
                          ),
                          keyboardAction: TextInputAction.done,
                          onSubmit: (v) {
                            if (context
                                .read<ForgetPasswordBloc>()
                                .formKey
                                .currentState!
                                .validate()) {
                              TextInput.finishAutofillContext();
                              context.read<ForgetPasswordBloc>().add(Click());
                            }
                          },
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: CustomButton(
                              text: getTranslated("submit"),
                              onTap: () {
                                if (context
                                    .read<ForgetPasswordBloc>()
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  context
                                      .read<ForgetPasswordBloc>()
                                      .add(Click(arguments: userType));
                                }
                              },
                              isLoading: state is Loading),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
