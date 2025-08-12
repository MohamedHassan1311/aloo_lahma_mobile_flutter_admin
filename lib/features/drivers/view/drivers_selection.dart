import 'package:aloo_lahma_admin/app/core/extensions.dart';
import 'package:aloo_lahma_admin/features/drivers/bloc/drivers_bloc.dart';
import 'package:aloo_lahma_admin/features/drivers/repo/drivers_repo.dart';
import 'package:aloo_lahma_admin/main_models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../app/core/app_notification.dart';
import '../../../../../app/core/styles.dart';
import '../../../../../app/core/svg_images.dart';
import '../../../../../app/core/text_styles.dart';
import '../../../../../app/localization/language_constant.dart';
import '../../../../../components/custom_bottom_sheet.dart';
import '../../../app/core/app_core.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/app_state.dart';
import '../../../app/core/dimensions.dart';
import '../../../components/animated_widget.dart';
import '../../../components/custom_loading_text.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../data/config/di.dart';
import '../../../data/internet_connection/internet_connection.dart';
import '../../../main_models/search_engine.dart';
import '../../../navigation/custom_navigation.dart';

class DriversSelection extends StatefulWidget {
  const DriversSelection(
      {super.key,
      this.onSelect,
      this.initialSelection,
      this.focusNode,
      this.nextFocus,
      this.validate});
  final Function(UserModel)? onSelect;
  final UserModel? initialSelection;
  final FocusNode? focusNode, nextFocus;
  final String? Function(String?)? validate;

  @override
  State<DriversSelection> createState() => _DriversSelectionState();
}

class _DriversSelectionState extends State<DriversSelection> {
  UserModel? _selectedItem;

  @override
  void initState() {
    setState(() {
      if (widget.initialSelection != null) {
        _selectedItem = widget.initialSelection;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriversBloc(
          repo: sl<DriversRepo>(), internetConnection: sl<InternetConnection>())
        ..add(Click(arguments: SearchEngine())),
      child: BlocBuilder<DriversBloc, AppState>(
        builder: (context, state) {
          return CustomTextField(
            label: getTranslated("driver"),
            hint: getTranslated("select_driver"),
            controller: TextEditingController(text: _selectedItem?.name),
            onTap: () {
              if (state is Done) {
                CustomBottomSheet.show(
                  label: getTranslated("select_driver"),
                  onConfirm: () => CustomNavigator.pop(),
                  widget: BlocProvider.value(
                    value: context.read<DriversBloc>(),
                    child: BlocBuilder<DriversBloc, AppState>(
                        builder: (context, state) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: _SelectionView(
                              controller:
                                  context.read<DriversBloc>().controller,
                              list: (state as Done).list as List<UserModel>,
                              initialValue: widget.initialSelection,
                              onConfirm: (v) {
                                setState(() {
                                  _selectedItem = v;
                                });
                                widget.onSelect?.call(v);
                              },
                            ),
                          ),
                          CustomLoadingText(loading: state.loading),
                        ],
                      );
                    }),
                  ),
                );
              }
              if (state is Loading) {
                AppCore.showSnackBar(
                    notification: AppNotification(
                  message: getTranslated("loading"),
                  backgroundColor: Styles.PENDING,
                ));
              }
              if (state is Error) {
                AppCore.showSnackBar(
                    notification: AppNotification(
                  message: getTranslated("something_went_wrong"),
                  backgroundColor: Styles.ERORR_COLOR,
                ));
              }
              if (state is Empty) {
                AppCore.showSnackBar(
                    notification: AppNotification(
                  message: getTranslated("there_is_no_data"),
                  backgroundColor: Styles.PENDING,
                ));
              }
            },
            readOnly: true,
            focusNode: widget.focusNode,
            nextFocus: widget.nextFocus,
            validate: widget.validate,
            pSvgIcon: SvgImages.driver,
            sufWidget: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
              child: Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Styles.DETAILS_COLOR,
                size: 24,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SelectionView extends StatefulWidget {
  const _SelectionView(
      {required this.onConfirm,
      required this.list,
      this.initialValue,
      required this.controller});
  final ValueChanged<UserModel> onConfirm;
  final List<UserModel> list;
  final UserModel? initialValue;
  final ScrollController controller;

  @override
  State<_SelectionView> createState() => _SelectionViewState();
}

class _SelectionViewState extends State<_SelectionView> {
  UserModel? _selectedItem;
  @override
  void initState() {
    setState(() {
      if (widget.initialValue != null) {
        _selectedItem = widget.initialValue;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListAnimator(
      controller: widget.controller,
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
      data: List.generate(
        widget.list.length,
        (index) => GestureDetector(
          onTap: () {
            setState(() => _selectedItem = widget.list[index]);
            widget.onConfirm(widget.list[index]);
          },
          child: Container(
            margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL.h),
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                vertical: Dimensions.PADDING_SIZE_SMALL.h),
            decoration: BoxDecoration(
              color: _selectedItem?.id == widget.list[index].id
                  ? Styles.PRIMARY_COLOR
                  : Styles.WHITE_COLOR,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: _selectedItem?.id == widget.list[index].id
                      ? Styles.WHITE_COLOR
                      : Styles.PRIMARY_COLOR),
            ),
            width: context.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.list[index].name ?? "",
                    style: AppTextStyles.w600.copyWith(
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                      color: _selectedItem?.id == widget.list[index].id
                          ? Styles.WHITE_COLOR
                          : Styles.PRIMARY_COLOR,
                    ),
                  ),
                ),
                Icon(
                    _selectedItem?.id == widget.list[index].id
                        ? Icons.radio_button_checked_outlined
                        : Icons.radio_button_off,
                    size: 22,
                    color: _selectedItem?.id == widget.list[index].id
                        ? Styles.WHITE_COLOR
                        : Styles.PRIMARY_COLOR)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
