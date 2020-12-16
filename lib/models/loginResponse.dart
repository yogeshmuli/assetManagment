

class LoginResponseModel {
  int employeeId ;
  String fullName;
  String email;
  String mobileNo;
  String token;
  List roles;
  bool successful;

  LoginResponseModel({this.employeeId,this.email,this.fullName,this.mobileNo,this.roles,this.successful,this.token});

  LoginResponseModel.fromMap(loginResponseMap){
    this.email=loginResponseMap["email"];
    this.employeeId=loginResponseMap["employeeId"];
    this.fullName=loginResponseMap["fullName"];
    this.mobileNo=loginResponseMap["mobileNo"];
    this.roles=loginResponseMap["roles"];
    this.token=loginResponseMap['token'];
    this.successful=loginResponseMap['successful'];
  }

}