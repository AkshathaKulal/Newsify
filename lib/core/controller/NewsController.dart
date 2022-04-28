import 'package:newsify_demo/core/error/failures.dart';
import 'package:newsify_demo/core/usecase/usecase.dart';
import 'package:newsify_demo/features/news/domain/usecases/get_news_usecase.dart';

import '../../injection_container.dart';
/// @author Akshatha

class NewsController {
  NewsController();

  Future<dynamic> getNews() async {
    var response = await locator.get<GetNewsUseCase>().call(NoParams());
    return response.fold(
        (error) => (error as ServerFailure).errorResponse, (result) => result);
  }
}
