import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:newsify_demo/features/news/data/datasources/news_remote_datasource.dart';
import 'package:newsify_demo/features/news/data/models/news_model.dart';
import 'package:newsify_demo/features/news/data/repositories/news_repo_impl.dart';
import 'package:newsify_demo/features/news/domain/entities/news_entity.dart';

import '../../../../test_constants.dart';
import 'news_repo_impl_test.mocks.dart';

@GenerateMocks([NewsRemoteDatasourcesImpl])
void main() async {
  NewsRepoImpl? repo;
  var dataSources = MockNewsRemoteDatasourcesImpl();
  setUpAll(() {
    repo = NewsRepoImpl(newsDatasources: dataSources);
  });
  group("Successfully Retrive the data from News Data Repo", () {
    test("Successfully get the news", () async {
      final NewsModel model =
          NewsModel.fromJson(jsonDecode(TestConstants.MOCK_NEWS_RESPONSE));
      final NewsEntity entity = model;
      when(dataSources.getNews()).thenAnswer((_) async {
        return model;
      });
      final result = await repo?.getNews();
      verify(dataSources.getNews());
      expect(result, equals(Right(entity)));
    });
  });
}
