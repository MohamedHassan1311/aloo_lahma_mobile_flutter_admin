import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloo_lahma_admin/app/core/app_state.dart';
import 'package:aloo_lahma_admin/app/core/dimensions.dart';
import 'package:aloo_lahma_admin/main_blocs/user_bloc.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../data/config/di.dart';
import '../../../main_widgets/profile_image_widget.dart';
import '../../language/bloc/language_bloc.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, AppState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: Dimensions.paddingSizeMini.h,
            children: [
              ProfileImageWidget(
                withEdit: false,
                image: UserBloc.instance.user?.profileImage,
                radius: 35.w,
              ),

              ///Name
              Text(
                UserBloc.instance.isLogin
                    ? UserBloc.instance.user?.name ?? ""
                    : "Guest",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.w900.copyWith(
                  color: Styles.HEADER,
                  height: 1,
                  fontSize: 16,
                ),
              ),

              ///Phone
              if (sl<UserBloc>().isLogin)
                Text(
                  "${LanguageBloc.instance.isLtr ? "+" : ""}966${UserBloc.instance.isLogin ? UserBloc.instance.user?.mobile ?? "" : "00000000"}${LanguageBloc.instance.isLtr ? "" : "+"}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.w400.copyWith(
                    color: Styles.TITLE,
                    height: 1,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
