import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:newsify_demo/core/controller/ApiClientController.dart';
import 'package:newsify_demo/core/error/exceptions/exceptions.dart';
import 'package:newsify_demo/core/error/exceptions/internal_exception.dart';
import 'package:newsify_demo/core/network/api_client.dart';
import 'package:newsify_demo/core/utils/api_urls.dart';
import 'package:newsify_demo/core/utils/constants.dart';
import 'package:newsify_demo/features/news/data/datasources/news_remote_datasource.dart';
import 'package:newsify_demo/features/news/data/models/news_model.dart';
import 'package:newsify_demo/injection_container.dart';

import '../../../../test_constants.dart';
import 'news_datasources_test.mocks.dart';

@GenerateMocks([ApiClient, RetryClient])
void main() {
  MockRetryClient mockRetryClient = MockRetryClient();
  setUpAll(() {
    locator.registerLazySingleton<MockApiClient>(() => MockApiClient());
    locator.registerLazySingleton<ApiClientController>(
        () => ApiClientController(apiClient: MockApiClient()));
    when(MockApiClient().getApiClient()).thenAnswer((_) async {
      return mockRetryClient;
    });
    locator.registerLazySingleton<NewsRemoteDatasourcesImpl>(
        () => NewsRemoteDatasourcesImpl(mockRetryClient));
  });

  group("Fetch Data from News API", () {
    test('Successful fetch of Data form API', () async {
      when(mockRetryClient.get(Uri.parse(ApiUrl.BASE_URL)))
          .thenAnswer((_) async {
        return http.Response(
            TestConstants.MOCK_NEWS_RESPONSE, Constants.HTTP_OK);
      });
      var response = await locator.get<NewsRemoteDatasourcesImpl>().getNews();
      expect(response,
          NewsModel.fromJson(jsonDecode(TestConstants.MOCK_NEWS_RESPONSE)));
    });
    test('UnSuccessful fetch of Data form API due to internal error', () async {
      when(mockRetryClient.get(Uri.parse(ApiUrl.BASE_URL)))
          .thenAnswer((_) async {
        return http.Response(
            TestConstants.ERROR_RESPONSE, Constants.HTTP_INTERNAL_ERROR);
      });
      ServerException response =
          await locator.get<NewsRemoteDatasourcesImpl>().getNews();
      expect(response.errorResponse,
          InternalException.fromJson(jsonDecode(TestConstants.ERROR_RESPONSE)));
    });
  });
}
