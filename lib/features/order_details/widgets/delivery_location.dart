import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:aloo_lahma_admin/app/core/app_strings.dart';
import 'package:aloo_lahma_admin/app/core/extensions.dart';
import 'package:aloo_lahma_admin/app/core/svg_images.dart';
import 'package:aloo_lahma_admin/components/custom_images.dart';
import 'package:aloo_lahma_admin/features/maps/models/location_model.dart';
import 'package:aloo_lahma_admin/features/order_details/model/order_details_model.dart';
import 'package:aloo_lahma_admin/navigation/custom_navigation.dart';

import '../../../app/core/dimensions.dart';
import '../../../app/core/styles.dart';
import '../../../app/core/text_styles.dart';
import '../../../app/localization/language_constant.dart';
import '../../../navigation/routes.dart';

class DeliveryLocation extends StatelessWidget {
  const DeliveryLocation({super.key, this.address});
  final AddressModel? address;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomNavigator.push(
          Routes.previewLocation,
          arguments: LocationModel(
            latitude: address?.latitude,
            longitude: address?.longitude,
            onChange: (v) => CustomNavigator.pop(),
          ),
        );
      },
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
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
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    customImageIconSVG(
                        imageName: SvgImages.location,
                        color: Styles.HEADER,
                        width: 18.w,
                        height: 18.w),
                    SizedBox(width: Dimensions.paddingSizeMini.w),
                    Expanded(
                      child: Text(
                        getTranslated("delivery_address"),
                        style: AppTextStyles.w700
                            .copyWith(fontSize: 16, color: Styles.HEADER),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Dimensions.PADDING_SIZE_SMALL.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.w),
                    child: SizedBox(
                      height: 160.h,
                      width: context.width,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          bearing: 192,
                          target: LatLng(
                            address?.latitude ?? AppStrings.defaultLat,
                            address?.longitude ?? AppStrings.defaultLong,
                          ),
                          zoom: 18,
                        ),
                        minMaxZoomPreference:
                            const MinMaxZoomPreference(0, 100),
                        myLocationButtonEnabled: false,
                        myLocationEnabled: false,
                        onMapCreated: (GoogleMapController mapController) {
                          mapController
                              .animateCamera(CameraUpdate.newLatLngZoom(
                                  LatLng(
                                    address?.latitude ?? AppStrings.defaultLat,
                                    address?.longitude ??
                                        AppStrings.defaultLong,
                                  ),
                                  18));
                        },
                        scrollGesturesEnabled: true,
                        zoomControlsEnabled: false,
                        onCameraMove: (CameraPosition cameraPosition) {},
                        markers: {
                          Marker(
                            markerId: MarkerId('1'),
                            position: LatLng(
                              address?.latitude ?? AppStrings.defaultLat,
                              address?.longitude ?? AppStrings.defaultLong,
                            ),
                          )
                        },
                      ),
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                      text: "${getTranslated("address_details")}: ",
                      style: AppTextStyles.w700
                          .copyWith(fontSize: 14, color: Styles.HEADER),
                      children: [
                        TextSpan(
                          text:
                              address?.fullAddress ?? AppStrings.defaultAddress,
                          style: AppTextStyles.w500
                              .copyWith(fontSize: 14, color: Styles.TITLE),
                        )
                      ]),
                ),
              ],
            ),
            InkWell(
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                CustomNavigator.push(
                  Routes.previewLocation,
                  arguments: LocationModel(
                    latitude: address?.latitude,
                    longitude: address?.longitude,
                    onChange: (v) => CustomNavigator.pop(),
                  ),
                );
              },
              child: SizedBox(
                height: 160.h,
                width: context.width,
              ),
            )
          ],
        ),
      ),
    );
  }
}
