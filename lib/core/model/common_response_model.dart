class CommonResponse {
  int? code;
  String? message;

  CommonResponse({this.code, this.message});

  CommonResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}
