class Meta {
  int? currentPage;
  int? total;
  int? pagesCount;
  int? limit;

  Meta({this.total, this.currentPage, this.pagesCount, this.limit});

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    currentPage = json['current_page'];
    pagesCount = json['last_page'];
    limit = int.tryParse(json['per_page']?.toString() ?? "0");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['current_page'] = currentPage;
    data['last_page'] = pagesCount;
    data['per_page'] = limit;
    return data;
  }
}
