import 'package:aloo_lahma_admin/app/core/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../app/core/images.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Images.logo,
          height: context.width * 0.7,
          width: context.width * 0.7,
        ).animate(onPlay: (controller) => controller.repeat()).shimmer(
              duration: .5.seconds,
            ),
      ],
    ));
  }
}
