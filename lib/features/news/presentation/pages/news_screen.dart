import 'package:flutter/material.dart';

import 'package:newsify_demo/core/utils/common_mixin.dart';
import 'package:newsify_demo/core/utils/dimens.dart';

import '../../../../core/utils/constants.dart';

/// @author Akshatha

class NewsScreen extends StatefulWidget {
  final String? newsDataLoaded;

  const NewsScreen({Key? key, this.newsDataLoaded}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with Commons {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(
          context: context,
          leadingIcon: Icons.arrow_back_ios,
          darkMode: false,
          backButton: true),
      body: SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.margin10),
      child: Text(
        widget.newsDataLoaded ?? Constants.ERROR_MSG,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
        ), // your root container
      ),
    );
  }
}
