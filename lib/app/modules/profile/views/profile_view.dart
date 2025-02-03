// ignore_for_file: sort_child_properties_last, deprecated_member_use, prefer_interpolation_to_compose_strings
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodking/app/modules/profile/views/pages_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../util/constant.dart';
import '../../../../util/style.dart';
import '../../../../widget/loader.dart';
import '../../auth/views/login_view.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../order/views/order_view.dart';
import '../../splash/controllers/splash_controller.dart';
import '../controllers/profile_controller.dart';
import '../widget/change_language_view.dart';
import '../widget/change_password_view.dart';
import '../widget/edit_profile_view.dart';
import '../widget/profile_address_view.dart';

// ignore: must_be_immutable
class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final box = GetStorage();

  bool? isLogedIn;

  @override
  void initState() {
    Get.put(SplashController());
    ProfileController profileController = Get.put(ProfileController());
    super.initState();
    bool isLogedIn = box.read('isLogedIn');
    if (isLogedIn) {
      profileController.getProfileData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) => Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(
                "MY_PROFILE".tr,
                style: fontBoldWithColorBlack,
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            body: RefreshIndicator(
              color: AppColor.primaryColor,
              onRefresh: () async {
                if (box.read('isLogedIn') != null &&
                    box.read('isLogedIn') != false) {
                  profileController.getProfileData();
                }
              },
              child: SafeArea(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          box.read('isLogedIn')
                              ? SizedBox(
                                  child: profileController.profileData.image ==
                                          null
                                      ? const SizedBox()
                                      : Column(
                                          children: [
                                            SizedBox(
                                              height: 140.h,
                                              child: Stack(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                children: [
                                                  SizedBox(
                                                    width: 100.w,
                                                    height: 100.h,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50.r)),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            profileController
                                                                .profileData
                                                                .image!,
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        placeholder: (context,
                                                                url) =>
                                                            Shimmer.fromColors(
                                                          child: Container(
                                                              height: 86.h,
                                                              width: 154.w,
                                                              color:
                                                                  Colors.grey),
                                                          baseColor:
                                                              Colors.grey[300]!,
                                                          highlightColor:
                                                              Colors.grey[400]!,
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 105.w,
                                                    height: 105.h,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      child: Image.asset(
                                                        Images.dotCircle,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    width: 100,
                                                    bottom: 0,
                                                    child: InkWell(
                                                      onTap: () {
                                                        profileController
                                                            .getImageFromGallary();
                                                      },
                                                      child: SizedBox(
                                                        width: 44.w,
                                                        height: 44.h,
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          child: SizedBox(
                                                            width: 40.w,
                                                            height: 40.h,
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  AppColor
                                                                      .darkGray,
                                                              child: SvgPicture
                                                                  .asset(
                                                                Images.iconEdit,
                                                                fit: BoxFit
                                                                    .cover,
                                                                width: 22.w,
                                                                height: 22.h,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
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
                                            Text(
                                              profileController.profileData.name
                                                  .toString(),
                                              style: TextStyle(
                                                fontFamily: 'Rubik',
                                                fontSize: 16.sp,
                                                color: AppColor.fontColor,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            if (profileController
                                                    .profileData.email !=
                                                null)
                                              Text(
                                                profileController
                                                    .profileData.email
                                                    .toString(),
                                                style: TextStyle(
                                                  fontFamily: 'Rubik',
                                                  fontSize: 14.sp,
                                                  color: AppColor.gray,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            SizedBox(
                                              height: 2.h,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  profileController.profileData
                                                          .countryCode! +
                                                      profileController
                                                          .profileData.phone
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'Rubik',
                                                    fontSize: 14.sp,
                                                    color: AppColor.gray,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4.h,
                                            ),
                                            Text(
                                              Get.find<SplashController>()
                                                      .configData
                                                      .siteDefaultCurrencySymbol! +
                                                  profileController
                                                      .profileData.balance
                                                      .toString(),
                                              style: TextStyle(
                                                fontFamily: 'Rubik',
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                )
                              : SizedBox(
                                  child: Column(children: [
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    SizedBox(
                                      width: 100.w,
                                      height: 100.h,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        child: Image.asset(
                                          Images.profile,
                                          width: 100.w,
                                          height: 100.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    Text(
                                      'LOGIN_TO_SEE_YOUR_INFO'.tr,
                                      style: TextStyle(
                                        fontFamily: 'Rubik',
                                        fontSize: 14.sp,
                                        color: AppColor.fontColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.to(() => LoginView());

                                              (context as Element)
                                                  .markNeedsBuild();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              minimumSize: Size(320.w, 52.h),
                                              backgroundColor:
                                                  AppColor.loginButtonColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(26.r),
                                              ),
                                            ),
                                            child: Text("LOGIN".tr,
                                                style: fontMedium),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 32.h,
                                    ),
                                  ]),
                                ),
                          SizedBox(
                            height: 20.h,
                          ),
                          if (box.read('isLogedIn') == true)
                            profileItem(const OrderView(), Images.order,
                                "MY_ORDERS".tr),
                          if (box.read('isLogedIn') == true)
                            profileItem(EditProfileView(), Images.edit,
                                "EDIT_PROFILE".tr),
                          if (box.read('isLogedIn') == true)
                            profileItem(const ProfileAddressView(),
                                Images.address, "ADDRESS".tr),
                          if (box.read('isLogedIn') == true)
                            profileItem(ChangePasswordView(),
                                Images.change_pass, "CHANGE_PASSWORD".tr),
                          profileItem(const ChangeLanguageView(),
                              Images.change_language, "CHANGE_LANGUAGE".tr),
                          //web pages
                          GetBuilder<SplashController>(
                            builder: (splashController) => SizedBox(
                              child: ListView.builder(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      splashController.pageDataList.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 12.h),
                                      child: profileItem(
                                          PagesScreen(
                                            description: splashController
                                                .pageDataList[index]
                                                .description,
                                            tittle: splashController
                                                .pageDataList[index].title,
                                          ),
                                          Images.terms_condition,
                                          splashController
                                              .pageDataList[index].title),
                                    );
                                  }),
                            ),
                          ),

                          if (box.read('isLogedIn') == true)
                            InkWell(
                              onTap: () {
                                box.write('isLogedIn', false);
                                (context as Element).markNeedsBuild();
                                Get.offAll(() => const DashboardView());
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        Images.logout,
                                        height: 16.h,
                                        width: 16.w,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        width: 16.h,
                                      ),
                                      Text(
                                        "LOG_OUT".tr,
                                        style: fontProfile,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 14.h,
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(
                            height: 20.h,
                          ),
                          if (box.read('isLogedIn') == true)
                            SizedBox(
                              width: Get.width - 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.dialog(
                                    AlertDialog(
                                        content: SizedBox(
                                      height: 160,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "ARE_YOU_SURE_DELETE_THIS_ACCOUNT"
                                                  .tr,
                                              textAlign: TextAlign.center,
                                              style: fontMedium,
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      elevation: 1,
                                                      backgroundColor:
                                                          AppColor.itembg,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(24.r),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "CLOSE".tr,
                                                      style: TextStyle(
                                                        fontFamily: 'Rubik',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColor
                                                            .primaryColor,
                                                        fontSize: 15.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20.w,
                                                ),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      profileController
                                                          .deleteAccount();
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      elevation: 1,
                                                      backgroundColor:
                                                          AppColor.primaryColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(24.r),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "DELETE".tr,
                                                      style: TextStyle(
                                                        fontFamily: 'Rubik',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                    barrierDismissible: false,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primaryColor,
                                  minimumSize: Size(156.w, 48.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.r),
                                  ),
                                ),
                                child: Text(
                                  "DELETE_ACCOUNT".tr,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: fontMedium,
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 40.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          profileController.loader
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
              : const SizedBox.shrink()
        ],
      ),
    );
  }

  InkWell profileItem(route, icon, textValue) {
    return InkWell(
      onTap: () => Get.to(route, transition: Transition.cupertino),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                icon,
                height: 16.h,
                width: 16.w,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 16.h,
              ),
              Text(
                "$textValue",
                style: fontProfile,
              ),
            ],
          ),
          SizedBox(
            height: 14.h,
          ),
          const Divider(
            thickness: 1,
            endIndent: 10,
            color: AppColor.dividerColor,
          ),
        ],
      ),
    );
  }
}
