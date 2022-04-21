import 'dart:convert';
import 'dart:core';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:newsify_demo/core/utils/constants.dart';
import 'package:newsify_demo/core/utils/styles.dart';
import 'package:newsify_demo/features/news/presentation/pages/news_screen.dart';

import '../../../../core/model/news_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 250,
      backgroundColor: Colors.white,
      color: Colors.black,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        var newsData = await fetchNews();
      },
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppBar(
                  elevation: 0,
                  titleSpacing: 10,
                  leading: const Icon(
                    Icons.newspaper,
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
                      Icons.dark_mode,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(
                      Icons.info,
                      color: Colors.black,
                    ),
                  ]),
            ),
          ),
          body: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  disableCenter: true,
                  aspectRatio: 7,
                ),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'text $i',
                            style: const TextStyle(fontSize: 16.0),
                          ));
                    },
                  );
                }).toList(),
              ),

              FutureBuilder<News>(
                  future: fetchNews(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: ListView.separated(
                              itemCount: snapshot.data!.articles!.length,
                              itemBuilder: (context, index) {
                                var articles = snapshot.data?.articles;
                                return InkWell(
                                  onTap: (){
                                    if(articles![index].content != null) {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>
                                              NewsScreen(
                                                  newsDataLoaded: articles![index]
                                                      .content)));
                                    }else{
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                        content: Text('Thats all the News for you!'),
                                        ),);

                                    }
                                  },
                                  child: Column(children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: const Radius.circular(10),
                                        topRight: const Radius.circular(10),
                                      ),
                                      child: Image.network(articles![index].urlToImage!),
                                    ),
                                    Text(
                                      articles![index].title!,
                                      style: Styles.HEADING,
                                    ),
                                    Text(
                                      articles![index].description!,
                                      style: Styles.SUB_HEADING,
                                    ),
                                  ]),
                                );


                              }, separatorBuilder: (BuildContext context, int index) {
                                return SizedBox(height: 40,);
                          },),
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }),
            ],
          )),
    );
  }
}

Future<News> fetchNews() async {
  final response = await http
      .get(Uri.parse('https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=24802f736c1d41889bb99f0e5b9c8ea2'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print("got 200");
    return News.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
