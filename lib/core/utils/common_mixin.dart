// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsify_demo/core/utils/dimens.dart';
import 'package:newsify_demo/core/utils/view_utils.dart';
import 'package:newsify_demo/features/news/themeChange/presentation/bloc/theme_bloc.dart';

import 'constants.dart';

/// @author Akshatha

mixin Commons {
  double getWidthAsPerScreenRatio(BuildContext context, double ratio) {
    return (MediaQuery.of(context).size.width * ratio) / 100;
  }

  double getHeightAsPerScreenRatio(BuildContext context, double ratio) {
    return (MediaQuery.of(context).size.height * ratio) / 100;
  }

  Future<void> clearSnackBars(BuildContext context) async {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  PreferredSize getCustomAppBar(
      {required BuildContext context,
      required IconData leadingIcon,
      bool darkMode = true,
      bool backButton = false}) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(Dimens.margin10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppBar(
            elevation: 0,
            titleSpacing: 10,
            leading: InkWell(
              onTap: () {
                if (backButton) {
                  Navigator.pop(context);
                }
              },
              child: Icon(
                leadingIcon,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Constants.APP_NAME,
                    style: Theme.of(context).textTheme.titleLarge),
                Text(Constants.AUTHOR_NAME,
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            actions: [
              (darkMode)
                  ? InkWell(
                      onTap: () {
                        BlocProvider.of<ThemeBloc>(context).add(ThemeChanged());
                      },
                      child: const Icon(
                        Icons.light_mode,
                      ),
                    )
                  : SizedBox(),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  ViewUtils()
                      .callSnackbar(context, "Please refresh for latest news!");
                },
                child: const Icon(
                  Icons.info,
                ),
              ),
            ]),
      ),
    );
  }
}
