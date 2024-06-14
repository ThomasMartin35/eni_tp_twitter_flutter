import 'package:email_validator/email_validator.dart';

class AppValidators {
  static String? validateEmail(String? value) {
    if (!EmailValidator.validate(value!)) {
      return "Le format de l'email n'est pas valide";
    }
    return null;
  }
}
