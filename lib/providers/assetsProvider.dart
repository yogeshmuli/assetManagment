import 'package:assetManagment/helpers/helpers.dart';
import 'package:assetManagment/models/assets.dart';
import 'package:assetManagment/models/assetsType.dart';
import 'package:assetManagment/services/responseHandler.dart';
import 'package:flutter/material.dart';
import "../services/assetsService.dart";

class AssetsProvider with ChangeNotifier {
  AssetsService assetsService = new AssetsService();
  bool loading = true;
  List<AssetsModel> assetsList;
  List<AssetsTypeModel> assetsTypeList;

  String getAssetsTitle(int id) {
    AssetsTypeModel model =
        assetsTypeList.firstWhere((element) => element.id == id);
    return model.title;
  }

  Future<dynamic> getAllAssets() async {
    try {
      this.loading = true;
      notifyListeners();
      final assetsListFromServer = await this.assetsService.getAllAssets();
      this.assetsList = [
        ...assetsListFromServer.map((emp) {
          return AssetsModel.fromMap(emp);
        }).toList()
      ];
      this.loading = false;
      notifyListeners();
    } on UnauthorisedException catch (uae) {
      onUnauthorisedException(uae);
      this.loading = false;
      notifyListeners();
      throw uae;
    } catch (e) {
      print(e);
      this.loading = false;
      notifyListeners();
      throw e;
    }
  }

  Future<dynamic> createAssets(AssetsModel assetsModel) async {
    try {
      this.loading = true;
      notifyListeners();
      // ignore: unused_local_variable
      final assetsId = await this.assetsService.createAssets(assetsModel);
      this.loading = false;
      notifyListeners();
    } on UnauthorisedException catch (uae) {
      onUnauthorisedException(uae);
      this.loading = false;
      notifyListeners();
      throw uae;
    } catch (e) {
      print(e);
      this.loading = false;
      notifyListeners();
      throw e;
    }
  }

  Future<dynamic> editAssets(AssetsModel assetsModel) async {
    try {
      this.loading = true;
      notifyListeners();
      // ignore: unused_local_variable
      final assetsId = await this.assetsService.editAssets(assetsModel);
      this.loading = false;
      notifyListeners();
    } on UnauthorisedException catch (uae) {
      onUnauthorisedException(uae);
      this.loading = false;
      notifyListeners();
      throw uae;
    } catch (e) {
      print(e);
      this.loading = false;
      notifyListeners();
      throw e;
    }
  }

  Future<dynamic> getAssetsType() async {
    try {
      final assetsTypeListFromServer = await this.assetsService.getAssetsType();
      this.assetsTypeList = [
        ...assetsTypeListFromServer.map((emp) {
          return AssetsTypeModel.fromMap(emp);
        }).toList()
      ];
    } on UnauthorisedException catch (uae) {
      onUnauthorisedException(uae);
      throw uae;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
