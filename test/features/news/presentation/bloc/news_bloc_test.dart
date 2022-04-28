import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:newsify_demo/core/controller/ApiClientController.dart';
import 'package:newsify_demo/core/controller/NewsController.dart';
import 'package:newsify_demo/core/network/api_client.dart';
import 'package:newsify_demo/core/utils/api_urls.dart';
import 'package:newsify_demo/core/utils/constants.dart';
import 'package:newsify_demo/features/news/data/datasources/news_remote_datasource.dart';
import 'package:newsify_demo/features/news/data/repositories/news_repo_impl.dart';
import 'package:newsify_demo/features/news/domain/repositories/news_repo.dart';
import 'package:newsify_demo/features/news/domain/usecases/get_news_usecase.dart';
import 'package:newsify_demo/features/news/presentation/bloc/news_bloc.dart';

import '../../../../test_constants.dart';
import '../../data/datasources/news_datasources_test.mocks.dart';

@GenerateMocks([ApiClient, RetryClient])
void main() {
  MockRetryClient mockRetryClient = MockRetryClient();
  var locator = GetIt.instance;

  locator.registerLazySingleton<MockApiClient>(() => MockApiClient());
  locator.registerLazySingleton<NewsRemoteDataSources>(
      () => NewsRemoteDatasourcesImpl(mockRetryClient));
  locator.registerLazySingleton<ApiClientController>(
      () => ApiClientController(apiClient: MockApiClient()));
  locator.registerLazySingleton<NewsController>(() => NewsController());

  locator.registerLazySingleton<NewsRepo>(
      () => NewsRepoImpl(newsDatasources: locator()));
  locator
      .registerLazySingleton<GetNewsUseCase>(() => GetNewsUseCase(locator()));

  group("News Bloc", () {
    test('Initial State is News Initial ', () async {
      expect(NewsBloc().state, isA<NewsInitial>());
    });

    blocTest<NewsBloc, NewsState>(
        'emit NewsFetched once the News is loaded from API',
        build: () {
          when(mockRetryClient.get(Uri.parse(ApiUrl.BASE_URL)))
              .thenAnswer((_) async {
            return http.Response(
                TestConstants.MOCK_NEWS_RESPONSE, Constants.HTTP_OK);
          });
          return NewsBloc();
        },
        act: (bloc) => bloc.add(NewsLoaded()),
        expect: () => [isA<NewsFetched>()]);

    blocTest<NewsBloc, NewsState>(
        'emit NewsFailed once the News is not loaded from API',
        build: () {
          when(mockRetryClient.get(Uri.parse(ApiUrl.BASE_URL)))
              .thenAnswer((_) async {
            return http.Response(
                TestConstants.ERROR_RESPONSE, Constants.HTTP_INTERNAL_ERROR);
          });
          return NewsBloc();
        },
        act: (bloc) => bloc.add(NewsLoaded()),
        expect: () => [isA<NewsFailed>()]);


  blocTest<NewsBloc, NewsState>(
        'emit NewsFetching once screen is refreshed',
        build: () {
          when(mockRetryClient.get(Uri.parse(ApiUrl.BASE_URL)))
              .thenAnswer((_) async {
            return http.Response(
                TestConstants.ERROR_RESPONSE, Constants.HTTP_INTERNAL_ERROR);
          });
          return NewsBloc();
        },
        act: (bloc) => bloc.add(NewsLoading()),
        expect: () => [isA<NewsFetching>()]);
  });
}
