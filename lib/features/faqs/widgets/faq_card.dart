import 'package:flutter/material.dart';
import 'package:aloo_lahma_admin/app/core/dimensions.dart';
import 'package:aloo_lahma_admin/app/core/extensions.dart';
import 'package:aloo_lahma_admin/app/core/methods.dart';
import 'package:aloo_lahma_admin/app/core/text_styles.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../app/core/styles.dart';
import '../../../components/shimmer/custom_shimmer.dart';
import '../model/faq_model.dart';

class FaqCard extends StatefulWidget {
  const FaqCard({super.key, required this.question, required this.index});
  final FaqModel question;
  final int index;

  @override
  State<FaqCard> createState() => _FaqCardState();
}

class _FaqCardState extends State<FaqCard> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation rotationAnimation;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    animationController.addListener(() => setState(() {}));

    if (widget.index == 1) {
      if (animationController.isCompleted) {
        animationController.reverse();
      } else {
        animationController.forward();
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeMini.h),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
        vertical: Dimensions.PADDING_SIZE_DEFAULT.h,
      ),
      decoration: BoxDecoration(
          color: Styles.WHITE_COLOR,
          borderRadius: BorderRadius.circular(12.w),
          border: Border.all(
              color: animationController.isForwardOrCompleted
                  ? Styles.PRIMARY_COLOR
                  : Styles.LIGHT_BORDER_COLOR)),
      child: Column(
        children: [
          Row(
            spacing: Dimensions.paddingSizeExtraSmall.w,
            children: [
              Expanded(
                child: Text(
                  "${(widget.index.toString()).padLeft(2, '0')}  ${widget.question.question ?? ""}",
                  style: AppTextStyles.w700
                      .copyWith(fontSize: 16, color: Styles.HEADER),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (animationController.isCompleted) {
                    animationController.reverse();
                  } else {
                    animationController.forward();
                  }
                },
                child: Transform(
                  transform: Matrix4.rotationZ(
                    Methods.getRadiansFromDegree(rotationAnimation.value),
                  ),
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: animationController.isForwardOrCompleted
                        ? Styles.WHITE_COLOR
                        : Styles.PRIMARY_COLOR,
                    radius: 12,
                    child: Icon(
                      animationController.isForwardOrCompleted
                          ? Icons.clear
                          : Icons.add,
                      color: animationController.isForwardOrCompleted
                          ? Styles.PRIMARY_COLOR
                          : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          AnimatedCrossFade(
            crossFadeState: (animationController.isForwardOrCompleted)
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 300),
            firstChild: Padding(
              padding: EdgeInsets.only(top: Dimensions.paddingSizeMini.h),
              child: HtmlWidget(
                widget.question.answer ?? '',
                textStyle: AppTextStyles.w400
                    .copyWith(fontSize: 14, color: Styles.DETAILS_COLOR),
              ),
            ),
            secondChild: const SizedBox(),
          ),
        ],
      ),
    );
  }
}

class QuestionCardShimmer extends StatelessWidget {
  const QuestionCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall.h),
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.PADDING_SIZE_SMALL.w,
          vertical: Dimensions.paddingSizeExtraSmall.h),
      decoration: BoxDecoration(
        color: Styles.WHITE_COLOR,
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomShimmerText(height: 20.h, width: context.width * 0.6),
          SizedBox(height: 12.h),
          ...List.generate(
            4,
            (i) => Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: CustomShimmerText(height: 15.h, width: context.width),
            ),
          ),
        ],
      ),
    );
  }
}
