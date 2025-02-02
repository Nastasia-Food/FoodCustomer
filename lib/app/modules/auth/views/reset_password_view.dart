// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/loader.dart';
import '../controllers/auth_controller.dart';

class ResetPasswordView extends StatefulWidget {
  String? email;
  ResetPasswordView({Key? key, this.email}) : super(key: key);

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();

  bool validate = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) => Stack(
        children: [
          Scaffold(
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
                child: Column(
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
                      'CREATE_NEW_PASSWORD'.tr,
                      style: TextStyle(
                          fontSize: 22.sp,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 16.w),
                                  child: Text(
                                    'ENTER_NEW_PASSWORD'.tr,
                                    style: (TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'Rubik',
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w500)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 16.w, right: 16.w, top: 8.h),
                                  child: TextFormField(
                                    controller: _newPassword,
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !RegExp(r"^.{6,}").hasMatch(value)) {
                                        return "PASSWORD_MUST_BE_SIX".tr;
                                      } else {
                                        return null;
                                      }
                                    },
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
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.r),
                                        ),
                                        borderSide: BorderSide(
                                            width: 1.w,
                                            color: AppColor.dividerColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 16.w),
                                  child: Text(
                                    'CONFIRM_NEW_PASSWORD'.tr,
                                    style: (TextStyle(
                                        fontSize: 14.sp,
                                        fontFamily: 'Rubik',
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w500)),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 16.w, right: 16.w, top: 8.h),
                                  child: TextFormField(
                                    controller: _confirmNewPassword,
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !RegExp(r"^.{6,}").hasMatch(value)) {
                                        return "PASSWORD_MUST_BE_SIX".tr;
                                      } else {
                                        return null;
                                      }
                                    },
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
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8.r),
                                        ),
                                        borderSide: BorderSide(
                                            width: 1.w,
                                            color: AppColor.dividerColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    final FormState? form =
                                        _formKey.currentState;
                                    if (form!.validate()) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      authController.passwordReset(
                                          widget.email,
                                          _newPassword.text,
                                          _confirmNewPassword.text);
                                      validate = true;
                                    } else {
                                      validate = false;
                                    }
                                    (context as Element).markNeedsBuild();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primaryColor,
                                    minimumSize: Size(320.w, 48.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.r),
                                    ),
                                  ),
                                  child: Text(
                                    "SUBMIT".tr,
                                    style: fontMedium,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
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
