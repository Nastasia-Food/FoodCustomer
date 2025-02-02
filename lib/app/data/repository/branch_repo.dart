// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../util/api-list.dart';
import '../api/server.dart';
import '../model/response/branch_model.dart';

class BranchRepo {
  static Server server = Server();
  static BranchModel branchModelData = BranchModel();

  static Future<BranchModel> getBranch() async {
    try {
      await server
          .getRequestWithoutToken(
        endPoint: APIList.branch! + "?order_column=id&order_type=asc&status=5",
      )
          .then((response) {
        if (response != null && response.statusCode == 200) {
          final jsonResponse = json.decode(response.body);
          branchModelData = BranchModel.fromJson(jsonResponse);
          return branchModelData;
        }
      });
      return branchModelData;
    } catch (e) {
      debugPrint(e.toString());
    }
    return branchModelData;
  }
}
