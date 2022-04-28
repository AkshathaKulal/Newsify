import 'package:equatable/equatable.dart';

class SourceEntity extends Equatable {
  String? id;
  String? name;

  SourceEntity({this.id, this.name});

  @override
  List<Object?> get props => [];
}
