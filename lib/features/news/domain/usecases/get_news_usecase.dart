import 'package:dartz/dartz.dart';
import 'package:newsify_demo/core/error/failures.dart';
import 'package:newsify_demo/core/usecase/usecase.dart';
import 'package:newsify_demo/features/news/domain/entities/news_entity.dart';
import 'package:newsify_demo/features/news/domain/repositories/news_repo.dart';

/// @author Akshatha

class GetNewsUseCase implements UseCase<NewsEntity, NoParams> {
  NewsRepo newsRepo;

  GetNewsUseCase(this.newsRepo);

  @override
  Future<Either<Failures, NewsEntity>> call(NoParams params) async {
    return await newsRepo.getNews();
  }
}
