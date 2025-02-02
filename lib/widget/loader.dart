import 'dart:ui';

import 'package:flutter/material.dart';

import '../util/constant.dart';
import '../util/style.dart';

class LoaderCircle extends StatelessWidget {
  const LoaderCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: const SizedBox(),
          ),
        ),
        Container(
          height: ScreenSize(context).block * 20,
          width: ScreenSize(context).block * 20,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              height: ScreenSize(context).block * 15,
              width: ScreenSize(context).block * 15,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    Images.logo,
                    height: ScreenSize(context).block * 20,
                    width: ScreenSize(context).block * 20,
                  ),
                ),
              ),
            ),
          ),
        ),
        const Positioned(
          top: 2,
          left: 2,
          right: 2,
          bottom: 2,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            backgroundColor: AppColor.primaryColor,
          ),
        ),
      ],
    );
  }
}
