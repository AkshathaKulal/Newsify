import 'package:newsify_demo/core/utils/constants.dart';
import 'package:newsify_demo/features/news/themeChange/presentation/bloc/theme_bloc.dart';
import 'core/utils/config.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsify_demo/features/news/presentation/bloc/news_bloc.dart';
import 'package:newsify_demo/features/news/presentation/pages/dashboard_screen.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'injection_container.dart';

/// @author Akshatha

void main() async {
  await Hive.initFlutter();
  globals.box = await Hive.openBox(Constants.THEME_BOX_TAG);
  await setUpDependencies().whenComplete(() => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => NewsBloc()),
            BlocProvider(create: (_) => ThemeBloc()),
          ],
          child: const DashboardScreen(),
        ));
  }
}
