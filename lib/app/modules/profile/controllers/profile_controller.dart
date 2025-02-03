// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foodking/app/modules/dashboard/views/dashboard_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../util/api-list.dart';
import '../../../../util/constant.dart';
import '../../../../widget/custom_snackbar.dart';
import '../../../../widget/custom_toast.dart';
import '../../../data/api/server.dart';
import '../../../data/model/response/profile_model.dart';
import '../../../data/repository/profile_repo.dart';
import '../../splash/controllers/splash_controller.dart';
import '../widget/image_size_chekcer.dart';

class ProfileController extends GetxController {
  SplashController splashController = Get.put(SplashController());
  ProfileData profileData = ProfileData();

  Server server = Server();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();
  bool loader = false;
  bool updateProfileLodear = false;
  bool changePasswordLodear = false;
  String? imagePath;
  File? file;

  final box = GetStorage();

  @override
  void onInit() {
    final box = GetStorage();
    if (box.read('isLogedIn') == true && box.read('isLogedIn') != null) {
      getProfileData();
    }
    super.onInit();
  }

  getProfileData() async {
    loader = true;
    update();
    var responseData = await ProfileRepo.getProfile();
    if (responseData != null) {
      loader = false;
      update();
      profileData = responseData.data!;
      firstNameController.text = profileData.firstName.toString();
      lastNameController.text = profileData.lastName.toString();
      emailController.text = profileData.email.toString() == 'null'
          ? ''
          : profileData.email.toString();
      mobileController.text = profileData.phone.toString();
      update();
    }
  }

  updateUserProfile(context) async {
    updateProfileLodear = true;
    update();
    Map<String, String>? body = {
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'email': emailController.text,
      'phone': mobileController.text,
      'country_code': splashController.countryInfoData.callingCode!
    };
    String jsonBody = json.encode(body);

    await server
        .putRequest(
      endPoint: APIList.profile,
      body: jsonBody,
    )
        .then((response) async {
      print(response.body);
      if (response != null && response.statusCode == 200) {
        await getProfileData();
        updateProfileLodear = false;

        update();
        Get.back();
        customSnackbar("PROFILE_UPDATE".tr, 'PROFILE_UPDATE_SUCCESSFULLY'.tr,
            AppColor.success);
      } else if (response['errors']['password'] != null) {
        updateProfileLodear = false;
        update();
        final jsonResponse = json.decode(response.body);
        customSnackbar(
            "ERROR".tr, jsonResponse["message"].toString(), AppColor.error);
      } else {
        loader = false;
        update();
        customSnackbar("ERROR".tr, "SOMETHING_WRONG".tr, AppColor.error);
      }
    });
  }

  updateUserPassword() async {
    changePasswordLodear = true;
    update();
    Map<String, String>? body = {
      'old_password': oldPasswordController.text,
      'password': newPasswordController.text,
      'password_confirmation': retypePasswordController.text,
    };
    String jsonBody = json.encode(body);
    await server
        .putRequest(
      endPoint: APIList.changePassword,
      body: jsonBody,
    )
        .then((response) {
      print(response.body);
      if (response != null && response.statusCode == 200) {
        changePasswordLodear = false;
        getProfileData();
        update();
        oldPasswordController.clear();
        newPasswordController.clear();
        retypePasswordController.clear();
        Get.back();
        customSnackbar('CHANGE_PASSWORD'.tr, 'PASSWORD_UPDATE_SUCCESSFULLY'.tr,
            AppColor.success);
      } else if (response != null && response.statusCode == 422) {
        var message = jsonDecode(response.body);

        if (message['errors']['password'] != null) {
          customSnackbar('CHANGE_PASSWORD'.tr,
              message['errors']['password'][0].toString(), AppColor.error);
        }
        if (message['errors']['old_password'] != null) {
          customSnackbar('CHANGE_PASSWORD'.tr,
              message['errors']['old_password'][0].toString(), AppColor.error);
        }
        changePasswordLodear = false;
        Future.delayed(const Duration(milliseconds: 10), () {
          update();
        });
      } else {
        changePasswordLodear = false;
        Future.delayed(const Duration(milliseconds: 10), () {
          update();
        });
        customSnackbar('CHANGE_PASSWORD'.tr, 'PLEASE_ENTER_VALID_INPUT'.tr,
            AppColor.error);
      }
    });
  }

  Future getImageFromGallary() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    double imageSize = await ImageSize.getImageSize(image!);
    file = File(image.path);
    if (imageSize > 2) {
      customTast("IMAGE_SHOULD_BE_LESS_THAN_2MB".tr, AppColor.error);
    } else {
      updateProfileImage(image.path);
    }
  }

  updateProfileImage(file) async {
    loader = true;
    update();
    await server
        .multipartRequest(APIList.changeProfileImage, file)
        .then((response) async {
      if (response != null) {
        loader = false;
        update();
        getProfileData();
        customSnackbar("SUCCESS".tr, "PROFILE_IMAGE_SAVED_SUCCESSFULLY".tr,
            AppColor.success);
        update();
      } else {
        loader = false;
        update();
        customSnackbar("ERROR".tr, "SOMETHING_WRONG".tr, AppColor.error);
      }
    });
  }

  deleteAccount() async {
    updateProfileLodear = true;
    server
        .postRequestWithToken(endPoint: APIList.deleteAccount)
        .then((response) {
      if (response != null && response.statusCode == 200) {
        updateProfileLodear = false;
        update();

        box.write('isLogedIn', false);

        Get.offAll(const DashboardView());
        customSnackbar(
            "ACCOUNT".tr, "ACCOUNT_DELETED_SUCCESSFULLY".tr, AppColor.success);
      } else if (response != null && response.statusCode == 422) {
        final jsonResponse = json.decode(response.body);
        updateProfileLodear = false;
        update();
        String errorMessage = jsonResponse['message'].toString();
        customSnackbar("ERROR".tr, errorMessage, AppColor.error);
        update();
      }
      updateProfileLodear = false;
      update();
    });
    return null;
  }
}
