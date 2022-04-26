import 'package:equatable/equatable.dart';
import '../../data/models/source_model.dart';

class ArticlesEntity extends Equatable {
  Source? SourceEntity;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  ArticlesEntity(
      {this.SourceEntity,
      this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
