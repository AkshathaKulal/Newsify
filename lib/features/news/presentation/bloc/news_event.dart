part of 'news_bloc.dart';

/// @author Akshatha

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class NewsLoaded extends NewsEvent {
  @override
  List<Object?> get props => [];
}

class NewsLoading extends NewsEvent {
  @override
  List<Object?> get props => [];
}
