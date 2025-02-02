import 'dart:convert';
import '../../../util/api-list.dart';
import '../api/server.dart';
import '../model/response/time_slot_model.dart';

class TimeSlotRepo {
  static Server server = Server();
  static TimeSlotModel todayTimeSlotModelData = TimeSlotModel();
  static TimeSlotModel tomorrowTimeSlotModelData = TimeSlotModel();

  static Future<TimeSlotModel?> getTodayTimeSlot() async {
    try {
      await server
          .getRequestWithoutToken(
        endPoint: APIList.todayTimeSlot,
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          todayTimeSlotModelData = TimeSlotModel.fromJson(jsonResponse);
          return todayTimeSlotModelData;
        }
      });
      return todayTimeSlotModelData;
    } catch (e) {
      return null;
    }
  }

  static Future<TimeSlotModel?> getTomorrowTimeSlot() async {
    try {
      await server
          .getRequestWithoutToken(
        endPoint: APIList.tomorrowTimeSlot,
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          tomorrowTimeSlotModelData = TimeSlotModel.fromJson(jsonResponse);
          return tomorrowTimeSlotModelData;
        }
      });
      return tomorrowTimeSlotModelData;
    } catch (e) {
      return null;
    }
  }
}
