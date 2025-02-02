// ignore_for_file: sort_child_properties_last, prefer_const_constructors, unused_element, prefer_collection_literals, prefer_const_constructors_in_immutables, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../util/constant.dart';
import '../../../../../util/style.dart';
import '../../controllers/address_controller.dart';
import '../location_dialouge.dart';
import 'add_bottom_sheet_address.dart';

class AddPickLocationView extends StatefulWidget {
  AddPickLocationView({Key? key}) : super(key: key);

  @override
  State<AddPickLocationView> createState() => _AddPickLocationViewState();
}

class _AddPickLocationViewState extends State<AddPickLocationView> {
  LatLng? _initialPosition;
  CameraPosition? _cameraPosition;
  GoogleMapController? _mapController;

  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    Get.find<AddressController>().getCurrentLocation();
    _initialPosition = LatLng(
      double.parse(
          Get.find<AddressController>().currentPosition!.latitude.toString()),
      double.parse(
          Get.find<AddressController>().currentPosition!.longitude.toString()),
    );
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          child: Center(
              child: GetBuilder<AddressController>(
            builder: (controller) => Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: controller.pickPosition.latitude != 0
                          ? LatLng(controller.pickPosition.latitude,
                              controller.pickPosition.longitude)
                          : LatLng(controller.pickPosition.latitude,
                              controller.pickPosition.longitude),
                      zoom: 17),
                  zoomControlsEnabled: false,
                  myLocationEnabled: false,
                  compassEnabled: false,
                  indoorViewEnabled: true,
                  mapToolbarEnabled: true,
                  minMaxZoomPreference: const MinMaxZoomPreference(0, 16),
                  onMapCreated: (GoogleMapController mapController) {
                    _mapController = mapController;
                    controller.getCurrentLocation();
                  },
                  onCameraMove: (CameraPosition cameraPosition) {
                    _cameraPosition = cameraPosition;
                    controller.updatePosition(_cameraPosition!);
                  },
                  // onCameraIdle: () {
                  //   controller.updatePosition(_cameraPosition!);
                  // },
                ),
                Center(
                    child: !controller.isLoading
                        ? Image.asset(Images.marker, height: 50, width: 50)
                        : const CircularProgressIndicator()),
                Positioned(
                  top: 10.h,
                  left: 10.w,
                  right: 10.w,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: box.read('languageCode') == 'ar'
                                ? BorderRadius.only(
                                    topRight: Radius.circular(16.r),
                                    bottomRight: Radius.circular(16.r))
                                : BorderRadius.only(
                                    topLeft: Radius.circular(16.r),
                                    bottomLeft: Radius.circular(16.r))),
                        child: IconButton(
                          icon: SvgPicture.asset(Images.back),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 48,
                        width: Get.width - 70.w,
                        child: InkWell(
                          onTap: () => Get.dialog(LocationSearchDialog(
                              mapController: _mapController)),
                          child: Container(
                            height: 48.h,
                            padding: EdgeInsets.symmetric(horizontal: 10.h),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: box.read('languageCode') == 'ar'
                                    ? BorderRadius.only(
                                        topLeft: Radius.circular(16.r),
                                        bottomLeft: Radius.circular(16.r))
                                    : BorderRadius.only(
                                        topRight: Radius.circular(16.r),
                                        bottomRight: Radius.circular(16.r))),
                            child: Row(children: [
                              const Icon(Icons.location_on,
                                  size: 25, color: Colors.grey),
                              SizedBox(width: 10.h),
                              Expanded(
                                child: Text(
                                  controller.pickAddress,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 10.h),
                              const Icon(Icons.search,
                                  size: 25, color: Colors.grey),
                            ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 80,
                  right: 10,
                  child: FloatingActionButton(
                    child:
                        Icon(Icons.my_location, color: AppColor.primaryColor),
                    mini: true,
                    backgroundColor: Theme.of(context).cardColor,
                    onPressed: () {
                      controller.getCurrentLocationWhenTapped(_mapController!);
                    },
                  ),
                ),
                Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: ElevatedButton(
                      onPressed: () {
                        scaffoldKey.currentState!.showBottomSheet((context) {
                          return SingleChildScrollView(
                              child: AddBottomSheetAddress());
                        });
                      },
                      style: !controller.isLoading
                          ? ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryColor,
                              minimumSize: Size(328.w, 52.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                            )
                          : ElevatedButton.styleFrom(
                              backgroundColor: AppColor.gray,
                              minimumSize: Size(328.w, 52.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                            ),
                      child: Text(
                        "CONFIRM_LOCATION".tr,
                        style: fontMedium,
                      ),
                    )),
              ],
            ),
          )),
        ));
  }
}
