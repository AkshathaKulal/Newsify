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
  List<Object> get props => [itemCount, articles];
}
class NewsFailed extends NewsState {
  dynamic errorResponse;

  NewsFailed(this.errorResponse);

  List<Object?> get props => [errorResponse];
}
class NewsFetching extends NewsState {

  List<Object?> get props => [];
}
