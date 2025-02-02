import 'package:image_picker/image_picker.dart';

class ImageSize {
  static Future<double> getImageSize(XFile profileImageFile) async {
    int sizeInKB = await profileImageFile.length();
    double sizeInMB = sizeInKB / (1024 * 1024);
    return sizeInMB;
  }
}
