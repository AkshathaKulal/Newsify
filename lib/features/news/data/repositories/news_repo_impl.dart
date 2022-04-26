import 'package:dartz/dartz.dart';
import 'package:newsify_demo/core/error/exceptions/Exceptions.dart';
import 'package:newsify_demo/core/error/failures.dart';
import 'package:newsify_demo/features/news/data/dataSources/news_datasource.dart';
import 'package:newsify_demo/features/news/domain/entities/news_entity.dart';
import 'package:newsify_demo/features/news/domain/repositories/news_repo.dart';

class NewsRepoImpl implements NewsRepo {
  NewsDataSources newsDatasources;

  NewsRepoImpl(this.newsDatasources);

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
