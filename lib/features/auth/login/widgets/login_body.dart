import 'package:country_codes/country_codes.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zurex_admin/app/core/app_state.dart';
import 'package:zurex_admin/app/core/dimensions.dart';
import 'package:zurex_admin/components/animated_widget.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/core/styles.dart';
import '../../../../app/core/svg_images.dart';
import '../../../../app/core/text_styles.dart';
import '../../../../app/core/validation.dart';
import '../../../../app/localization/language_constant.dart';
import '../../../../components/custom_button.dart';
import '../../../../components/custom_text_form_field.dart';
import '../../../../navigation/custom_navigation.dart';
import '../../../../navigation/routes.dart';
import '../bloc/login_bloc.dart';
import 'login_header.dart';
import 'remember_me.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<LoginBloc, AppState>(
        builder: (context, state) {
          return ListAnimator(
            customPadding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
            data: [
              LoginHeader(),
              Form(
                  key: context.read<LoginBloc>().formKey,
                  child: AutofillGroup(
                    child: Column(
                      children: [
                        ///Phone
                        CustomTextField(
                          controller: context.read<LoginBloc>().phoneTEC,
                          focusNode: context.read<LoginBloc>().phoneNode,
                          nextFocus: context.read<LoginBloc>().passwordNode,
                          autofillHints: const [
                            AutofillHints.telephoneNumber,
                            AutofillHints.username,
                          ],
                          label: getTranslated("phone", context: context),
                          hint: getTranslated("enter_your_phone",
                              context: context),
                          inputType: TextInputType.phone,
                          validate: Validations.phone,
                          maxLength: 10,
                          // pSvgIcon: SvgImages.phoneCallIcon,
                          prefixWidget: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 4.h),
                            decoration: BoxDecoration(
                                color: Styles.FILL_COLOR,
                                borderRadius: BorderRadius.circular(4)),
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
                                  style: AppTextStyles.w400.copyWith(
                                      fontSize: 14,
                                      height: 1,
                                      color: Styles.HEADER),
                                ),
                              ],
                            ),
                          ),
                        ),

                        ///Password
                        CustomTextField(
                          autofillHints: const [AutofillHints.password],
                          controller: context.read<LoginBloc>().passwordTEC,
                          focusNode: context.read<LoginBloc>().passwordNode,
                          keyboardAction: TextInputAction.done,
                          label: getTranslated("password", context: context),
                          hint: getTranslated("enter_your_password",
                              context: context),
                          inputType: TextInputType.visiblePassword,
                          validate: Validations.password,
                          isPassword: true,
                          pSvgIcon: SvgImages.lockIcon,
                        ),

                        ///Forget Password && Remember me
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              top: Dimensions.paddingSizeMini.h,
                              bottom: Dimensions.paddingSizeMini.h,
                              end: Dimensions.paddingSizeMini.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: StreamBuilder<bool?>(
                                  stream: context
                                      .read<LoginBloc>()
                                      .rememberMeStream,
                                  builder: (_, snapshot) {
                                    return RememberMe(
                                      check: snapshot.data ?? false,
                                      onChange: (v) => context
                                          .read<LoginBloc>()
                                          .updateRememberMe(v),
                                    );
                                  },
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.read<LoginBloc>().clear();
                                  CustomNavigator.push(Routes.forgetPassword,
                                      arguments: context
                                          .read<LoginBloc>()
                                          .userType
                                          .valueOrNull
                                          ?.name);
                                },
                                child: Text(
                                  getTranslated("forget_password",
                                      context: context),
                                  style: AppTextStyles.w500.copyWith(
                                    color: Styles.PRIMARY_COLOR,
                                    fontSize: 13,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Styles.PRIMARY_COLOR,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///Sign in
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
                          ),
                          child: CustomButton(
                              text: getTranslated("login", context: context),
                              onTap: () {
                                if (context
                                    .read<LoginBloc>()
                                    .formKey
                                    .currentState!
                                    .validate()) {
                                  TextInput.finishAutofillContext();
                                  context.read<LoginBloc>().add(Click());
                                }
                              },
                              isLoading: state is Loading),
                        ),

                        ///Guest Mode
                        GestureDetector(
                          onTap: () => context.read<LoginBloc>().add(Add()),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeMini.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                                vertical: Dimensions.paddingSizeMini.h),
                            child: Text(
                              getTranslated("login_as_a_guest",
                                  context: context),
                              style: AppTextStyles.w500
                                  .copyWith(fontSize: 14, color: Styles.TITLE),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }
}
