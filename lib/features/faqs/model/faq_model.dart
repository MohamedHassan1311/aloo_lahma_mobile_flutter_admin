import '../../../data/config/mapper.dart';
import '../../../main_models/meta.dart';

class FaqsModel extends SingleMapper {
  List<FaqModel>? data;
  Meta? meta;

  FaqsModel({
    this.data,
    this.meta,
  });

  FaqsModel.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null
        ? []
        : List<FaqModel>.from(json["data"]!.map((x) => FaqModel.fromJson(x)));
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  @override
  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "meta": meta?.toJson(),
      };

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return FaqsModel.fromJson(json);
  }
}

class FaqModel extends SingleMapper {
  int? id;
  String? question;
  String? answer;

  FaqModel({
    this.id,
    this.question,
    this.answer,
  });

  FaqModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    question = json["question"];
    answer = json["answer"];
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer": answer,
      };

  @override
  Mapper fromJson(Map<String, dynamic> json) {
    return FaqModel.fromJson(json);
  }
}
