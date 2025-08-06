class VerificationModel {
  String? code;
  String? phone;
  String? userType;
  bool fromRegister;
  VerificationModel({
    this.code,
    this.phone,
    this.userType,
    this.fromRegister = true,
  });

  Map<String, dynamic> toJson({bool withCode = true}) => {
        "phone_number": phone,
        "type": userType,
        if (withCode) "otp": code,
      };
}
