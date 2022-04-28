import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:newsify_demo/core/error/failures.dart';
import 'package:newsify_demo/core/usecase/usecase.dart';
import 'package:newsify_demo/features/news/data/models/news_model.dart';
import 'package:newsify_demo/features/news/domain/entities/news_entity.dart';
import 'package:newsify_demo/features/news/domain/repositories/news_repo.dart';
import 'package:newsify_demo/features/news/domain/usecases/get_news_usecase.dart';

import '../../../../test_constants.dart';
import 'get_news_usecase_test.mocks.dart';

@GenerateMocks([NewsRepo])
void main() async {
  GetNewsUseCase? useCase;
  var repo = MockNewsRepo();

  setUpAll(() {
    useCase = GetNewsUseCase(repo);
  });

  test("Get News Use Case", () async {
    final NewsModel model =
        NewsModel.fromJson(jsonDecode(TestConstants.MOCK_NEWS_RESPONSE));
    final NewsEntity entity = model;
    when(repo.getNews()).thenAnswer((_) async {
      return Right(entity);
    });
    final result = await useCase!(NoParams());
    expect(result, Right(entity));
  });

  test("Get Failure when News Use Case is not fetched ", () async {
    final ServerFailure failure =
    ServerFailure(jsonDecode(TestConstants.ERROR_RESPONSE));
    when(repo.getNews()).thenAnswer((_) async {
      return Left(failure);
    });
    final result = await useCase!(NoParams());
    expect(result, Left(failure));
  });
}
