import 'dart:ui';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final box = GetStorage();

  @override
  void onInit() {
    if (box.read('selectedLanguageValue') == null) {
      box.write('languageCode', 'en');
      box.write('selectedLanguageValue', 'English');
      update();
    }
    super.onInit();
  }

  changeLanguage(String languageCode, String languageName) {
    box.write('languageCode', languageCode);
    box.write('selectedLanguageValue', languageName);
    Get.updateLocale(Locale(languageCode, null));
    update();
  }
}
