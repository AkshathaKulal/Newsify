part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsInitial extends NewsState {
  @override
  List<Object> get props => [];
}

class NewsFetched extends NewsState {
  int itemCount;
  List<Articles> articles;

  NewsFetched(this.itemCount, this.articles);
  @override
  List<Object> get props => [itemCount,articles];
}

class NewsFetching extends NewsState {

  @override
  List<Object> get props => [];
}
