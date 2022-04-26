import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsify_demo/core/controller/NewsController.dart';
import 'package:newsify_demo/injection_container.dart';

import '../../data/models/articles_model.dart';
import '../../data/models/news_model.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<NewsEvent>((event, emit) async {
      if (event is NewsLoading) {
        NewsModel dataNews = await locator.get<NewsController>().getNews();
        int? itemsCount = dataNews.articles?.length;
        List<Articles>? articles = dataNews.articles;
        emit(NewsFetched(itemsCount!, articles!));
      }
    });
  }
}
