import 'package:dartz/dartz.dart';
import 'package:newsify_demo/core/error/exceptions/exceptions.dart';
import 'package:newsify_demo/core/error/failures.dart';
import 'package:newsify_demo/features/news/domain/entities/news_entity.dart';
import 'package:newsify_demo/features/news/domain/repositories/news_repo.dart';

import '../datasources/news_remote_datasource.dart';

/// @author Akshatha

class NewsRepoImpl implements NewsRepo {
  NewsRemoteDataSources newsDatasources;

  NewsRepoImpl({required this.newsDatasources});

  @override
  Future<Either<Failures, NewsEntity>> getNews() async {
    var response = await newsDatasources.getNews();
    if (response is NewsEntity) {
      return Right(response);
    } else {
      response = response as ServerException;
      return Left(ServerFailure(response.errorResponse));
    }
  }
}
