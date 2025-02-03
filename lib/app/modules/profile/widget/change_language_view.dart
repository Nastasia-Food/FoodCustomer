import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodking/app/modules/splash/controllers/splash_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../controllers/language_controller.dart';

// ignore: must_be_immutable
class ChangeLanguageView extends StatefulWidget {
  const ChangeLanguageView({Key? key}) : super(key: key);

  @override
  State<ChangeLanguageView> createState() => _ChangeLanguageViewState();
}

class _ChangeLanguageViewState extends State<ChangeLanguageView> {
  final box = GetStorage();

  final bool isActive = true;

  @override
  Widget build(BuildContext context) {
    LanguageController languageController = Get.put(LanguageController());
    SplashController splashController = Get.put(SplashController());

    return Scaffold(
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
        body: Padding(
          padding: EdgeInsets.only(top: 24.h, left: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: Text(
                      "CHANGE_LANGUAGE".tr,
                      style: fontBlack,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: splashController.languageDataList.length,
                itemBuilder: (BuildContext context, index) {
                  return InkWell(
                    onTap: () {
                      languageController.changeLanguage(
                        splashController.languageDataList[index].code!,
                        splashController.languageDataList[index].name!,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 10.h, right: 16.w),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: box.read('languageCode') ==
                                  splashController.languageDataList[index].code!
                              ? AppColor.primaryColor.withOpacity(0.08)
                              : Colors.white,
                          border: box.read('languageCode') ==
                                  splashController.languageDataList[index].code!
                              ? Border.all(color: AppColor.primaryColor)
                              : Border.all(color: Colors.white),
                        ),
                        height: 56.h,
                        width: 328.w,
                        child: Row(children: [
                          SizedBox(width: 16.w),
                          SizedBox(
                            width: 24.w,
                            height: 24.h,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.r)),
                              child: CachedNetworkImage(
                                imageUrl: splashController
                                    .languageDataList[index].image!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  // ignore: sort_child_properties_last
                                  child: Container(
                                      width: 24.w,
                                      height: 24.h,
                                      color: Colors.grey),
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[400]!,
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Text(
                            splashController.languageDataList[index].name!,
                            style: fontMedium,
                          ),
                          const Spacer(),
                          box.read('languageCode') ==
                                  splashController.languageDataList[index].code!
                              ? Padding(
                                  padding:
                                      EdgeInsets.only(right: 18.w, left: 16.w),
                                  child: SizedBox(
                                    width: 24.w,
                                    height: 24.h,
                                    child: SvgPicture.asset(
                                      Images.tick,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ]),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
