// ignore_for_file: prefer_collection_literals, prefer_const_constructors, sort_child_properties_last, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../util/constant.dart';
import '../../../../../util/style.dart';
import '../../../../data/model/response/address_list_model.dart';
import '../../controllers/address_controller.dart';
import '../location_dialouge.dart';
import 'edit_bottom_sheet_address.dart';

class EditPickLocationView extends StatefulWidget {
  AddressListData? addressData;

  EditPickLocationView({Key? key, this.addressData}) : super(key: key);

  @override
  State<EditPickLocationView> createState() => _EditPickLocationViewState();
}

class _EditPickLocationViewState extends State<EditPickLocationView> {
  CameraPosition? _cameraPosition;
  GoogleMapController? _mapController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    Get.find<AddressController>().getCurrentLocation();
    // _setMarker();
  }

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
                          ? LatLng(double.parse(widget.addressData!.latitude!),
                              double.parse(widget.addressData!.longitude!))
                          : LatLng(controller.currentPosition!.latitude,
                              controller.currentPosition!.longitude),
                      zoom: 17),
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  compassEnabled: true,
                  indoorViewEnabled: true,
                  mapToolbarEnabled: true,
                  minMaxZoomPreference: MinMaxZoomPreference(0, 16),
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
                        : CircularProgressIndicator()),
                Positioned(
                  top: 10.h,
                  left: 10.h,
                  right: 10.h,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16))),
                        child: IconButton(
                          icon: SvgPicture.asset(Images.back),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: Get.width - 70.w,
                        child: InkWell(
                          onTap: () => Get.dialog(LocationSearchDialog(
                              mapController: _mapController)),
                          child: Container(
                            height: 50.h,
                            padding: EdgeInsets.symmetric(horizontal: 10.h),
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(16),
                                    bottomRight: Radius.circular(16))),
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
                              child: EditBottomSheetAddress(
                            addressData: widget.addressData,
                          ));
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
