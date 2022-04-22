part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class NewsLoading extends NewsEvent{
  @override
  List<Object?> get props => throw UnimplementedError();

}
class NewsLoaded extends NewsEvent{
  @override
  List<Object?> get props => throw UnimplementedError();

}