import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../util/constant.dart';
import '../../../../util/style.dart';

class TimeSlotWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlotWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          height: 32.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: isSelected
                ? AppColor.primaryColor.withOpacity(0.08)
                : AppColor.itembg,
            border: isSelected
                ? Border.all(color: AppColor.primaryColor)
                : Border.all(color: Colors.white),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            SizedBox(
              width: 16.w,
              height: 16.h,
              child: isSelected
                  ? SvgPicture.asset(
                      Images.IconVariationSelected,
                      fit: BoxFit.cover,
                    )
                  : SvgPicture.asset(
                      Images.IconVariation,
                      fit: BoxFit.cover,
                    ),
            ),
            Text(
              title,
              style: fontRegular,
            )
          ]),
        ),
      ),
    );
  }
}
