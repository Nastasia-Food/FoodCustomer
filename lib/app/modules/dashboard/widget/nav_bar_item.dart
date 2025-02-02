import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../util/constant.dart';

class BottomNavItem extends StatelessWidget {
  final AssetImage? imageData;
  final String? tittle;
  final VoidCallback? onTap;
  final bool isSelected;
  const BottomNavItem(
      {super.key,
      this.imageData,
      this.tittle,
      this.onTap,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageIcon(
                imageData,
                color: isSelected
                    ? AppColor.primaryColor
                    : Theme.of(context).disabledColor.withOpacity(0.8),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4.h, bottom: 2.h),
                child: Text(
                  tittle!,
                  maxLines: 1,
                  style: TextStyle(
                    fontFamily: 'Rubik',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
