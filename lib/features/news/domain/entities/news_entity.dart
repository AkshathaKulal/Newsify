import 'package:equatable/equatable.dart';

import '../../data/models/articles_model.dart';

/// @author Akshatha

class NewsEntity extends Equatable {
  String? status;
  int? totalResults;
  List<Articles>? articles;

  NewsEntity({this.status, this.totalResults, this.articles});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
