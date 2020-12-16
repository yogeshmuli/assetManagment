
class LoginRequestModel {
  String email;
  String password;
  LoginRequestModel({this.email,this.password});

  Map<String,String> toJson(){
    return {
      "email":this.email,
      "password":this.password
    };
  }

}