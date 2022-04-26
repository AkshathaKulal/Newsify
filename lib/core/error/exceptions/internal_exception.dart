import 'package:equatable/equatable.dart';

class InternalException extends Equatable {
  int? code;
  String? message;

  InternalException({this.code, this.message});

  InternalException.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }

  @override
  List<Object?> get props => [];
}
