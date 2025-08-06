import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:zurex_admin/app/core/dimensions.dart';
import 'package:zurex_admin/app/core/extensions.dart';
import 'package:zurex_admin/app/core/svg_images.dart';
import 'package:zurex_admin/components/custom_images.dart';
import 'package:zurex_admin/features/order_details/model/order_details_model.dart';

import '../../../app/core/styles.dart';

class OrderStatusList extends StatelessWidget {
  const OrderStatusList({super.key, this.list});
  final List<StatusModel>? list;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: EasyStepper(
        activeStep: list?.indexWhere((e) => e.isCurrent == true) ?? 0,
        reachedSteps: {
          for (int i = 0; i < list!.length; i++)
            if (list?[i].createdAt != null) i
        },
        lineStyle: LineStyle(
            unreachedLineColor: Styles.DISABLED,
            activeLineColor: Styles.PRIMARY_COLOR,
            finishedLineColor: Styles.PRIMARY_COLOR,
            lineLength: 40.w,
            lineSpace: 0),
        fitWidth: true,
        stepAnimationCurve: Curves.easeIn,
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
        showTitle: true,
        defaultStepBorderType: BorderType.normal,
        unreachedStepIconColor: Styles.DISABLED,
        unreachedStepBorderColor: Styles.DISABLED,
        unreachedStepBackgroundColor: Styles.WHITE_COLOR,
        activeStepBorderColor: Styles.PRIMARY_COLOR,
        activeStepIconColor: Styles.PRIMARY_COLOR,
        activeStepBackgroundColor: Styles.PRIMARY_COLOR,
        finishedStepIconColor: Styles.PRIMARY_COLOR,
        finishedStepBorderColor: Styles.PRIMARY_COLOR,
        finishedStepBackgroundColor: Styles.PRIMARY_COLOR,
        enableStepTapping: false,
        stepShape: StepShape.circle,
        borderThickness: 1,
        internalPadding: 0,
        unreachedStepTextColor: Styles.DISABLED,
        activeStepTextColor: Styles.PRIMARY_COLOR,
        finishedStepTextColor: Styles.PRIMARY_COLOR,
        showLoadingAnimation: false,
        alignment: Alignment.center,
        stepRadius: 25.w,
        showStepBorder: true,
        steps: List.generate(
          list?.length ?? 0,
          (i) => EasyStep(
            customStep: customCircleSvgIcon(
              imageName: SvgImages.orderStatus(list?[i].statusCode),
              radius: 12.w,
              color: list?[i].createdAt != null
                  ? Styles.PRIMARY_COLOR
                  : Styles.WHITE_COLOR,
              imageColor: list?[i].createdAt != null
                  ? Styles.WHITE_COLOR
                  : Styles.DISABLED,
            ),
            title:
                "${list?[i].status}\n${(list?[i].createdAt?.dateFormat(format: "d-MMM, hh:mm")) ?? ""}",
          ),
        ),
      ),
    );
  }
}
