// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/loader.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/profile_controller.dart';

class EditProfileView extends StatefulWidget {
  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool validate = false;

  @override
  Widget build(BuildContext context) {
    SplashController splashController = Get.put(SplashController());
    return GetBuilder<ProfileController>(
      builder: (profileController) => Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
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
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.h),
                      child: Text(
                        'EDIT_PROFILE'.tr,
                        style: fontMedium,
                      ),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'FIRST_NAME'.tr,
                            style: fontProfileLite,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            controller: profileController.firstNameController,
                            validator: (value) => value!.isEmpty
                                ? 'PLEASE_TYPE_FIRST_NAME'.tr
                                : null,
                            decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  width: 1.w,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  width: 1.w,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                              fillColor: Colors.red,
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.r)),
                                borderSide: BorderSide(
                                    color: AppColor.primaryColor, width: 1.w),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.r),
                                ),
                                borderSide: BorderSide(
                                    width: 1.w, color: AppColor.dividerColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(
                            'LAST_NAME'.tr,
                            style: fontProfileLite,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            controller: profileController.lastNameController,
                            validator: (value) => value!.isEmpty
                                ? 'PLEASE_TYPE_LAST_NAME'.tr
                                : null,
                            decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  width: 1.w,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  width: 1.w,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                              fillColor: Colors.red,
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.r)),
                                borderSide: BorderSide(
                                    color: AppColor.primaryColor, width: 1.w),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.r),
                                ),
                                borderSide: BorderSide(
                                    width: 1.w, color: AppColor.dividerColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(
                            'EMAIL'.tr,
                            style: fontProfileLite,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            controller: profileController.emailController,
                            validator: (value) => value!.isEmpty
                                ? 'PLEASE_TYPE_EMAIL'.tr
                                : value.toString() == 'null'
                                    ? 'PLEASE_TYPE_EMAIL'.tr
                                    : null,
                            decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  width: 1.w,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  width: 1.w,
                                  color: AppColor.primaryColor,
                                ),
                              ),
                              fillColor: Colors.red,
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.r)),
                                borderSide: BorderSide(
                                    color: AppColor.primaryColor, width: 1.w),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.r)),
                                borderSide: BorderSide(
                                    width: 1.w, color: AppColor.dividerColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(
                            'MOBILE_NUMBER'.tr,
                            style: fontProfileLite,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          SizedBox(
                            height: 56.h,
                            child: Row(
                              children: [
                                Container(
                                  width: 100.w,
                                  height: 56.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(
                                          color: AppColor.dividerColor)),
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(splashController
                                            .countryInfoData.flagEmoji!),
                                        SizedBox(
                                          width: 6.w,
                                        ),
                                        Text(splashController
                                            .countryInfoData.callingCode!),
                                      ]),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller:
                                        profileController.mobileController,
                                    keyboardType: TextInputType.number,
                                    // validator: (value) => value!.isEmpty
                                    //     ? 'Please type Mobile Number'
                                    //     : null,
                                    decoration: InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: BorderSide(
                                          width: 1.w,
                                          color: AppColor.primaryColor,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: BorderSide(
                                          width: 1.w,
                                          color: AppColor.primaryColor,
                                        ),
                                      ),
                                      fillColor: Colors.red,
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.r)),
                                        borderSide: BorderSide(
                                            color: AppColor.primaryColor,
                                            width: 1.w),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: BorderSide(
                                            width: 1.w,
                                            color: AppColor.dividerColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // SizedBox(
                              //   width: 156.w,
                              //   child: ElevatedButton(
                              //     onPressed: () {},
                              //     style: ElevatedButton.styleFrom(
                              //       backgroundColor: AppColor.deleteBtnColor,
                              //       minimumSize: Size(156.w, 48.h),
                              //       shape: RoundedRectangleBorder(
                              //         borderRadius: BorderRadius.circular(24.r),
                              //       ),
                              //     ),
                              //     child: Text(
                              //       "DELETE_ACCOUNT".tr,
                              //       maxLines: 2,
                              //       style: fontMedium,
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(
                              //   width: 16.w,
                              // ),
                              SizedBox(
                                width: Get.width - 50,
                                child: ElevatedButton(
                                  onPressed: () {
                                    validateAndSave(context);
                                    (context as Element).markNeedsBuild();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primaryColor,
                                    minimumSize: Size(156.w, 48.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.r),
                                    ),
                                  ),
                                  child: Text(
                                    "UPDATE_PROFILE".tr,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: fontMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          profileController.updateProfileLodear
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
      ),
    );
  }

  void validateAndSave(context) {
    final FormState? form = _formKey.currentState;
    if (form!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      Get.find<ProfileController>().updateUserProfile(context);
      validate = true;
    } else {
      validate = false;
    }
  }
}
