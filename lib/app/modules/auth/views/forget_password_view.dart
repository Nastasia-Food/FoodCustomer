// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/loader.dart';
import '../controllers/auth_controller.dart';
import 'login_view.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  bool validate = false;

  @override
  Widget build(BuildContext context) {
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
              child: Column(
                children: [
                  Column(
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
                        'FORGOT_PASSWORD'.tr,
                        style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Rubik'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 41.h,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16.w),
                            child: Text(
                              'EMAIL'.tr,
                              style: fontMediumPro,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16.w, right: 16.w, top: 8.h),
                            child: TextFormField(
                              controller: _emailController,
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value)) {
                                  return "Enter valid email";
                                } else {
                                  return null;
                                }
                              },
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
                                  final FormState? form = _formKey.currentState;
                                  if (form!.validate()) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    authController
                                        .forgetPassword(_emailController.text);
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
                                    borderRadius: BorderRadius.circular(26.r),
                                  ),
                                ),
                                child: Text(
                                  "NEXT".tr,
                                  style: fontMedium,
                                ),
                              ),
                            ],
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
                      )),
                ],
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
