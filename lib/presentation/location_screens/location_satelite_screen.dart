import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mineclaim/core/app_export.dart';
import '../../widgets/app_bar/appbar_subtitle_two.dart';
import '../../widgets/app_bar/custom_app_bar.dart';


// ignore_for_file: must_be_immutable
class HomeListingSateliteScreen extends StatelessWidget {
  HomeListingSateliteScreen({Key? key}) : super(key: key);

  Completer<GoogleMapController> googleMapController = Completer();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
            height: double.maxFinite,
            width: double.maxFinite,
            child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    target: LatLng(37.43296265331129, -122.08832357078792),
                    zoom: 14.4746),
                onMapCreated: (GoogleMapController controller) {
                  googleMapController.complete(controller);
                },
                zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
                myLocationButtonEnabled: false,
                myLocationEnabled: false)
        ),
     floatingActionButton: FloatingActionButton.extended(
      backgroundColor: Colors.white,
      foregroundColor: Colors.blue,
      onPressed: () {
       // Respond to button press
      },
      icon: Icon(Icons.add),
      label: Text(
          'Continue',
       style: TextStyle(
         fontWeight: FontWeight.w700,
        fontSize: 16
       ),
      ),
     )

    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
   return CustomAppBar(
    leadingWidth: 64.h,
    leading: IconButton(
     icon: Icon(Icons.arrow_back, color: Colors.black),
     onPressed: () => Navigator.of(context).pop(),
    ),

    centerTitle: true,
    title: AppbarSubtitleTwo(text: "Select Mine Location"),
    // styleType: Style.bgFill
   );
  }

}
