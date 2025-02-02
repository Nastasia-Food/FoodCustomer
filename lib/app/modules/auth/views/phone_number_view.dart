// ignore_for_file: unused_local_variable, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/loader.dart';
import '../controllers/auth_controller.dart';
import 'login_view.dart';

class PhoneNumberView extends StatefulWidget {
  bool? isGuest;
  PhoneNumberView({Key? key, this.isGuest}) : super(key: key);

  @override
  State<PhoneNumberView> createState() => _PhoneNumberViewState();
}

class _PhoneNumberViewState extends State<PhoneNumberView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  bool validate = false;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    return GetBuilder<AuthController>(
      builder: (authController) => Stack(
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
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Image.asset(
                      Images.logo,
                      height: 60.h,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Text(
                      widget.isGuest!
                          ? 'GUEST_LOGIN'.tr
                          : 'LETS_GET_STARTED'.tr,
                      style: TextStyle(
                          fontSize: 26.sp,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 41.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            // ignore: avoid_print
                            print(box.read('countryFlag').toString());
                          },
                          child: Text(
                            'MOBILE_NUMBER'.tr,
                            style: fontMedium,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(box.read('countryFlag').toString()),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                      Text(box.read('countryCode').toString()),
                                    ]),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Expanded(
                                child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    controller: _phoneController,
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
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            final FormState? form = _formKey.currentState;
                            if (form!.validate()) {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (widget.isGuest!) {
                                authController.guestPhoneNumberSignUp(
                                    _phoneController.text);
                              } else {
                                authController
                                    .phoneNumberSignUp(_phoneController.text);
                              }
                              validate = true;
                            } else {
                              validate = false;
                            }
                            (context as Element).markNeedsBuild();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                            minimumSize: Size(328.w, 52.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                          ),
                          child: Text(
                            "CONTINUE".tr,
                            style: fontMedium,
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('ALREADY_HAVE_AN_ACCOUNT'.tr,
                                style: TextStyle(
                                    fontFamily: 'Rubik',
                                    color: AppColor.textSignupColor,
                                    fontSize: 12.sp)),
                            SizedBox(
                              width: 8.w,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => LoginView());
                              },
                              child: Text(
                                'LOGIN'.tr,
                                style: const TextStyle(
                                    fontFamily: 'Rubik',
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          authController.loader
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
}
