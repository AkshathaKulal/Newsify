import 'package:flutter/material.dart';

import 'package:newsify_demo/core/utils/common_mixin.dart';

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
      appBar:
          getCustomAppBar(context: context, leadingIcon: Icons.arrow_back_ios,darkMode: false,backButton: true),
      body: Container(
          child: SingleChildScrollView(
            child: Text(
              widget.newsDataLoaded ?? "Something Went Wrong!",
              style: Theme.of(context).textTheme.bodyLarge,
            ), // your root container
          )),
    );
  }
}
