// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/custom_snackbar.dart';
import '../../../../widget/loader.dart';
import '../../address/controllers/address_controller.dart';
import '../../address/widget/addAddress/add_pick_location_view.dart';
import '../../address/widget/editAddress/edit_pick_location_view.dart';
import 'location_permission_dialouge.dart';

class ProfileAddressView extends StatefulWidget {
  const ProfileAddressView({Key? key}) : super(key: key);

  @override
  State<ProfileAddressView> createState() => _ProfileAddressViewState();
}

class _ProfileAddressViewState extends State<ProfileAddressView> {
  @override
  void initState() {
    super.initState();
    Get.find<AddressController>().getAddressList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(
        builder: (addressController) => Stack(
              children: [
                Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    centerTitle: false,
                    elevation: 0,
                    backgroundColor: Colors.white,
                    leading: IconButton(
                      icon: SvgPicture.asset(Images.back),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  body: SingleChildScrollView(
                    primary: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.r),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 16.w, right: 16.w),
                                child: Text(
                                  'MY_ADDRESSES'.tr,
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: EdgeInsets.only(right: 16.r),
                                child: InkWell(
                                  onTap: () => _checkPermission(() {
                                    Get.to(AddPickLocationView());
                                  }),
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(17.r)),
                                    color: AppColor.addNewBtnColor,
                                    child: Padding(
                                      padding: EdgeInsets.all(6.r),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.add_circle,
                                            color: AppColor.primaryColor,
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            'ADD_NEW'.tr,
                                            style: fontRegularWithColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: addressController.addressDataList.length,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding:
                                    EdgeInsets.only(right: 10.w, left: 10.w),
                                child: Container(
                                  margin: EdgeInsets.all(5.r),
                                  height: 90.h,
                                  width: 158.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: AppColor.itembg,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 40.w,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            addressController
                                                        .addressDataList[index]
                                                        .label
                                                        .toString() ==
                                                    "Home"
                                                ? SvgPicture.asset(
                                                    Images.homeIcon,
                                                    fit: BoxFit.cover,
                                                    height: 15.h,
                                                    width: 15.w,
                                                  )
                                                : addressController
                                                            .addressDataList[
                                                                index]
                                                            .label
                                                            .toString() ==
                                                        "Office"
                                                    ? SvgPicture.asset(
                                                        Images.work,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : SvgPicture.asset(
                                                        Images.other,
                                                        fit: BoxFit.cover,
                                                      ),
                                            SvgPicture.asset(
                                              Images.locationIcon,
                                              fit: BoxFit.cover,
                                              height: 18.h,
                                              width: 18.w,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          width: 40.w,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                addressController
                                                    .addressDataList[index]
                                                    .label
                                                    .toString(),
                                                style: fontRegularBold,
                                              ),
                                              Text(
                                                addressController
                                                    .addressDataList[index]
                                                    .address
                                                    .toString(),
                                                style: fontRegular,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40.w,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.to(
                                                    () => EditPickLocationView(
                                                          addressData:
                                                              addressController
                                                                      .addressDataList[
                                                                  index],
                                                        ));
                                              },
                                              child: SvgPicture.asset(
                                                Images.iconEdit,
                                                fit: BoxFit.cover,
                                                height: 18.h,
                                                width: 18.w,
                                                color: AppColor.primaryColor,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                addressController
                                                    .deleletAddress(
                                                        addressController
                                                            .addressDataList[
                                                                index]
                                                            .id!);
                                              },
                                              child: SvgPicture.asset(
                                                Images.iconTrash,
                                                fit: BoxFit.cover,
                                                height: 18.h,
                                                width: 18.w,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                ),
                addressController.deleteAddressLoader
                    ? Positioned(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white60,
                          child: const Center(
                            child: LoaderCircle(),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ));
  }

  void _checkPermission(Function onTap) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied) {
      customSnackbar("ERROR".tr, "LOCATION_SERVICE_DENIED".tr, AppColor.error);
    } else if (permission == LocationPermission.deniedForever) {
      permissionAlert(context).show();
    } else {
      onTap();
    }
  }
}
