import 'package:assetManagment/models/assets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assetManagment/models/employeeAssets.dart';
import "./baseService.dart";

class EmployeeService extends BaseService {
  Future<dynamic> getAllEmployes() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore.collection('employees').get();

    return querySnapshot.docs;
  }

  Future<dynamic> addEmployee(EmployeeAssestsModel employee) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      var id = firestore.collection("employees").doc().id;
      employee.id = id;
      var employeeRef = await firestore
          .collection('employees')
          .doc(id)
          .set(employee.toJson());
      return employeeRef;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> editEmployee(EmployeeAssestsModel employee) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      var id = employee.id;

      var employeeRef = await firestore
          .collection('employees')
          .doc(id)
          .update(employee.toJson());
      return employeeRef;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> deleteEmployee(String id) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      var employeeRef =
          await firestore.collection('employees').doc(id).delete();
      return employeeRef;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> allocateAsset(
      EmployeeAssestsModel employeeAssestsModel, AssetsModel asset) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      String id = employeeAssestsModel.id;
      asset.assetStatus = "Allocated";
      if (employeeAssestsModel.assets == null) {
        employeeAssestsModel.assets = [asset.toJson()];
      } else {
        employeeAssestsModel.assets.add(asset.toJson());
      }

      var employeeRef = await firestore
          .collection('employees')
          .doc(id)
          .update(employeeAssestsModel.toJson());

      var assetRef = await firestore
          .collection('assets')
          .doc(asset.id)
          .update(asset.toJson());
      return employeeRef;
    } catch (e) {
      print(e);
    }
  }
}
