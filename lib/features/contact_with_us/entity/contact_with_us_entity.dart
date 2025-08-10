import 'package:flutter/cupertino.dart';

class ContactWithUsEntity {
  TextEditingController? name, email, phone, message;

  FocusNode? nameNode, emailNode, phoneNode, messageNode;

  ContactWithUsEntity({
    this.name,
    this.email,
    this.phone,
    this.message,
    this.nameNode,
    this.emailNode,
    this.phoneNode,
    this.messageNode,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name?.text.trim();
    data['email'] = email?.text.trim();
    data['phone'] = phone?.text.trim();
    data['message'] = message?.text.trim();
    return data;
  }
}
