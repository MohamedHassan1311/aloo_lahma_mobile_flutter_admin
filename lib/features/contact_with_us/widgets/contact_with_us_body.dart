import 'package:country_codes/country_codes.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloo_lahma_admin/app/core/app_state.dart';
import '../../../../app/core/validation.dart';
import '../../../../app/localization/language_constant.dart';
import '../../../../components/custom_text_form_field.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../bloc/contact_with_us_bloc.dart';
import '../entity/contact_with_us_entity.dart';

class ContactWithUsBody extends StatelessWidget {
  const ContactWithUsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactWithUsBloc, AppState>(
      builder: (context, state) {
        return StreamBuilder<ContactWithUsEntity?>(
          stream: context.read<ContactWithUsBloc>().entityStream,
          builder: (context, snapshot) {
            return Form(
              key: context.read<ContactWithUsBloc>().formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Name
                  CustomTextField(
                    controller: snapshot.data?.name,
                    label: getTranslated("name"),
                    hint: getTranslated("enter_your_name"),
                    inputType: TextInputType.name,
                    nextFocus: snapshot.data?.phoneNode,
                    focusNode:snapshot.data?.nameNode,
                    validate: Validations.name,
                    pSvgIcon: SvgImages.user,
                  ),

                  ///Phone
                  CustomTextField(
                    controller: snapshot.data?.phone,
                    focusNode: snapshot.data?.phoneNode,
                    nextFocus: snapshot.data?.emailNode,
                    label: getTranslated("phone"),
                    hint: getTranslated("enter_your_phone"),
                    inputType: TextInputType.phone,
                    validate: Validations.phone,
                    pSvgIcon: SvgImages.phone,
                    maxLength: 9,
                    sufWidget: Container(
                      height: 50.h,
                      margin: EdgeInsetsDirectional.only(end: 2.w),
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
                                fontSize: 14, height: 1, color: Styles.HEADER),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///Mail
                  CustomTextField(
                    controller: snapshot.data?.email,
                    focusNode: snapshot.data?.emailNode,
                    nextFocus: snapshot.data?.messageNode,
                    label: getTranslated("mail"),
                    hint: getTranslated("enter_your_mail"),
                    inputType: TextInputType.emailAddress,
                    validate: Validations.mail,
                    pSvgIcon: SvgImages.mail,
                  ),

                  ///Message
                  CustomTextField(
                    controller: snapshot.data?.message,
                    label: getTranslated("message"),
                    hint: getTranslated("write_your_message"),
                    focusNode: snapshot.data?.messageNode,
                    inputType: TextInputType.text,
                    keyboardAction: TextInputAction.done,
                    validate: (v) => Validations.field(
                      v,
                      fieldName: getTranslated("message"),
                    ),
                    maxLines: 5,
                    minLines: 5,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
