import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zurex_admin/app/core/extensions.dart';
import 'package:zurex_admin/app/localization/language_constant.dart';
import 'package:zurex_admin/components/custom_app_bar.dart';
import 'package:zurex_admin/features/maps/models/location_model.dart';

import '../../../app/core/app_strings.dart';

class PreviewLocationPage extends StatelessWidget {
  const PreviewLocationPage({super.key, required this.location});
  final LocationModel location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated("location")),
      body: SizedBox(
        height: context.height,
        width: context.width,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            bearing: 192,
            target: LatLng(
              location.latitude ?? AppStrings.defaultLat,
              location.longitude ?? AppStrings.defaultLong,
            ),
            zoom: 18,
          ),
          minMaxZoomPreference: const MinMaxZoomPreference(0, 100),
          myLocationButtonEnabled: false,
          myLocationEnabled: false,
          onMapCreated: (c) {
            c.animateCamera(CameraUpdate.newLatLngZoom(
                LatLng(
                  location.latitude ?? AppStrings.defaultLat,
                  location.longitude ?? AppStrings.defaultLong,
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
                location.latitude ?? AppStrings.defaultLat,
                location.longitude ?? AppStrings.defaultLong,
              ),
            )
          },
        ),
      ),
    );
  }
}
