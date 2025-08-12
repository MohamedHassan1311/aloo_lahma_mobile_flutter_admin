import 'package:aloo_lahma_admin/components/custom_bottom_sheet.dart';
import 'package:aloo_lahma_admin/components/custom_button.dart';
import 'package:aloo_lahma_admin/features/order_details/widgets/order_driver_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aloo_lahma_admin/app/core/extensions.dart';
import 'package:aloo_lahma_admin/app/localization/language_constant.dart';
import 'package:aloo_lahma_admin/components/custom_app_bar.dart';
import 'package:aloo_lahma_admin/components/shimmer/custom_shimmer.dart';
import 'package:aloo_lahma_admin/features/order_details/bloc/order_details_bloc.dart';
import 'package:aloo_lahma_admin/features/order_details/model/order_details_model.dart';
import 'package:aloo_lahma_admin/features/order_details/repo/order_details_repo.dart';
import 'package:http/http.dart';
import '../../../app/core/app_event.dart';
import '../../../app/core/app_state.dart';
import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../components/animated_widget.dart';
import '../../../components/empty_widget.dart';
import '../../../data/config/di.dart';
import '../../change_status/view/change_order_status_view.dart';
import '../../setting/bloc/settings_bloc.dart';
import '../enums/order_details_enums.dart';
import '../widgets/delivery_date.dart';
import '../widgets/delivery_location.dart';
import '../widgets/order_bill_details.dart';
import '../widgets/order_cancel_reason.dart';
import '../widgets/order_payment_method.dart';
import '../widgets/order_products.dart';
import '../widgets/order_status_list.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: getTranslated("order_details"),
      ),
      body: BlocProvider(
        create: (context) => OrderDetailsBloc(repo: sl<OrderDetailsRepo>())
          ..add(Click(arguments: id)),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<OrderDetailsBloc, AppState>(
                  builder: (context, state) {
                    if (state is Done) {
                      OrderDetailsModel model =
                          state.model as OrderDetailsModel;
                      return Column(
                        children: [
                          ///Order Body
                          Expanded(
                            child: ListAnimator(
                              padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                              ),
                              data: [
                                ///Order Number && Date of Creation
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: Dimensions.paddingSizeMini.h),
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.PADDING_SIZE_DEFAULT.w,
                                      vertical:
                                          Dimensions.PADDING_SIZE_DEFAULT.h),
                                  decoration: BoxDecoration(
                                      color: Styles.WHITE_COLOR,
                                      borderRadius: BorderRadius.circular(16.w),
                                      border: Border.all(
                                        color: Styles.LIGHT_BORDER_COLOR,
                                      )),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    spacing: Dimensions.paddingSizeMini.h,
                                    children: [
                                      Text(
                                        "${getTranslated("order_number")}: #${model.orderNum ?? 0000}",
                                        style: AppTextStyles.w700.copyWith(
                                            fontSize: 16, color: Styles.HEADER),
                                      ),
                                      Text(
                                        (model.createdAt ?? DateTime.now())
                                            .dateFormat(
                                                format:
                                                    "d/MMM/yyyy  -  hh:mm aa"),
                                        style: AppTextStyles.w500.copyWith(
                                            fontSize: 14,
                                            color: Styles.DETAILS_COLOR),
                                      ),
                                    ],
                                  ),
                                ),

                                if (model.statuses != null &&
                                    model.statuses!.isNotEmpty)
                                  OrderStatusList(list: model.statuses ?? []),
                                if (model.products != null &&
                                    model.products!.isNotEmpty)
                                  OrderProducts(items: model.products ?? []),
                                DeliveryDate(
                                  date: model.deliveryDay
                                      ?.dateFormat(format: "d-MMM-yyyy"),
                                  time: model.deliveryType ==
                                          ReceiptTypes.delivery
                                      ? model.deliveryTime?.name
                                      : model.timeReceipt,
                                ),
                                DeliveryLocation(
                                  address: model.deliveryType ==
                                          ReceiptTypes.delivery
                                      ? model.address
                                      : sl<SettingsBloc>().model?.address,
                                  receiptType: model.deliveryType ??
                                      ReceiptTypes.delivery,
                                ),
                                OrderPaymentMethod(
                                  payment: model.payType,
                                  bank: model.bank,
                                  bankTransfer: model.bill?.bankTransfer,
                                ),
                                if (model.driver != null)
                                  OrderDriverCard(driver: model.driver!),
                                if (model.cancelReason != null)
                                  OrderCancelReason(
                                      cancelReason: model.cancelReason ?? ''),
                                OrderBillDetails(
                                    bill: model.bill,
                                    deliveryType: model.deliveryType),
                              ],
                            ),
                          ),

                          ///Order Actions
                          // if(model.statusCode != null
                          //     && model.statusCode != OrderStatuses.cancelled
                          //     && model.statusCode != OrderStatuses.completed)
                          Padding(
                            padding:  EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                            vertical: Dimensions.paddingSizeExtraSmall.h,
                            ),
                            child: CustomButton(
                              text: getTranslated("change_order_status"),
                              onTap: () => CustomBottomSheet.show(
                                label:getTranslated("change_order_status"),
                                  widget: ChangeOrderStatusView(model: model)),
                            ),
                          ),
                        ],
                      );
                    }
                    if (state is Loading) {
                      return ListAnimator(
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                        ),
                        data: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeMini.h),
                            child: CustomShimmerContainer(
                              height: 80.h,
                              width: context.width,
                              radius: 16.w,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeMini.h),
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
                                CustomShimmerText(width: 100.w),
                                Divider(
                                  height: Dimensions.PADDING_SIZE_DEFAULT.h,
                                  color: Styles.LIGHT_BORDER_COLOR,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                        5,
                                        (i) => Row(
                                              children: [
                                                CustomShimmerCircleImage(
                                                  diameter: 50.w,
                                                ),
                                                if (i != 4)
                                                  CustomShimmerContainer(
                                                    height: 4.h,
                                                    width: 40.w,
                                                  )
                                              ],
                                            )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeMini.h),
                            child: CustomShimmerContainer(
                              height: 150.h,
                              width: context.width,
                              radius: 16.w,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeMini.h),
                            child: CustomShimmerContainer(
                              height: 160.h,
                              width: context.width,
                              radius: 16.w,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeMini.h),
                            child: CustomShimmerContainer(
                              height: 120.h,
                              width: context.width,
                              radius: 16.w,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeMini.h),
                            child: CustomShimmerContainer(
                              height: 80.h,
                              width: context.width,
                              radius: 16.w,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Dimensions.paddingSizeMini.h),
                            child: CustomShimmerContainer(
                              height: 160.h,
                              width: context.width,
                              radius: 16.w,
                            ),
                          ),
                        ],
                      );
                    }
                    if (state is Error || state is Empty) {
                      return RefreshIndicator(
                        color: Styles.PRIMARY_COLOR,
                        onRefresh: () async {
                          context
                              .read<OrderDetailsBloc>()
                              .add(Click(arguments: id));
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: ListAnimator(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_DEFAULT.w,
                                ),
                                data: [
                                  SizedBox(height: 50.h),
                                  EmptyState(
                                    txt: getTranslated("no_result_found"),
                                    subText: state is Error
                                        ? getTranslated("something_went_wrong")
                                        : getTranslated(
                                            "no_result_found_description"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
