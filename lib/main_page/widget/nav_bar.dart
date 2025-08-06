import 'package:flutter/material.dart';
import 'package:zurex_admin/app/core/dimensions.dart';
import 'package:zurex_admin/app/core/extensions.dart';
import 'package:zurex_admin/app/localization/language_constant.dart';
import '../../app/core/styles.dart';
import '../../app/core/svg_images.dart';
import '../bloc/dashboard_bloc.dart';
import 'nav_bar_item.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: DashboardBloc.instance.selectIndexStream,
      builder: (context, snapshot) {
        return Container(
          width: context.width,
          padding: EdgeInsets.only(left: 8.w, right: 8.w, bottom: 4.h),
          decoration: BoxDecoration(
            color: Styles.WHITE_COLOR,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  offset: const Offset(0, -1),
                  spreadRadius: 1,
                  blurRadius: 10)
            ],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: BottomNavBarItem(
                      label: getTranslated("orders", context: context),
                      svgIcon: SvgImages.orders,
                      isSelected: (snapshot.data ?? 0) == 0,
                      onTap: () {
                        DashboardBloc.instance.updateSelectIndex(0);
                      }),
                ),
                Expanded(
                  child: BottomNavBarItem(
                    label: getTranslated("more", context: context),
                    svgIcon: SvgImages.setting,
                    isSelected: (snapshot.data ?? 0) == 1,
                    onTap: () {
                      DashboardBloc.instance.updateSelectIndex(1);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
