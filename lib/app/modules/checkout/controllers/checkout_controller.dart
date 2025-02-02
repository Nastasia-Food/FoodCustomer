import 'package:get/get.dart';

import '../../../data/model/response/time_slot_model.dart';
import '../../../data/repository/time_slot_repo.dart';

class CheckoutController extends GetxController {
  bool couponApplied = false;
  // List<TimeSlotModel>? allTimeSlots;
  // List<TimeSlotModel>? todayTimeSlots;
  int selectDateSlot = 0;
  int selectTimeSlot = 0;

  List<TimeSlotData> todayDataList = <TimeSlotData>[];
  List<TimeSlotData> tomorrowDataList = <TimeSlotData>[];

  @override
  void onInit() {
    getTodayTime();
    getTomorrowTime();
    super.onInit();
  }

  getTodayTime() async {
    var todayData = await TimeSlotRepo.getTodayTimeSlot();
    if (todayData != null) {
      todayDataList = todayData.data!;
      update();
    }
    update();
  }

  getTomorrowTime() async {
    var tomorrowData = await TimeSlotRepo.getTomorrowTimeSlot();
    if (tomorrowData != null) {
      tomorrowDataList = tomorrowData.data!;
      update();
    }
    update();
  }

  void updateDateSlot(int index) {
    selectDateSlot = index;
    update();
  }

  void updateTimeSlot(int index) {
    selectTimeSlot = index;
    update();
  }
}
