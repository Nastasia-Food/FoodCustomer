// ignore_for_file: library_private_types_in_public_api

import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../util/constant.dart';
import '../controllers/order_controller.dart';

class StepperWidgetTakeAway extends StatefulWidget {
  const StepperWidgetTakeAway({super.key});

  @override
  _Stepper createState() => _Stepper();
}

class _Stepper extends State<StepperWidgetTakeAway> {
  int activeStep = 0;
  @override
  void initState() {
    super.initState();

    if (Get.find<OrderController>().orderDetailsData.value.status == 1) {
      activeStep = 0;
    } else if (Get.find<OrderController>().orderDetailsData.value.status == 4) {
      activeStep = 1;
    } else if (Get.find<OrderController>().orderDetailsData.value.status == 7) {
      activeStep = 2;
    } else if (Get.find<OrderController>().orderDetailsData.value.status ==
        10) {
      activeStep = 3;
    } else if (Get.find<OrderController>().orderDetailsData.value.status ==
        13) {
      activeStep = 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (orderController) => Column(
        children: [
          EasyStepper(
            activeStep: activeStep,
            lineLength: 70,
            lineSpace: 0,
            lineType: LineType.normal,
            padding: const EdgeInsetsDirectional.symmetric(
                horizontal: 20, vertical: 20),
            defaultLineColor: Colors.grey,
            finishedLineColor: AppColor.primaryColor,
            activeStepTextColor: AppColor.primaryColor,
            finishedStepTextColor: Colors.black87,
            finishedStepBackgroundColor: Colors.white,
            internalPadding: 0,
            showLoadingAnimation: false,
            lineThickness: 2,
            stepRadius: 8,
            showStepBorder: false,
            steps: [
              EasyStep(
                customStep: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: orderController.orderDetailsData.value.status! >= 1
                      ? SvgPicture.asset(Images.tick)
                      : SvgPicture.asset(Images.roundStepper),
                ),
                customTitle: Text("ORDER_PLACED".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color:
                            orderController.orderDetailsData.value.status! == 1
                                ? AppColor.primaryColor
                                : AppColor.fontColor)),
              ),
              EasyStep(
                customStep: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: orderController.orderDetailsData.value.status! >= 4
                      ? SvgPicture.asset(Images.tick)
                      : SvgPicture.asset(Images.roundStepper),
                ),
                customTitle: Text("ORDER_ACCEPTED".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color:
                            orderController.orderDetailsData.value.status! == 4
                                ? AppColor.primaryColor
                                : AppColor.fontColor)),
              ),
              EasyStep(
                customStep: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: orderController.orderDetailsData.value.status! >= 7
                      ? SvgPicture.asset(Images.tick)
                      : SvgPicture.asset(Images.roundStepper),
                ),
                customTitle: Text(
                  "PREPARING".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: orderController.orderDetailsData.value.status! == 7
                          ? AppColor.primaryColor
                          : AppColor.fontColor),
                ),
              ),
              EasyStep(
                customStep: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: orderController.orderDetailsData.value.status! >= 13
                      ? SvgPicture.asset(Images.tick)
                      : SvgPicture.asset(Images.roundStepper),
                ),
                customTitle: Text(
                  "DELIVERED".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color:
                          orderController.orderDetailsData.value.status! == 13
                              ? AppColor.primaryColor
                              : AppColor.fontColor),
                ),
              ),
            ],
            onStepReached: (index) => setState(
                () => orderController.orderDetailsData.value.status = index),
          ),
        ],
      ),
    );
  }
}
