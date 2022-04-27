import 'package:get_it/get_it.dart';
import 'package:newsify_demo/core/controller/ApiClientController.dart';
import 'package:newsify_demo/core/controller/NewsController.dart';
import 'package:newsify_demo/core/network/api_client.dart';

import 'package:newsify_demo/features/news/data/repositories/news_repo_impl.dart';
import 'package:newsify_demo/features/news/domain/usecases/get_news_usecase.dart';
import 'package:newsify_demo/features/news/data/datasources/news_remote_datasource.dart';
import 'features/news/domain/repositories/news_repo.dart';

final locator = GetIt.instance;

Future<void> setUpDependencies() async {
  locator.registerLazySingleton<ApiClient>(() => ApiClient());
  locator
      .registerLazySingleton<ApiClientController>(() => ApiClientController());
  locator.registerLazySingleton<NewsController>(() => NewsController());
  setUpControllers();
}

Future<void> setUpControllers() async {
  var retryClient = await locator.get<ApiClientController>().getClient();
  locator.registerLazySingleton<NewsRemoteDataSources>(
      () => NewsRemoteDatasourcesImpl(retryClient));

  locator.registerLazySingleton<NewsRepo>(
      () => NewsRepoImpl(newsDatasources: locator()));
  locator
      .registerLazySingleton<GetNewsUseCase>(() => GetNewsUseCase(locator()));
}
