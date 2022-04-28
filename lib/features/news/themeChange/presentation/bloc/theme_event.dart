part of 'theme_bloc.dart';

/// @author Akshatha

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  List<Object?> get props => [];
}
