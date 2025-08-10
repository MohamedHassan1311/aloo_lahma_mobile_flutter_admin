import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ListAnimator extends StatelessWidget {
  final List<Widget>? data;
  final int? durationMilli;
  final double? verticalOffset;
  final double? horizontalOffset;
  final ScrollController? controller;
  final direction;
  final bool addPadding;
  final bool reverse;
  final bool scroll;
  final bool shrinkWrap;
  final EdgeInsets? padding;
  final CrossAxisAlignment? crossAxisAlignment;

  const ListAnimator({
    this.controller,
    super.key,
    this.data,
    this.durationMilli,
    this.verticalOffset,
    this.horizontalOffset,
    this.direction,
    this.addPadding = true,
    this.reverse = false,
    this.padding,
    this.crossAxisAlignment,
    this.scroll = true,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      padding: padding ?? EdgeInsets.only(top: addPadding ? 0 : 0),
      physics: scroll
          ? const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())
          : const NeverScrollableScrollPhysics(),
      reverse: reverse,
      scrollDirection: direction ?? Axis.vertical,
      itemCount: data?.length ?? 0,
      shrinkWrap: shrinkWrap,
      itemBuilder: (c, i) => data?[i].animate().scale(
            delay: Duration(milliseconds: i * 10),
          ),
    ).animate().slideY(
        end: 0,
        begin: 0.4,
        curve: Curves.easeOut,
        duration: Duration(milliseconds: 700));
  }
}
