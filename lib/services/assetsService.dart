import 'dart:convert';

import 'package:assetManagment/models/assets.dart';
import 'package:assetManagment/services/responseHandler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:http/http.dart" as http;
import "../constants/constants.dart";
import './baseService.dart';

class AssetsService extends BaseService {
  Future<dynamic> getAllAssets() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore.collection('assets').get();
    return querySnapshot.docs;
  }

  Future<dynamic> createAssets(AssetsModel assetsModel) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      var id = firestore.collection("assets").doc().id;
      assetsModel.id = id;
      var employeeRef = await firestore
          .collection('assets')
          .doc(id)
          .set(assetsModel.toJson());
      return employeeRef;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> editAssets(AssetsModel assetsModel) async {
    // String url = "${Constants['apiBaseUrl']}api/Assets";
    // final headers = await this.getHeaders();
    // final String body = jsonEncode(assetsModel.toJson());
    // final response = await http.put(url, headers: headers, body: body);
    // return returnResponse(response);
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      var id = assetsModel.id;

      var assetRef = await firestore
          .collection('assets')
          .doc(id)
          .update(assetsModel.toJson());
      return assetRef;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getAssetsType() async {
    String url = "${Constants['apiBaseUrl']}api/AssetType";
    final headers = await this.getHeaders();
    final response = await http.get(url, headers: headers);
    return returnResponse(response);
  }
}
