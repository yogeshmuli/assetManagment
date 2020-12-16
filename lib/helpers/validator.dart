import 'package:email_validator/email_validator.dart';

typedef String ValidatorFunction (String value);

class TextInputValidator {
  static ValidatorFunction emailValidator (String errorMessage){
    return (String value) {
    if (!EmailValidator.validate(value)) {
      return errorMessage;
    }
    return null;
  };
  }

  static ValidatorFunction requiredValidator (String erroMessage){
    return (String value){
      if(value==""){
        return erroMessage;
      }
      return null;
    };
  }

  static ValidatorFunction phoneNumberValidator (String errorMessage){
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    return (String value){
        if(!regExp.hasMatch(value)){
            return errorMessage;
        }

      return null;
    };
  }


 
}
