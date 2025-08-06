import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zurex_admin/main_models/user_model.dart';

import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_network_image.dart';

class OrderUserCard extends StatelessWidget {
  const OrderUserCard({super.key, this.user});
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeMini.h),
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
          vertical: Dimensions.PADDING_SIZE_DEFAULT.h),
      decoration: BoxDecoration(
          color: Styles.WHITE_COLOR,
          borderRadius: BorderRadius.circular(16.w),
          border: Border.all(
            color: Styles.LIGHT_BORDER_COLOR,
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          user?.profileImage != null
              ? CustomNetworkImage.circleNewWorkImage(
                  color: Styles.HINT_COLOR,
                  image: user?.profileImage ?? "",
                  radius: 25.w)
              : customCircleSvgIcon(
                  imageName: SvgImages.profileIcon,
                  width: 35.w,
                  height: 35.w,
                  radius: 25.w,
                  imageColor: Colors.grey,
                  color: Styles.FILL_COLOR),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_SMALL.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.name ?? "name",
                    style: AppTextStyles.w700
                        .copyWith(fontSize: 16, color: Styles.HEADER),
                  ),
                  Text(
                    "+966${user?.phone ?? ""}",
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
            ),
          ),
          customContainerSvgIcon(
              onTap: () => launchUrl(Uri.parse("tel://${user?.phone}"),
                  mode: LaunchMode.externalApplication),
              imageName: SvgImages.phoneCallIcon,
              backGround: Styles.PRIMARY_COLOR,
              color: Styles.WHITE_COLOR,
              width: 40.w,
              height: 40.w,
              padding: 8.w,
              radius: 100.w),
        ],
      ),
    );
  }
}
