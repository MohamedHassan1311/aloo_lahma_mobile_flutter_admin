import 'package:aloo_lahma_admin/app/core/extensions.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_images.dart';
import '../model/order_status_model.dart';

class OrderStatusList extends StatelessWidget {
  const OrderStatusList({super.key, this.list});
  final List<OrderStatusModel>? list;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslated("order_status"),
            style:
                AppTextStyles.w700.copyWith(fontSize: 16, color: Styles.HEADER),
          ),
          Divider(
            height: Dimensions.PADDING_SIZE_DEFAULT.h,
            color: Styles.LIGHT_BORDER_COLOR,
          ),
          SizedBox(
            height: 100.h,
            child: EasyStepper(
              activeStep: list?.indexWhere((e) => e.isCurrent == true) ?? 0,
              reachedSteps: {
                for (int i = 0; i < list!.length; i++)
                  if (list?[i].createdAt != null) i
              },
              lineStyle: LineStyle(
                  unreachedLineColor: Styles.DISABLED,
                  activeLineColor: Styles.GREEN,
                  finishedLineColor: Styles.GREEN,
                  lineLength: 40.w,
                  lineSpace: 0),
              fitWidth: true,
              stepAnimationCurve: Curves.easeIn,
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              showTitle: true,
              defaultStepBorderType: BorderType.normal,
              unreachedStepIconColor: Styles.DISABLED,
              unreachedStepBorderColor: Styles.DISABLED,
              unreachedStepBackgroundColor: Styles.WHITE_COLOR,
              activeStepBorderColor: Styles.GREEN,
              activeStepIconColor: Styles.GREEN,
              activeStepBackgroundColor: Styles.GREEN.withValues(alpha: 0.1),
              finishedStepIconColor: Styles.GREEN,
              finishedStepBorderColor: Styles.GREEN,
              finishedStepBackgroundColor: Styles.GREEN,
              enableStepTapping: false,
              stepShape: StepShape.circle,
              borderThickness: 1,
              internalPadding: 0,
              unreachedStepTextColor: Styles.DISABLED,
              activeStepTextColor: Styles.GREEN,
              finishedStepTextColor: Styles.GREEN,
              showLoadingAnimation: false,
              alignment: Alignment.center,
              stepRadius: 25.w,
              showStepBorder: true,
              steps: List.generate(
                list?.length ?? 0,
                (i) => EasyStep(
                  customStep: customCircleSvgIcon(
                    imageName: SvgImages.orderStatus(list?[i].statusCode?.name),
                    radius: 12.w,
                    color: Colors.transparent,
                    imageColor: list?[i].isCurrent == true
                        ? Styles.GREEN
                        : list?[i].createdAt != null
                            ? Styles.WHITE_COLOR
                            : Styles.DISABLED,
                  ),
                  title:
                      "${list?[i].status}\n${(list?[i].createdAt?.dateFormat(format: "d-MMM, h:mm a")) ?? ""}",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
