import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/model/news_model.dart';
import 'package:http/http.dart' as http;

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<NewsEvent>((event, emit) async {
      if (event is NewsLoading) {
        emit(NewsFetching());
      }
      else if (event is NewsInitial) {
        News dataNews = await fetchNews();
        int? itemsCount = dataNews.totalResults;
        List<Articles>? articles = dataNews.articles;

        emit(NewsFetched(itemsCount!, articles!));
      }
    });
  }

  Future<News> fetchNews() async {
    final response = await http
        .get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=24802f736c1d41889bb99f0e5b9c8ea2'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("got 200");
      return News.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
