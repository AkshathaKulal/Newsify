
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:newsify_demo/core/utils/config.dart' as globals;

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(themeData: globals.currentTheme.getThemeData())) {
    on<ThemeEvent>((event, emit) {
      if (event is ThemeChanged) {
        globals.currentTheme.switchTheme();
        emit(ThemeState(themeData: globals.currentTheme.getThemeData()));
      }
    });
  }
}
