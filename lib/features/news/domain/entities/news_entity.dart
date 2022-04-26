import 'package:equatable/equatable.dart';
import 'package:newsify_demo/features/news/domain/entities/article_entity.dart';

import '../../data/models/articles_model.dart';
import '../../data/models/news_model.dart';

class NewsEntity extends Equatable{
  String? status;
  int? totalResults;
  List<Articles>? articles;

  NewsEntity({this.status, this.totalResults, this.articles});

  @override
  // TODO: implement props
  List<Object?> get props =>[];

}
