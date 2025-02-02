// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/loader.dart';
import '../controllers/auth_controller.dart';
import 'forget_password_view.dart';
import 'phone_number_view.dart';

class LoginView extends StatefulWidget {
  LoginView({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();

  bool passwordVisible = false;
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    rememberMe = true;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) => Stack(
        children: [
          Scaffold(
            backgroundColor: AppColor.primaryBackgroundColor,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: AppColor.primaryBackgroundColor,
              leading: IconButton(
                icon: SvgPicture.asset(Images.back),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 24.h,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          Images.logo,
                          height: 60.h,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: InkWell(
                              onTap: () {
                                // ignore: avoid_print
                                print(authController.loader);
                              },
                              child: Text('WELCOME_BACK'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22.sp,
                                  )),
                            ),
                          ),
                          Form(
                            key: formKey,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 32.h, left: 16.w, right: 16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'EMAIL'.tr,
                                    style: fontRegularBold,
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  TextFormField(
                                    controller: authController.emailController,
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
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Text(
                                    'PASSWORD'.tr,
                                    style: fontRegularBold,
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  TextFormField(
                                    obscureText: passwordVisible,
                                    controller:
                                        authController.passwordController,
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !RegExp(r"^.{6,}").hasMatch(value)) {
                                        return "Password must be at least 6 charecter";
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.visiblePassword,
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
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: AppColor.gray,
                                        ),
                                        onPressed: () {
                                          setState(
                                            () {
                                              passwordVisible =
                                                  !passwordVisible;
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(
                                            () {
                                              rememberMe = !rememberMe;
                                            },
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 16.w,
                                              height: 16.h,
                                              child: rememberMe
                                                  ? SvgPicture.asset(
                                                      Images.iconTickedYes,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : SvgPicture.asset(
                                                      Images.iconTickedNo,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                            SizedBox(
                                              width: 6.w,
                                            ),
                                            Text('REMEMBER_ME'.tr,
                                                style: fontRegular),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(
                                              () => const ForgetPasswordView(),
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              transition:
                                                  Transition.rightToLeft);
                                        },
                                        child: Text(
                                          'FORGOT_PASSWORD'.tr,
                                          style: TextStyle(
                                              color: AppColor.primaryColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Rubik'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 24.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            if (formKey.currentState!
                                                .validate()) {
                                              authController.login(
                                                  authController
                                                      .emailController.text,
                                                  authController
                                                      .passwordController.text);
                                            }
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          backgroundColor:
                                              AppColor.primaryColor,
                                          minimumSize: Size(292.w, 52.h),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(26.r),
                                          ),
                                        ),
                                        child: Text(
                                          "LOGIN".tr,
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
                                      Text(
                                        'DONT_HAVE_AN_ACCOUNT'.tr,
                                        style: TextStyle(
                                            color: AppColor.textSignupColor,
                                            fontSize: 14.sp,
                                            fontFamily: 'Rubik'),
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(
                                              () => PhoneNumberView(
                                                    isGuest: false,
                                                  ),
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              transition:
                                                  Transition.rightToLeft);
                                        },
                                        child: Text(
                                          'SIGN_UP'.tr,
                                          style: TextStyle(
                                              color: AppColor.primaryColor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp,
                                              fontFamily: 'Rubik'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 16.h, left: 16.w, right: 16.w),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            child: Text(
                              'OR'.tr,
                              style: TextStyle(
                                  color: AppColor.textSignupColor,
                                  fontSize: 14.sp,
                                  fontFamily: 'Rubik'),
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.to(
                                          () => PhoneNumberView(isGuest: true));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Colors.white,
                                      minimumSize: Size(290.w, 52.h),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1.w,
                                          color: AppColor.primaryColor,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(26.r),
                                      ),
                                    ),
                                    child: Text(
                                      "LOGIN_AS_GUEST".tr,
                                      style: TextStyle(
                                        color: AppColor.primaryColor,
                                        fontFamily: 'Rubik',
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 24.h,
                              ),
                            ],
                          ),
                        ],
                      ),
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
