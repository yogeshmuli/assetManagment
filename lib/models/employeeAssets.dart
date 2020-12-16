import 'package:assetManagment/models/assets.dart';

class EmployeeAssestsModel {
  String id;
  String firstname;
  String lastname;
  String email;
  String address;
  String mobile;
  List assets;

  EmployeeAssestsModel({
    this.address,
    this.email,
    this.assets,
    this.firstname,
    this.id,
    this.lastname,
    this.mobile,
  });

  EmployeeAssestsModel.fromMap(employeeMap) {
    this.id = employeeMap["id"];
    this.email = employeeMap["email"];
    this.firstname = employeeMap["firstname"];
    this.lastname = employeeMap["lastname"];
    this.mobile = employeeMap["mobile"];
    this.address = employeeMap["address"];
    this.assets = employeeMap["assets"] != null
        ? [...employeeMap["assets"].map((m) => AssetsModel.fromMap(m))]
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "firstname": this.firstname,
      "lastname": this.lastname,
      "email": this.email,
      "mobile": this.mobile,
      "address": this.address,
      "assets": this.assets
    };
  }

  // void addAssetID(String assetId) {
  //   this.assets.add(assetId);
  // }
}
