
import 'package:flutter/material.dart';

import 'package:newsify_demo/core/utils/common_mixin.dart';



class NewsScreen extends StatefulWidget {
  final String? newsDataLoaded;
   const NewsScreen({Key? key,this.newsDataLoaded}) : super(key: key);


  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with Commons {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: getCustomAppBar(),
      body: Container(
          alignment: Alignment.centerRight,
          child: SingleChildScrollView(
            child: Container(
              child:  Text(widget.newsDataLoaded ?? "Ojkkhk",
                 style: TextStyle(fontSize: 25.0),
              ),
            ), // your root container
          )),
    );
  }

}