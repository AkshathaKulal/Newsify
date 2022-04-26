import '../../../../core/error/failures.dart';
import '../entities/news_entity.dart';
import 'package:dartz/dartz.dart';

abstract class NewsRepo {
  Future<Either<Failures, NewsEntity>> getNews();
}
