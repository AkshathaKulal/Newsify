import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/retry.dart';
import 'package:mockito/annotations.dart';
import 'package:newsify_demo/core/controller/ApiClientController.dart';
import 'package:newsify_demo/core/controller/NewsController.dart';
import 'package:newsify_demo/core/network/api_client.dart';
import 'package:newsify_demo/features/news/data/datasources/news_datasource.dart';
import 'package:newsify_demo/features/news/data/repositories/news_repo_impl.dart';
import 'package:newsify_demo/features/news/domain/repositories/news_repo.dart';
import 'package:newsify_demo/features/news/domain/usecases/get_news_usecase.dart';
import 'package:newsify_demo/features/news/presentation/bloc/news_bloc.dart';

import '../../data/datasources/news_datasources_test.mocks.dart';

@GenerateMocks([ApiClient, RetryClient])
void main() {
  MockRetryClient mockRetryClient = MockRetryClient();
  var locator = GetIt.instance;
  setUpAll(() {
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
  });

  group("News Bloc", () {
    test('Initial State is News Initial ', () async {
      expect(NewsBloc().state, isA<NewsInitial>());
    });

    blocTest<NewsBloc, NewsState>(
        'emit NewsFetched once the News is loaded for API',
        build: () => NewsBloc(),
        act: (bloc) => bloc.add(NewsLoading()),
        expect: () => [isA<NewsFetched>()]);
  });
}
