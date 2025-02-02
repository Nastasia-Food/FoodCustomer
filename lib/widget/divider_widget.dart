import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../util/constant.dart';

Widget divider() {
  return Divider(
    height: 16.h,
    thickness: 1,
    indent: 18,
    endIndent: 18,
    color: AppColor.dividerColor,
  );
}
