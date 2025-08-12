import 'package:aloo_lahma_admin/app/core/extensions.dart';
import 'package:aloo_lahma_admin/features/change_status/bloc/change_status_bloc.dart';
import 'package:aloo_lahma_admin/features/change_status/entity/change_status_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/svg_images.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/core/validation.dart';
import '../../../app/localization/language_constant.dart';
import '../../../components/custom_bottom_sheet.dart';
import '../../../components/custom_images.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../data/config/di.dart';
import '../../../helpers/date_time_picker.dart';
import '../../delivery_times/bloc/order_delivery_times_bloc.dart';
import '../../delivery_times/repo/order_delivery_times_repo.dart';
import '../../delivery_times/view/order_delivery_slots.dart';
import '../../order_details/enums/order_details_enums.dart';
import 'order_delivery_time.dart';

class OrderSchedule extends StatelessWidget {
  const OrderSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderDeliveryTimesBloc(repo: sl<OrderDeliveryTimesRepo>()),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_SMALL.w,
            vertical: Dimensions.PADDING_SIZE_SMALL.h),
        decoration: BoxDecoration(
            color: Styles.WHITE_COLOR,
            borderRadius: BorderRadius.circular(16.w),
            border: Border.all(color: Styles.LIGHT_BORDER_COLOR)),
        child: StreamBuilder<ChangeStatusEntity?>(
            stream: context.read<ChangeStatusBloc>().changeStatusEntityStream,
            builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Title
                  Row(
                    spacing: Dimensions.paddingSizeMini.w,
                    children: [
                      customImageIconSVG(
                          imageName: SvgImages.calendar,
                          color: Styles.PRIMARY_COLOR,
                          width: 24.w,
                          height: 24.w),
                      Expanded(
                        child: Text(
                          getTranslated("delivery_date_time"),
                          style: AppTextStyles.w700
                              .copyWith(fontSize: 16, color: Styles.HEADER),
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 24.h, color: Styles.LIGHT_BORDER_COLOR),

                  ///Delivery Date
                  CustomTextField(
                    fillColor: Styles.SMOKED_WHITE_COLOR,
                    isFillColor: true,
                    onTap: () => CustomBottomSheet.general(
                      widget: DateTimePicker(
                        mode: CupertinoDatePickerMode.date,
                        startDateTime: snapshot.data?.deliveryDate ??
                            DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day,
                            ),
                        minDateTime: DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                        ),
                        valueChanged: (v) {
                          context.read<ChangeStatusBloc>().updateChangeStatusEntity(snapshot.data?.copyWith(deliveryDate: v, clearDeliveryTime: true,));
                          if (snapshot.data?.receiptType ==
                              ReceiptTypes.delivery) {
                            context.read<OrderDeliveryTimesBloc>()
                                .add(Click(arguments: {
                                  "shipping_id": snapshot.data?.address?.id,
                                  "date":
                                      v.dateFormat(format: "y-MM-d", lang: "en")
                                }));
                          }
                        },
                        label: getTranslated("delivery_date"),
                      ),
                    ),
                    readOnly: true,
                    controller: TextEditingController(
                        text: snapshot.data?.deliveryDate
                            ?.dateFormat(format: "d/MMM/yyyy")),
                    label: getTranslated("delivery_date"),
                    hint: getTranslated("select_delivery_date"),
                    validate: (v) => Validations.field(
                        snapshot.data?.deliveryDate
                            ?.dateFormat(format: "d/MMM/yyyy"),
                        fieldName: getTranslated("select_delivery_date")),
                    pSvgIcon: SvgImages.calendarDay,
                    sufWidget: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 24,
                        color: Styles.HINT_COLOR,
                      ),
                    ),
                  ),

                  ///Delivery Time
                  snapshot.data?.receiptType == ReceiptTypes.delivery
                      ? OrderDeliverySlots(
                          selectedSlot: snapshot.data?.deliveryTime,
                          onSelect: (v) => context
                              .read<ChangeStatusBloc>()
                              .updateChangeStatusEntity(
                                  snapshot.data?.copyWith(deliveryTime: v)),
                        )
                      : OrderDeliveryTime(
                          receiptTime: snapshot.data?.receiptTime,
                          deliveryDate: snapshot.data?.deliveryDate,
                          onSelect: (v) {
                            if (context
                                .read<ChangeStatusBloc>()
                                .isReceiptTimeValid(
                                    selectedTime: v,
                                    selectedDate: snapshot.data!.deliveryDate!)) {
                              context
                                  .read<ChangeStatusBloc>()
                                  .updateChangeStatusEntity(
                                      snapshot.data?.copyWith(receiptTime: v));
                            }
                          },
                        ),

                ],
              );
            }),
      ),
    );
  }
}
