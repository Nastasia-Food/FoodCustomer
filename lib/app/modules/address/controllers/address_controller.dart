// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../util/api-list.dart';
import '../../../../util/constant.dart';
import '../../../../widget/custom_snackbar.dart';
import '../../../data/api/server.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/model/response/address_list_model.dart';
import '../../../data/model/response/address_model.dart';
import '../../../data/model/response/location_details_model.dart';
import '../../../data/model/response/prediction_model.dart';
import '../../../data/repository/address_repo.dart';
import '../../../data/repository/location_repo.dart';
import '../../cart/controllers/cart_controller.dart';

class AddressController extends GetxController {
  final box = GetStorage();
  final TextEditingController apartmentController = TextEditingController();
  final TextEditingController labelController = TextEditingController();
  AddressRepo addressRepo = AddressRepo();
  static Server server = Server();
  static AddressListModel addressListModel = AddressListModel();
  int addressTypeIndex = 0;
  int? selectedAddress;
  List<AddressListData> addressDataList = <AddressListData>[];
  List<String> addressTypeList = ['Home', 'Office', 'Others'];
  String selectedAddressType = "Home";
  final selectLabel = "".obs;

  Position position = Position(
    longitude: 0.0,
    latitude: 0.0,
    timestamp: DateTime.now(),
    accuracy: 1,
    altitude: 1,
    heading: 1,
    speed: 1,
    speedAccuracy: 1,
    altitudeAccuracy: 0,
    headingAccuracy: 0,
  );

  Position pickPosition = Position(
    longitude: 0.0,
    latitude: 0.0,
    timestamp: DateTime.now(),
    accuracy: 1,
    altitude: 1,
    heading: 1,
    speed: 1,
    speedAccuracy: 1,
    altitudeAccuracy: 0,
    headingAccuracy: 0,
  );
  bool isLoading = true;
  List<Placemark>? placemarks;
  LatLng? initialPosition;
  CameraPosition? cameraPosition;
  Position? currentPosition;
  String? currentPositionName;
  String pickAddress = '';
  bool changeAddress = true;
  List<PredictionModel> predictionList = [];

  double? picketLat;
  double? picketLong;
  List<AddressModel> addressList = [];

  bool branchLoader = true;
  int selectedBranchIndex = 0;
  bool addAddressLoader = false;
  bool deleteAddressLoader = false;

  @override
  void onInit() {
    if (box.read('isLogedIn') == true && box.read('isLogedIn') != null) {
      getAddressList();
    }
    currentPosition = Position(
      latitude: 37.4133095,
      longitude: -122.1592061,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );
    super.onInit();
  }

  getAddressList() async {
    var addressData = await AddressRepo.getAddressList();
    if (addressData != null) {
      addressDataList = addressData.data!;
      update();
    }
  }

  getCurrentLocation() async {
    try {
      Geolocator.requestPermission();
    } catch (e) {
      print("did not give location permission");
    }
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    pickPosition = Position(
      latitude: currentPosition!.latitude,
      longitude: currentPosition!.longitude,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );
    getPlaceName();
    update();
  }

  getCurrentLocationWhenTapped(GoogleMapController mapController) async {
    isLoading = true;
    update();
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    pickPosition = Position(
      latitude: currentPosition!.latitude,
      longitude: currentPosition!.longitude,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );
    isLoading = false;
    update();
    getPlaceName();
    // ignore: unnecessary_null_comparison
    if (mapController != null) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(pickPosition.latitude, pickPosition.longitude),
            zoom: 16),
      ));
    }
    isLoading = false;
    update();
  }

  getPlaceName() async {
    isLoading = true;
    update();
    placemarks = await placemarkFromCoordinates(
        currentPosition!.latitude, currentPosition!.longitude);
    // ignore: prefer_interpolation_to_compose_strings
    pickAddress = placemarks![0].street!.toString() +
        " " +
        placemarks![0].name!.toString() +
        " " +
        placemarks![0].locality!.toString() +
        " , " +
        placemarks![0].country!.toString();
    isLoading = false;
    update();
  }

  Future<List<PredictionModel>> searchLocation(
      BuildContext context, String text) async {
    // ignore: unnecessary_null_comparison
    if (text != null && text.isNotEmpty) {
      http.Response response = await getLocationData(text);
      var data = jsonDecode(response.body.toString());
      isLoading = true;
      if (data['status'] == 'OK') {
        predictionList = [];
        data['predictions'].forEach((prediction) =>
            predictionList.add(PredictionModel.fromJson(prediction)));
        isLoading = false;
        update();
      } else {
        // ApiChecker.checkApi(response);
      }
    }
    return predictionList;
  }

  Future<Position> setLocation(
      String placeID, String address, GoogleMapController mapController) async {
    isLoading = true;
    LatLng latLng = const LatLng(0, 0);
    http.Response response = await getLocationDetails(placeID);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      PlaceDetailsModel placeDetails = PlaceDetailsModel.fromJson(jsonResponse);
      if (placeDetails.status == 'OK') {
        latLng = LatLng(placeDetails.result!.geometry!.location!.lat!,
            placeDetails.result!.geometry!.location!.lng!);

        update();
      }
    }
    isLoading = false;
    pickAddress = address;
    pickPosition = Position(
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      timestamp: DateTime.now(),
      accuracy: 1,
      altitude: 1,
      heading: 1,
      speed: 1,
      speedAccuracy: 1,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );

    update();
    // ignore: unnecessary_null_comparison
    if (mapController != null) {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: latLng, zoom: 16)));
      isLoading = false;
      update();
    }
    isLoading = false;
    update();

    return pickPosition;
  }

  Future<String> getAddressFromGeocodeData(LatLng latLng) async {
    http.Response response = await getAddressFromGeocode(latLng);
    isLoading = true;
    var responseData = jsonDecode(response.body);
    if (response.statusCode == 200 &&
        responseData['status'].toString() == 'OK') {
      pickAddress = responseData['results'][0]['formatted_address'].toString();
      isLoading = false;
    } else {
      pickAddress = 'Unknown Location Found';
    }
    isLoading = false;
    update();
    return pickAddress;
  }

  void updatePosition(CameraPosition position) async {
    pickPosition = Position(
      latitude: position.target.latitude,
      longitude: position.target.longitude,
      timestamp: DateTime.now(),
      heading: 1,
      accuracy: 1,
      altitude: 1,
      speedAccuracy: 1,
      speed: 1,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );
    update();
    getAddressFromGeocodeData(
        LatLng(position.target.latitude, position.target.longitude));
    isLoading = false;
    update();
  }

  void setAddressTypeIndex(int index) {
    addressTypeIndex = index;
    selectedAddressType = addressTypeList[index];

    if (selectedAddressType.toString() == "Others") {
      selectedAddressType = labelController.text;
    }

    update();
  }

  addAddress() {
    if (selectedAddressType.toString() == '') {
      selectedAddressType = labelController.text;
    }
    if (pickAddress.isNotEmpty) {
      postAddress(
          selectedAddressType,
          pickAddress,
          pickPosition.latitude.toString(),
          pickPosition.longitude.toString(),
          apartmentController.text);
    }
    update();
  }

  updateAddress(
    String id,
    String label,
    String appartment,
  ) {
    if (selectedAddressType.toString() == '') {
      selectedAddressType = labelController.text;
    }
    if (pickAddress.isNotEmpty) {
      editAddress(label, pickAddress, pickPosition.latitude.toString(),
          pickPosition.longitude.toString(), appartment, id);
    }
    update();
  }

  void setAddress(int index) {
    selectedAddress = index;
    update();
  }

  Future<AddressListModel?> postAddress(
    String label,
    String address,
    String latitude,
    String longitude,
    String apartment,
  ) async {
    addAddressLoader = true;
    Map body = {
      'label': label,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'apartment': apartment
    };
    String jsonBody = json.encode(body);
    server
        .postRequestWithToken(endPoint: APIList.addressSave, body: jsonBody)
        .then((response) {
      if (response != null && response.statusCode == 201) {
        addAddressLoader = false;
        labelController.clear();
        apartmentController.clear();
        pickAddress = '';
        getAddressList();
        update();
        getCurrentLocation();
        // setAddress(0);
        update();
        Get.find<CartController>().distanceWiseDeliveryCharge();
        update();
        Get.back();
        Get.back();
        customSnackbar(
            "ADDRESS".tr, "ADDRESS_SAVED_SUCCESSFULLY".tr, AppColor.success);
      } else if (response != null && response.statusCode == 422) {
        labelController.clear();
        apartmentController.clear();
        final jsonResponse = json.decode(response.body);
        addAddressLoader = false;
        update();
        String errorMessage = jsonResponse['message'].toString();
        customSnackbar("ERROR".tr, errorMessage, AppColor.error);
        update();
      }
      addAddressLoader = false;
      update();
    });
    return null;
  }

  Future<AddressListModel?> editAddress(
    String label,
    String address,
    String latitude,
    String longitude,
    String apartment,
    String id,
  ) async {
    Map body = {
      'id': id,
      'label': label,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'apartment': apartment
    };
    String jsonBody = json.encode(body);
    server
        .putRequest(
      // ignore: prefer_interpolation_to_compose_strings
      endPoint: APIList.addressUpdate! + id + '?',
      body: jsonBody,
    )
        .then((response) {
      if (response != null && response.statusCode == 200) {
        addAddressLoader = false;
        addAddressLoader = false;
        getAddressList();
        update();
        Get.back();
        Get.back();
        customSnackbar(
            "ADDRESS".tr, "ADDRESS_UPDATED_SUCCESSFULLY".tr, AppColor.success);
      } else {
        addAddressLoader = false;
        Future.delayed(const Duration(milliseconds: 10), () {
          customSnackbar("ADDRESS".tr, "SOMETHING_WRONG".tr, AppColor.error);
          update();
        });
      }
    });
    return null;
  }

  deleletAddress(int id) {
    deleteAddressLoader = true;
    update();
    server
        .deleteRequest(endPoint: APIList.addressDelete! + id.toString())
        .then((response) {
      if (response.statusCode == 202) {
        deleteAddressLoader = false;
        update();
        getAddressList();
        update();
        customSnackbar(
            "ADDRESS".tr, "ADDRESS_DELETED_SUCCESSFULLY".tr, AppColor.success);
      } else {
        deleteAddressLoader = false;
        Future.delayed(const Duration(milliseconds: 10), () {
          update();
        });
        customSnackbar("ADDRESS".tr, "SOMETHING_WRONG".tr, AppColor.error);
      }
    });
  }
}
