import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/news_entity.dart';

/// @author Akshatha

abstract class NewsRepo {
  Future<Either<Failures, NewsEntity>> getNews();
}
