import 'package:Al_Arqam/view/auth/nesseccary_login_screen.dart';
import 'package:Al_Arqam/view/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:Al_Arqam/core/resources/color_manager.dart';
import 'package:Al_Arqam/core/resources/global_functions.dart';
import 'package:Al_Arqam/view/Map/controller/map_controller.dart';
import 'package:Al_Arqam/view/main_controller.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomGoogleMapState createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
 
  MainController controller=Get.find<MainController>();
  final LatLng _center = const LatLng(21.4225, 39.8262);
  final Map<PolylineId, Polyline> _polylines = {};

  final String _mapStyle = '''
  [
    {
      "elementType": "geometry",
      "stylers": [{"color": "#F3EADA"}]
    },
    {
      "featureType": "road",
      "elementType": "geometry",
      "stylers": [{"color": "#D6D6D6"}]
    },
    {
      "featureType": "water",
      "elementType": "geometry",
      "stylers": [{"color": "#F5F5DD"}]
    }
  ]
  ''';

  @override
  void initState() {
    super.initState();
   
  }


  @override
  Widget build(BuildContext context) {
   
    return
    !GlobalFunctions.isAuth()?
    NesseccaryLoginScreen(namePage:'necessary_map_message'.tr,):
     PopScope(
       canPop: false,
            onPopInvoked: (_) async {
              controller.showMap.value=false;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainScreen()),
          (Route<dynamic> route) => false, 
        );
       
      },
       child: Scaffold(
           extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: GetBuilder<MainController>(
          builder: (controller) {
            return GetBuilder<MapController>(
              builder: (context) {
                return Stack(
                  children: [
                    Opacity(
                      opacity:    controller.isLoading.value? 0.5:1,
                      child: GoogleMap(
                        myLocationButtonEnabled:
                                                                true,
                                                                onTap:(v){
       
                                                                },
                        onMapCreated: (GoogleMapController mapcontroller) {
                                    
                          controller.mapController = mapcontroller;
                          // ignore: deprecated_member_use
                          controller.mapController!.setMapStyle(_mapStyle);
                        },
                        initialCameraPosition: CameraPosition(
                          target:controller.currentPosition.isEmpty?const LatLng(21.4225, 39.8262) : LatLng(double.parse(controller.currentPosition.split(" ")[0]), double.parse(controller.currentPosition.split(" ")[1])),
                          zoom: 12.0,
                        ),
                        myLocationEnabled: false,
                        polylines: _polylines.values.toSet(),
                        markers: controller.markers,
                        // onTap: (LatLng latLng) {
                        //   setState(() {
                        //     _markers.add(
                        //       Marker(
                        //         markerId: const MarkerId('custom_marker'),
                        //         position: latLng,
                        //         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                        //       ),
                        //     );
                        //   });
                        // },
                      ),
                    ),
                    Visibility(
                      visible: controller.isLoading.value,
                      child:  Center(child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 150.h),
                            child: Center(
                                child: GlobalFunctions.showLoading(
                                    AppColors.primary,
                                    size: 18.sp)),
                          )),
                    ),
                  ],
                );
              }
            );
          }
        ),
        
          
           ),
     );
  }
}