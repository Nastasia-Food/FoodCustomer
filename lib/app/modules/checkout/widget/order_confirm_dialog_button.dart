import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderConfirmDialogButton extends StatelessWidget {
  const OrderConfirmDialogButton(
      {super.key,
      this.height,
      this.width,
      this.buttonColor,
      this.text,
      this.textColor,
      this.borderColor,
      this.textSize,
      this.maxLines,
      this.overflow,
      this.fontWeight = FontWeight.w600,
      this.onTap});
  final double? height;
  final double? width;
  final Color? buttonColor;
  final String? text;
  final Color? textColor;
  final int? borderColor;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? textSize;
  final FontWeight? fontWeight;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: Color(borderColor!)),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(4.r),
            child: FittedBox(
              child: Text(
                text ?? "",
                style: TextStyle(
                  fontSize: textSize,
                  color: textColor,
                  fontFamily: "Rubik",
                  fontWeight: fontWeight,
                ),
                maxLines: maxLines,
                overflow: overflow,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
