// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:newsify_demo/core/utils/styles.dart';

import 'constants.dart';

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

  PreferredSize getCustomAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppBar(
            elevation: 0,
            titleSpacing: 10,
            leading: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(Constants.APP_NAME, style: Styles.TITLE),
                Text(Constants.AUTHOR_NAME, style: Styles.SUB_TITLE),
              ],
            ),
            actions: [
              const Icon(
                Icons.info,
                color: Colors.black,
              ),
            ]),
      ),
    );
  }
}
