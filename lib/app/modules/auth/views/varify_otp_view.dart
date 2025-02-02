// ignore_for_file: must_be_immutable, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinput/pinput.dart';

import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/loader.dart';
import '../controllers/auth_controller.dart';

class VeryfiyOtpView extends StatefulWidget {
  String? phoneNumber;
  bool? isGuest;
  bool? forgetPassword;
  VeryfiyOtpView(
      {Key? key, this.phoneNumber, this.isGuest, this.forgetPassword})
      : super(key: key);
  @override
  State<VeryfiyOtpView> createState() => _VeryfiyOtpViewState();
}

class _VeryfiyOtpViewState extends State<VeryfiyOtpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  final box = GetStorage();
  bool validate = false;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: fontMedium,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.gray),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColor.primaryColor),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
          // color: AppColor.primaryColor,
          ),
    );
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
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 48.h,
                      ),
                      Image.asset(
                        Images.logo,
                        height: 60.h,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      widget.forgetPassword!
                          ? Text(
                              'VERIFY_EMAIL'.tr,
                              style: TextStyle(
                                  fontSize: 26.sp,
                                  fontFamily: "Rubik",
                                  fontWeight: FontWeight.w600),
                            )
                          : Text(
                              'VERIFY_NUMBER'.tr,
                              style: TextStyle(
                                  fontSize: 26.sp,
                                  fontFamily: "Rubik",
                                  fontWeight: FontWeight.w600),
                            ),
                      SizedBox(
                        height: 41.h,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'ENTER_THE_CODE_SENT_TO'.tr,
                                    style: fontRegular,
                                  ),
                                  Text(
                                    widget.phoneNumber.toString(),
                                    style: fontMediumPro,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Center(
                                child: Pinput(
                                  length: int.parse(box.read("otpLength")),
                                  defaultPinTheme: defaultPinTheme,
                                  focusedPinTheme: focusedPinTheme,
                                  submittedPinTheme: submittedPinTheme,
                                  pinputAutovalidateMode:
                                      PinputAutovalidateMode.onSubmit,
                                  showCursor: true,
                                  onCompleted: (pin) {
                                    if (widget.isGuest!) {
                                      authController.guestOtpVarify(
                                        widget.phoneNumber,
                                        pin,
                                      );
                                    } else if (widget.forgetPassword!) {
                                      authController.varifyEmail(
                                          widget.phoneNumber, pin);
                                    } else {
                                      authController.otpVarify(
                                        widget.phoneNumber,
                                        pin,
                                      );
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              InkWell(
                                onTap: () {
                                  authController
                                      .forgetPassword(widget.phoneNumber);
                                },
                                child: Text(
                                  'RESEND_CODE'.tr,
                                  style: const TextStyle(
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: AppColor.primaryColor),
                                ),
                              ),
                              SizedBox(
                                height: 24.h,
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: [
                              //     ElevatedButton(
                              //       onPressed: () {
                              //         final FormState? form = _formKey.currentState;
                              //         if (form!.validate()) {
                              //           FocusManager.instance.primaryFocus?.unfocus();
                              //           authController.otpVarify(
                              //             widget.phoneNumber,
                              //             pin,
                              //           );
                              //           validate = true;
                              //         } else {
                              //           validate = false;
                              //         }
                              //         (context as Element).markNeedsBuild();
                              //       },
                              //       style: ElevatedButton.styleFrom(
                              //         primary: AppColor.primaryColor,
                              //         minimumSize: Size(328.w, 52.h),
                              //         backgroundColor: AppColor.primaryColor,
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(24.r),
                              //         ),
                              //       ),
                              //       child: Text(
                              //         "NEXT".tr,
                              //         style: fontMedium,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          )),
                    ],
                  ),
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
