import 'user_types_enum.dart';

abstract class UserTypeEnumConverter {
  static UserType convertUserTypeFromStringToEnum(String status) {
    switch (status.toUpperCase()) {
      case "DRIVER":
        return UserType.driver;
      case "ADMIN":
        return UserType.admin;

      default:
        return UserType.admin;
    }
  }
}
