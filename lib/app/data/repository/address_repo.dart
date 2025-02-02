import 'dart:convert';
import '../../../util/api-list.dart';
import '../api/server.dart';
import '../model/response/address_list_model.dart';

class AddressRepo {
  static Server server = Server();
  static AddressListModel addressListModel = AddressListModel();

  static Future<AddressListModel?> getAddressList() async {
    try {
      await server
          .getRequest(
        endPoint: APIList.addressList,
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          addressListModel = AddressListModel.fromJson(jsonResponse);
          return addressListModel;
        }
      });
      return addressListModel;
    } catch (e) {
      return null;
    }
  }
}
