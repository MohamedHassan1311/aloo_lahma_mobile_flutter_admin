import 'package:aloo_lahma_admin/app/core/app_state.dart';
import 'package:aloo_lahma_admin/app/core/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloo_lahma_admin/features/contact_with_us/bloc/contact_with_us_bloc.dart';
import '../../../../app/core/app_event.dart';
import '../../../../app/localization/language_constant.dart';
import '../../../../components/custom_button.dart';

class ContactWithUsAction extends StatelessWidget {
  const ContactWithUsAction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactWithUsBloc, AppState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Center(
            child: CustomButton(
                text: getTranslated("submit"),
                onTap: () {
                  if (context.read<ContactWithUsBloc>().formKey.currentState!.validate()) {
                    context.read<ContactWithUsBloc>().add(Click());
                  }
                },
                isLoading: state is Loading),
          ),
        );
      },
    );
  }
}
