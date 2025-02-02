import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../util/constant.dart';
import '../../dashboard/views/dashboard_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final box = GetStorage();
  @override
  void initState() {
    //for foreground state
    Timer(
      const Duration(seconds: 2),
      () {
        Get.offAll(() => const DashboardView());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
          child: Image.asset(
        Images.splashLogo,
        height: 60.h,
        fit: BoxFit.contain,
      )),
    );
  }
}
