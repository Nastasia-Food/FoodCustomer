// ignore_for_file: non_constant_identifier_names

import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../../../util/api-list.dart';

Future<http.Response> getLocationData(String text) async {
  http.Response response;

  response = await http.get(Uri.parse(
      "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$text&key=${APIList.mapApiKey}"));

  return response;
}

Future<http.Response> getLocationDetails(String placeId) async {
  http.Response response;

  response = await http.get(Uri.parse(
      "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=${APIList.mapApiKey}"));

  return response;
}

Future<http.Response> getAddressFromGeocode(LatLng latLng) async {
  http.Response response;
  response = await http.get(Uri.parse(
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&sensor=true&key=${APIList.mapApiKey}"));
  return response;
}
