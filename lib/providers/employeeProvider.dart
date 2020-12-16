import 'package:assetManagment/helpers/helpers.dart';
import 'package:assetManagment/models/assets.dart';
import 'package:assetManagment/models/employeeAssets.dart';
import 'package:assetManagment/services/responseHandler.dart';
import 'package:flutter/material.dart';
import "../services/employeeService.dart";

class EmployeeProvider with ChangeNotifier {
  EmployeeService employeeService = new EmployeeService();
  bool loading = true;
  List<EmployeeAssestsModel> employeeList = [];

  Future<dynamic> getAllEmployee() async {
    try {
      this.loading = true;
      notifyListeners();
      final employeeListFromServer =
          await this.employeeService.getAllEmployes();
      this.employeeList = [
        ...employeeListFromServer.map((emp) {
          return EmployeeAssestsModel.fromMap(emp);
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

  Future<dynamic> addEmployee(EmployeeAssestsModel employee) async {
    try {
      this.loading = true;
      notifyListeners();
      await this.employeeService.addEmployee(employee);
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

  Future<dynamic> editEmployee(EmployeeAssestsModel employee) async {
    try {
      this.loading = true;
      notifyListeners();
      final response = await this.employeeService.editEmployee(employee);
      this.loading = false;
      notifyListeners();
      return response;
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

  Future<dynamic> deleteEmployee(String id) async {
    try {
      this.loading = true;
      notifyListeners();
      // ignore: unused_local_variable
      final response = await this.employeeService.deleteEmployee(id);
      this.employeeList.removeWhere((element) => element.id == id);
      this.loading = false;
      notifyListeners();
      return;
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

  Future<dynamic> allocateAssetToEmployee(
      EmployeeAssestsModel employee, AssetsModel assetId) async {
    try {
      this.loading = true;
      notifyListeners();
      await this.employeeService.allocateAsset(employee, assetId);
      this.loading = false;
      notifyListeners();
      return;
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
}
