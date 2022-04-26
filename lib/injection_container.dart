import 'package:get_it/get_it.dart';
import 'package:newsify_demo/core/controller/ApiClientController.dart';
import 'package:newsify_demo/core/controller/NewsController.dart';
import 'package:newsify_demo/core/network/api_client.dart';
import 'package:newsify_demo/features/news/data/dataSources/news_datasource.dart';
import 'package:newsify_demo/features/news/data/repositories/news_repo_impl.dart';
import 'package:newsify_demo/features/news/domain/usecases/get_news_usecase.dart';

import 'features/news/domain/repositories/news_repo.dart';

final locator = GetIt.instance;

Future<void> setUpDependencies() async {
  locator.registerLazySingleton<ApiClient>(() => ApiClient());
  locator
      .registerLazySingleton<ApiClientController>(() => ApiClientController());
  setUpControllers();
}

Future<void> setUpControllers() async {
  var retryClient = await locator.get<ApiClientController>().getClient();
  locator.registerLazySingleton<NewsDataSources>(
      () => NewsDatasourcesImpl(retryClient));
  locator.registerLazySingleton<NewsController>(() => NewsController());
  locator.registerLazySingleton<NewsRepo>(() => NewsRepoImpl(locator()));
  locator
      .registerLazySingleton<GetNewsUseCase>(() => GetNewsUseCase(locator()));
}
